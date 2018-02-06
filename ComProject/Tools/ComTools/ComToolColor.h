//
//  ComToolColor.h
//  ComProject
//
//  Created by 陈园 on 2017/9/30.
//  Copyright © 2017年 陈园. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ComColor) {
    ComColorRed = 0xe83c36,
    ComColorWhite = 0xffffff,
    ComColorLightWhite = 0xf3f3f3,
    ComColorGray = 0x999999,
    ComColorDarkGray = 0xc7c7c7,
    ComColorLightGray = 0xe2e2e2,
    ComColorBlack = 0x000000,
    ComColorDeepBlack = 0x333333,
    ComColorDarkBlack = 0x444444,
    ComColorLightBlack = 0x666666,
};



@interface ComToolColor : NSObject

/** 根据string获取颜色*/
+(UIColor *)getColorWithHexString: (NSString *)color Alpha:(float)alpha;

/** 根据枚举值获取固定颜色*/
+(UIColor *)getColorWithComColor:(ComColor)color alpha:(CGFloat)alpha;

/** 根据ComColor枚举值获取对应的16进制字符串*/
+(NSString *)getColorValueWithComColor:(ComColor)color;

@end
