//
//  ComToolColor.m
//  ComProject
//
//  Created by 陈园 on 2017/9/30.
//  Copyright © 2017年 陈园. All rights reserved.
//

#import "ComToolColor.h"


@implementation ComToolColor

#pragma mark -根据string获取颜色
+(UIColor *)getColorWithHexString: (NSString *)color Alpha:(float)alpha{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:alpha];
}

#pragma mark -根据枚举值获取固定颜色
+(UIColor *)getColorWithComColor:(ComColor)color alpha:(CGFloat)alpha{
    if (color == ComColorBlack) {
        return [self getColorWithHexString:@"0x000000" Alpha:alpha];
    }
    return [self getColorWithHexString:[NSString stringWithFormat:@"%lx", (unsigned long)color] Alpha:alpha];
}

#pragma mark -根据ComColor枚举值获取对应的16进制字符串
+(NSString *)getColorValueWithComColor:(ComColor)color{
    if (color == ComColorBlack) {
        return @"0x000000";
    }
    return [NSString stringWithFormat:@"%lx", (unsigned long)color];
}

@end
