//
//  UIImage+BarCodeCustom.h
//  二维码生成与扫描
//
//  Created by ychen on 16/12/22.
//  Copyright © 2016年 ychen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (BarCodeCustom)


/**
 改变二维码的背景颜色
 
 @param orginImage 原始照片
 @param rgbValue 背景色
 @return 返回处理后的照片
 */
+(UIImage *)generateImageWithOrginImage:(UIImage *)orginImage customBackgroundColor:(NSString *)rgbValue;



/**
 替换填充图片颜色

 @param color1 颜色1
 @param color2 颜色2
 @param fillImage 填充图片
 @return 返回修改后的填充图片
 */
+(UIImage *)colorRedrawWithColor1:(NSString *)color1 color2:(NSString *)color2 fillImage:(UIImage *)fillImage;



/**
 根据reFillImage替换二维码图片颜色

 @param orginImage 原始照片
 @param reFillImage 重绘后的reFillImage照片
 @return 处理后的二维码照片
 */
+ (UIImage *)generateColorfulImageWithOrginImage:(UIImage *)orginImage reFillImage:(UIImage *)reFillImage;



/**
 向二维码图片插入logo图片

 @param originImage 二维码原图
 @param insertImage 插入的logo图片
 @param radius logo图片的圆角
 @return 返回处理后的图片
 */
+ (UIImage *)generateImageWithOriginImage:(UIImage *)originImage insertImage:(UIImage *)insertImage radius:(CGFloat)radius;



/**
 为二维码图片添加背景图片

 @param originImage 原始二维码图片
 @param backgroundImage 背景图片
 @return 返回处理后的图片
 */
+ (UIImage *)generateImageWithOriginImage:(UIImage *)originImage backgroundImage:(UIImage *)backgroundImage;



/**
 *  生成圆角图片
 *
 *  @param image  图片
 *  @param size   尺寸
 *  @param radius 角度
 *
 *  @return 图片
 */
+ (UIImage *)generateRoundedCornersWithImage:(UIImage *)image size:(CGSize)size radius:(CGFloat)radius;

@end
