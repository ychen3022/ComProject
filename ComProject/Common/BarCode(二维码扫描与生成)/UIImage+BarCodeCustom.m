//
//  UIImage+BarCodeCustom.m
//  二维码生成与扫描
//
//  Created by ychen on 16/12/22.
//  Copyright © 2016年 ychen. All rights reserved.
//

#import "UIImage+BarCodeCustom.h"
#import <CoreImage/CoreImage.h>
#import "BarCodeColorModel.h"

@implementation UIImage (BarCodeCustom)

#pragma mark -改变二维码的颜色
+(UIImage *)generateImageWithOrginImage:(UIImage *)orginImage customBackgroundColor:(NSString *)rgbValue{
    if(orginImage == nil) return nil;
    __block BarCodeColorModel *barCodeColorModel;
    [self colorValue:rgbValue rgbBlock:^(BarCodeColorModel *colorModel) {
        barCodeColorModel = colorModel;
    }];
    
    //颜色不能太淡
    NSUInteger rgb = (barCodeColorModel.red << 16) + (barCodeColorModel.green << 8) + barCodeColorModel.blue;
    //断言色值高于0xfefefe00的色值为白色，避免颜色太过于接近白色
    NSAssert((rgb & 0xffffff00) <= 0xfefefe00, @"The color of QR code is two close to white color than it will diffculty to scan");
    UIImage *resultImage=[self imageFillBlackColorAndTransparent:orginImage colorModel1:barCodeColorModel colorModel2:nil isFill:nil];
    return resultImage;
}

//色值转换
+(void)colorValue:(NSString *)rgbValue rgbBlock:(void(^)(BarCodeColorModel *colorModel))rgbBlock{
    BarCodeColorModel *model = [[BarCodeColorModel alloc]init];
    NSMutableString *mutableRBGString = [NSMutableString stringWithString:rgbValue];
    // 转换成标准16进制数
    [mutableRBGString replaceCharactersInRange:[mutableRBGString rangeOfString:@"#" ] withString:@"0x"];
    // 十六进制字符串转成整形。
    long colorLong = strtoul([mutableRBGString cStringUsingEncoding:NSUTF8StringEncoding], 0, 16);
    // 通过位与方法获取三色值
    model.red = (colorLong & 0xFF0000 )>>16;
    model.green = (colorLong & 0x00FF00 )>>8;
    model.blue =  colorLong & 0x0000FF;
    
    if (rgbBlock) {
        rgbBlock(model);
    }
}


+ (UIImage *)imageFillBlackColorAndTransparent:(UIImage *)image colorModel1:(BarCodeColorModel *)colorModel1 colorModel2:(BarCodeColorModel *)colorModel2 isFill:(BOOL)isFill
{
    // 分配内存
    const int imageWidth = image.size.width;
    const int imageHeight = image.size.height;
    size_t bytesPerRow = imageWidth * 4;
    uint32_t * rgbImageBuf = (uint32_t *)malloc(bytesPerRow * imageHeight);
    
    // 创建context
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(rgbImageBuf, imageWidth, imageHeight, 8, bytesPerRow, colorSpace, kCGBitmapByteOrder32Little | kCGImageAlphaNoneSkipLast);
    CGContextDrawImage(context, (CGRect){(CGPointZero), (image.size)}, image.CGImage);
    
    //遍历像素
    int pixelNumber = imageHeight * imageWidth;
    
    [self fillWhiteToTransparentOnPixel:rgbImageBuf pixelNum:pixelNumber colorModel1:colorModel1 colorModel2:colorModel2 isFill:isFill];
    
    //将内存转成image
    CGDataProviderRef dataProvider = CGDataProviderCreateWithData(NULL, rgbImageBuf, bytesPerRow, ProviderReleaseData);
    CGImageRef imageRef = CGImageCreate(imageWidth, imageHeight, 8, 32, bytesPerRow, colorSpace, kCGImageAlphaLast | kCGBitmapByteOrder32Little, dataProvider, NULL, true, kCGRenderingIntentDefault);
    UIImage * resultImage = [UIImage imageWithCGImage: imageRef];
    
    //释放内存
    CGImageRelease(imageRef);
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(context);
    CGDataProviderRelease(dataProvider);
    return resultImage;
    
}


+ (void)fillWhiteToTransparentOnPixel: (uint32_t *)rgbImageBuf pixelNum: (int)pixelNum colorModel1:(BarCodeColorModel *)colorModel1 colorModel2:(BarCodeColorModel *)colorModel2 isFill:(BOOL)isFill{
    uint32_t * pCurPtr = rgbImageBuf;
    for (int i = 0; i < pixelNum; i++, pCurPtr++) {
        if (isFill){
            if (!((*pCurPtr & 0xffffff00) < 0xfefefe00)) {
                uint8_t * ptr = (uint8_t *)pCurPtr;
                ptr[0] = 0;
            }
        }else{
            if ((*pCurPtr & 0xffffff00) < 0xfefefe00) {
                uint8_t * ptr = (uint8_t *)pCurPtr;
                if (colorModel1) {
                    ptr[3] = colorModel1.red;
                    ptr[2] = colorModel1.green;
                    ptr[1] = colorModel1.blue;
                }else{
                    ptr[0] = 0;
                }
            } else{
                //将其他像素变成透明色
                uint8_t * ptr = (uint8_t *)pCurPtr;
                if (colorModel2) {
                    ptr[3] = colorModel2.red;
                    ptr[2] = colorModel2.green;
                    ptr[1] = colorModel2.blue;
                }else{
                    ptr[0] = 0;
                }
            }
        }
    }
}


/**
 *  颜色变化
 */
void ProviderReleaseData(void * info, const void * data, size_t size) {
    free((void *)data);
}


#pragma mark -替换填充图片颜色
+(UIImage *)colorRedrawWithColor1:(NSString *)color1 color2:(NSString *)color2 fillImage:(UIImage *)fillImage{
    if (!color1 || !color2) return fillImage;
    
    __block BarCodeColorModel *colorModel1 = nil;
    __block BarCodeColorModel *colorModel2 = nil;
    
    [self colorValue:color1 rgbBlock:^(BarCodeColorModel *colorModel) {
        colorModel1 = colorModel;
    }];
    [self colorValue:color2 rgbBlock:^(BarCodeColorModel *colorModel) {
        colorModel2 = colorModel;
    }];
    UIImage *resultImage = [self imageFillBlackColorAndTransparent:fillImage colorModel1:colorModel1 colorModel2:colorModel2 isFill:NO];
    return resultImage;
}


#pragma mark -根据reFillImage替换二维码颜色
+ (UIImage *)generateColorfulImageWithOrginImage:(UIImage *)orginImage reFillImage:(UIImage *)reFillImage{
    if (!orginImage || (NSNull *)orginImage == [NSNull null]) return nil;
    if (!reFillImage || (NSNull *)reFillImage == [NSNull null]) return orginImage;
    
    BarCodeColorModel *colorModel2 = [[BarCodeColorModel alloc]init];
    colorModel2.red = 255;
    colorModel2.green = 255;
    colorModel2.blue = 255;
    //二维码黑色部分变成透明
    UIImage *transparentQrImage = [self imageFillBlackColorAndTransparent:orginImage colorModel1:nil colorModel2:colorModel2 isFill:NO];
    //图像合成
    UIImage *syntheticImage = [self imageSyntheticWithQrImage:transparentQrImage fillImage:reFillImage];
    
    UIImage *result = [self imageFillBlackColorAndTransparent:syntheticImage colorModel1:nil colorModel2:nil isFill:YES];
    
    return result;
}


//图像合成
+ (UIImage *)imageSyntheticWithQrImage:(UIImage *)qrImage fillImage:(UIImage *)fillImage{
    
    UIGraphicsBeginImageContext(qrImage.size);
    [fillImage drawInRect:CGRectMake(0, 0, qrImage.size.width, qrImage.size.height)];
    [qrImage drawInRect:CGRectMake(0, 0, qrImage.size.width, qrImage.size.height)];
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultingImage;
}





#pragma mark -向二维码插入logo图片
+ (UIImage *)generateImageWithOriginImage:(UIImage *)originImage
                             insertImage:(UIImage *)insertImage
                                  radius:(CGFloat)radius{
    
    if (!insertImage) return originImage;
    insertImage = [UIImage generateRoundedCornersWithImage:insertImage size:insertImage.size radius:radius];
    
    UIImage * whiteBG = [UIImage imageNamed:@"whiteBG"];
    whiteBG = [UIImage generateRoundedCornersWithImage:whiteBG size:whiteBG.size radius:radius];
    const CGFloat whiteSize = 2.f;
    CGSize brinkSize = CGSizeMake(originImage.size.width / 5, originImage.size.height / 5);
    CGFloat brinkX = (originImage.size.width - brinkSize.width) * 0.5;
    CGFloat brinkY = (originImage.size.height - brinkSize.height) * 0.5;
    CGSize imageSize = CGSizeMake(brinkSize.width - 2 * whiteSize, brinkSize.height - 2 * whiteSize);
    CGFloat imageX = brinkX + whiteSize;
    CGFloat imageY = brinkY + whiteSize;
    UIGraphicsBeginImageContext(originImage.size);
    [originImage drawInRect: (CGRect){ 0, 0, (originImage.size) }];
    [whiteBG drawInRect: (CGRect){ brinkX, brinkY, (brinkSize) }];
    [insertImage drawInRect: (CGRect){ imageX, imageY, (imageSize) }];
    UIImage * resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultImage;
}



#pragma mark -生成圆角图片
+ (UIImage *)generateRoundedCornersWithImage:(UIImage *)image size:(CGSize)size radius:(CGFloat)radius{
    
    if (!image)return nil;
    
    const CGFloat width = size.width;
    const CGFloat height = size.height;
    
    radius = MAX(5.f, radius);
    radius = MIN(10.f, radius);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL, width, height, 8, 4 * width, colorSpace, kCGImageAlphaPremultipliedFirst);
    CGRect rect = CGRectMake(0, 0, width, height);
    CGContextBeginPath(context);
    addRoundRectToPath(context, rect, radius, image.CGImage);
    CGImageRef imageMasked = CGBitmapContextCreateImage(context);
    UIImage * img = [UIImage imageWithCGImage: imageMasked];
    
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(imageMasked);
    
    return img;
}



//给上下文添加圆角蒙版
void addRoundRectToPath(CGContextRef context, CGRect rect, float radius, CGImageRef image){
    
    float width, height;
    if (radius == 0) {
        CGContextAddRect(context, rect);
        return;
    }
    
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, CGRectGetMinX(rect), CGRectGetMinY(rect));
    width = CGRectGetWidth(rect);
    height = CGRectGetHeight(rect);
    
    //裁剪路径
    CGContextMoveToPoint(context, width, height / 2);
    CGContextAddArcToPoint(context, width, height, width / 2, height, radius);
    CGContextAddArcToPoint(context, 0, height, 0, height / 2, radius);
    CGContextAddArcToPoint(context, 0, 0, width / 2, 0, radius);
    CGContextAddArcToPoint(context, width, 0, width, height / 2, radius);
    CGContextClosePath(context);
    CGContextClip(context);
    
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), image);
    CGContextRestoreGState(context);
}



#pragma mark -为二维码添加背景图片
+ (UIImage *)generateImageWithOriginImage:(UIImage *)originImage backgroundImage:(UIImage *)backgroundImage{
    
    CGFloat whiteSize = 115.f;
    if (!backgroundImage) {
        backgroundImage = [UIImage imageNamed:@"whiteBG"];
        whiteSize = 0;
    };
    
    CGSize imageSize = CGSizeMake(backgroundImage.size.width - 2 * whiteSize, backgroundImage.size.height - 2 * whiteSize);
    CGFloat imageX = whiteSize;
    CGFloat imageY = whiteSize;
    UIGraphicsBeginImageContext(backgroundImage.size);
    [backgroundImage drawInRect: (CGRect){ 0, 0, (backgroundImage.size) }];
    [originImage drawInRect: (CGRect){ imageX, imageY, (imageSize) }];
    UIImage * resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return resultImage;
}
@end
