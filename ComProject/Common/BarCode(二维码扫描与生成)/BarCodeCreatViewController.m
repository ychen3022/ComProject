//
//  BarCodeCreatViewController.m
//  二维码生成与扫描
//
//  Created by ychen on 16/12/21.
//  Copyright © 2016年 ychen. All rights reserved.
//

#import "BarCodeCreatViewController.h"
#import "BarCodeColorModel.h"
#import "UIImage+BarCodeCustom.h"

#define screen_H [UIScreen mainScreen].bounds.size.height
#define screen_W [UIScreen mainScreen].bounds.size.width

@interface BarCodeCreatViewController ()

@property(nonatomic,strong)UIImageView *imageView;
@end

@implementation BarCodeCreatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    
    self.imageView=[[UIImageView alloc] initWithFrame:CGRectMake(30, 100,screen_W-60 ,screen_W-60 )];
    [self.view addSubview:self.imageView];
    
    self.imageView.image= [self creatColorfulBarCode];
}


#pragma mark -默认的制作二维码方法  较模糊
-(void)creatBarCode1{
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // 2.恢复默认
    [filter setDefaults];
    // 3.给过滤器添加数据
    NSString *dataString = @"这是我制作的二维码";
    NSData *data = [dataString dataUsingEncoding:NSUTF8StringEncoding];
    // 4.通过KVO设置滤镜inputMessage数据
    [filter setValue:data forKeyPath:@"inputMessage"];
    // 4.获取输出的二维码
    CIImage *outputImage = [filter outputImage];
    // 5.将CIImage转换成UIImage，并放大显示
    self.imageView.image = [UIImage imageWithCIImage:outputImage scale:20.0 orientation:UIImageOrientationUp];
}


#pragma mark -制作清晰二维码方法
-(void)creatBarCode2{
    // 1.创建过滤器
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // 2.恢复默认
    [filter setDefaults];
    // 3.给过滤器添加数据(正则表达式/账号和密码)
    NSString *dataString = @"这是我制作的二维码";
    NSData *data = [dataString dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:data forKeyPath:@"inputMessage"];
    // 4.获取输出的二维码
    CIImage *outputImage = [filter outputImage];
    // 5.将CIImage转换成UIImage，并放大显示
    self.imageView.image = [self createNonInterpolatedUIImageFormCIImage:outputImage withSize:screen_W-60];
}


/**
 * 根据CIImage生成指定大小的UIImage
 *
 * @param image CIImage
 * @param size 图片宽度
 */
- (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat)size{
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}


#pragma mark -设计多样式的二维码图片
-(UIImage *)creatColorfulBarCode{
    //设置二维码的barCodeSize
    CGFloat codeSize = [self checkBarCodeImageSize:0];
    
    //绘制二维码图片
    CIImage *barCodeImage = [self creatBarCodeWithContentStr:@"这是我制作的二维码"];
    
    //调整清晰度，制作清晰的二维码
    UIImage *originImage = [self adjustClarityImageFromCIImage:barCodeImage size:codeSize];
    
    //修改二维码的背景颜色
    UIImage *resultImage1=[UIImage generateImageWithOrginImage:originImage customBackgroundColor:@"#ee68ba"];
    
    //根据fillImage替换颜色
    UIImage *reFillImage=[UIImage colorRedrawWithColor1:@"#1dacea" color2:@"#2d9f7c" fillImage:[UIImage imageNamed:@"fillImage1"]];
    
    //根据reFillImage设置二维码颜色
    UIImage *resultImage2=[UIImage generateColorfulImageWithOrginImage:originImage reFillImage:reFillImage];
    
    //插入logo图片
    UIImage *resultImage3=[UIImage generateImageWithOriginImage:resultImage2 insertImage:[UIImage imageNamed:@"logo1.jpg"] radius:25.0];
    
    //添加背景图片
    UIImage *resultImage4=[UIImage generateImageWithOriginImage:resultImage3 backgroundImage:[UIImage imageNamed:@"backImage"]];
    
    return resultImage4;
}


/**
 检查二维码尺寸是否符合规定
 
 @param size 尺寸
 @return 返回合适的二维码尺寸
 */
- (CGFloat)checkBarCodeImageSize:(CGFloat)size{
    size = (size==0)?1024:size;
    size = MAX(200, size);
    return size;
}



/**
 绘制二维码图片
 
 @param contentStr 二维码内容
 @return 返回根据文字制作的二维码
 */
- (CIImage *)creatBarCodeWithContentStr: (NSString *)contentStr{
    
    NSData *data = [contentStr dataUsingEncoding: NSUTF8StringEncoding];
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [filter setDefaults];
    [filter setValue:data forKey:@"inputMessage"];
    [filter setValue:@"M" forKey:@"inputCorrectionLevel"];
    CIImage *outputImage = [filter outputImage];
    return outputImage;
}



/**
 调整清晰度，使其更加清晰
 
 @param image 需要调整的图片
 @param size 设置图片的size
 @return 返回处理后的图片
 */
- (UIImage *)adjustClarityImageFromCIImage: (CIImage *)image size: (CGFloat)size{
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceGray();
    
    CGContextRef contextRef = CGBitmapContextCreate(nil, width, height, 8, 0, colorSpaceRef,(CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef imageRef = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(contextRef, kCGInterpolationNone);
    CGContextScaleCTM(contextRef, scale, scale);
    CGContextDrawImage(contextRef, extent, imageRef);
    CGImageRef imageRefResized = CGBitmapContextCreateImage(contextRef);
    
    UIImage*tempIMage=[UIImage imageWithCGImage:imageRefResized];
    
    //释放
    CGContextRelease(contextRef);
    CGImageRelease(imageRef);
    CGColorSpaceRelease(colorSpaceRef);
    CGImageRelease(imageRefResized);
    return tempIMage;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}






@end
