//
//  ComTools.h
//  ComProject
//
//  Created by 陈园 on 2017/9/30.
//  Copyright © 2017年 陈园. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CLLocation.h>
#import "ComToolsMacros.h"
#import "ComToolColor.h"
#import "ComToolText.h"
#import "ComToolView.h"
#import "ComToolsOther.h"


@interface ComTools : NSObject

/** 颜色 */
+(UIColor *)getColorWithHexString:(NSString *)color;
+(UIColor *)getColorWithHexString:(NSString *)color Alpha:(float)alpha;
+(UIColor *)getColorWithComColor:(ComColor)color;
+(UIColor *)getColorWithComColor:(ComColor)color alpha:(CGFloat)alpha;
+(NSString *)getColorValueWithComColor:(ComColor)color;



/** 文字*/
+(UIFont *)getFontWithComFont:(ComFont)font;
+(CGFloat)getFontLineSpaceWithFont:(UIFont *)font;
+(CGSize)getTextSizeWithContent:(NSString *)contentStr Scope:(CGSize)scopeSize Font:(UIFont *)font;
+(CGSize)getTextSizeWithContent:(NSString *)contentStr Scope:(CGSize)scopeSize Font:(UIFont *)font ParagraphStyle:(NSMutableParagraphStyle *)paragraphStyle;
+(CGSize)getTextHeightWithContent:(NSString *)contentStr Font:(UIFont *)font maxW:(CGFloat)maxW;
+(CGSize)getTextWidthWithContent:(NSString *)contentStr Font:(UIFont *)font maxH:(CGFloat)maxH;
+(BOOL)isBlankString:(NSString *)string;



/** 图形*/
+(CGFloat )getCornerRadiusWithComCR:(ComCR)radius;
+(UIImage *)getImageWithColor:(UIColor *)color Size:(CGSize)size;
+(void)getCycleSharpWithView:(UIView *)view;



/** 其他*/
+ (UIViewController *)getCurrentViewController;


@end
