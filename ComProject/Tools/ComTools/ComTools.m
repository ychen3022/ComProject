//
//  ComTools.m
//  ComProject
//
//  Created by 陈园 on 2017/9/30.
//  Copyright © 2017年 陈园. All rights reserved.
//

#import "ComTools.h"

@implementation ComTools

#pragma mark -颜色
+(UIColor *)getColorWithHexString:(NSString *)color{
    return [ComToolColor getColorWithHexString:color Alpha:1.0];
}

+(UIColor *)getColorWithHexString:(NSString *)color Alpha:(float)alpha{
    return [ComToolColor getColorWithHexString:color Alpha:alpha];
}

+(UIColor *)getColorWithComColor:(ComColor)color{
    return [ComToolColor getColorWithComColor:color alpha:1.0];
}

+(UIColor *)getColorWithComColor:(ComColor)color alpha:(CGFloat)alpha{
    return [ComToolColor getColorWithComColor:color alpha:alpha];
}

+(NSString *)getColorValueWithComColor:(ComColor)color{
    return [ComToolColor getColorValueWithComColor:color];
}



#pragma mark -文字
+(UIFont *)getFontWithComFont:(ComFont)font{
    return [ComToolText getFontWithComFont:font];
}

+(CGFloat)getFontLineSpaceWithFont:(UIFont *)font{
    return [ComToolText caculateFontLineSpace:font];
}

+(CGSize)getTextSizeWithContent:(NSString *)contentStr Scope:(CGSize)scopeSize Font:(UIFont *)font{
    return [ComToolText caculateTextSizeWithContent:contentStr Scope:scopeSize Font:font];
}

+(CGSize)getTextSizeWithContent:(NSString *)contentStr Scope:(CGSize)scopeSize Font:(UIFont *)font ParagraphStyle:(NSMutableParagraphStyle *)paragraphStyle{
    return [ComToolText caculateTextSizeWithContent:contentStr Scope:scopeSize Font:font ParagraphStyle:paragraphStyle];
}

+(CGSize)getTextHeightWithContent:(NSString *)contentStr Font:(UIFont *)font maxW:(CGFloat)maxW{
    return [ComToolText calculateTextHeightWithContent:contentStr Font:font maxW:maxW];
}

+(CGSize)getTextWidthWithContent:(NSString *)contentStr Font:(UIFont *)font maxH:(CGFloat)maxH{
    return [ComToolText calculateTextWidthWithContent:contentStr Font:font maxH:maxH];
}

+(BOOL)isBlankString:(NSString *)string{
    return [ComToolText isBlankString:string];
}



#pragma mark -图形
+(CGFloat )getCornerRadiusWithComCR:(ComCR)radius{
    return [ComToolView getCornerRadiusWithComCR:radius];
}

+(UIImage *)getImageWithColor:(UIColor *)color Size:(CGSize)size{
    return [ComToolView createImageWithColor:color Size:size];
}

+(void)getCycleSharpWithView:(UIView *)view{
    [ComToolView creatCycleSharpWithView:view];
}



#pragma mark -其他
+ (UIViewController *)getCurrentViewController{
    return [ComToolsOther getCurrentViewController];
}


@end
