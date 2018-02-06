//
//  ComToolText.h
//  ComProject
//
//  Created by 陈园 on 2017/9/30.
//  Copyright © 2017年 陈园. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ComFont) {
    ComFont1 = 36,
    ComFont2 = 34,
    ComFont3 = 32,
    ComFont4 = 30,
    ComFont5 = 28,
    ComFont6 = 24
};

@interface ComToolText : NSObject

/** 根据枚举值获取固定字体大小*/
+(UIFont *)getFontWithComFont:(ComFont)font;

/** 计算对应字体的默认行间距*/
+(CGFloat)caculateFontLineSpace:(UIFont *)font;

/** 根据字体大小、最大范围,计算内容大小*/
+(CGSize)caculateTextSizeWithContent:(NSString *)contentStr Scope:(CGSize)scopeSize Font:(UIFont *)font;

/** 根据字体大小、最大范围、行间距,计算内容大小*/
+(CGSize)caculateTextSizeWithContent:(NSString *)contentStr Scope:(CGSize)scopeSize Font:(UIFont *)font ParagraphStyle:(NSMutableParagraphStyle *)paragraphStyle;

/** 根据文字的宽度计算高度*/
+(CGSize)calculateTextHeightWithContent:(NSString *)contentStr Font:(UIFont *)font maxW:(CGFloat)maxW;

/** 根据文字的高度计算宽度*/
+(CGSize)calculateTextWidthWithContent:(NSString *)contentStr Font:(UIFont *)font maxH:(CGFloat)maxH;

/** 判断是否是空字符串*/
+(BOOL)isBlankString:(NSString *)string;


@end
