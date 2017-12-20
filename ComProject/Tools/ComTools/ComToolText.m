//
//  ComToolText.m
//  ComProject
//
//  Created by 陈园 on 2017/9/30.
//  Copyright © 2017年 陈园. All rights reserved.
//

#import "ComToolText.h"

@implementation ComToolText

#pragma mark -根据枚举值获取固定字体大小
+(UIFont *)getFontWithComFont:(ComFont)font{
    return [UIFont systemFontOfSize:font/2];
}

#pragma mark -计算对应字体的默认行间距
+(CGFloat)caculateFontLineSpace:(UIFont *)font{
    if (font) {
        return font.lineHeight - font.pointSize;
    }else{
        return 0;
    }
}

#pragma mark -根据字体大小、最大范围,计算内容大小
+(CGSize)caculateTextSizeWithContent:(NSString *)contentStr Scope:(CGSize)scopeSize Font:(UIFont *)font{
    NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName,nil];
    CGSize  actualsize;
    actualsize =[contentStr boundingRectWithSize:scopeSize options:NSStringDrawingUsesLineFragmentOrigin  attributes:tdic context:nil].size;
    actualsize.width +=1;
    actualsize.height +=1;
    return actualsize;
}

#pragma mark -根据字体大小、最大范围、行间距,计算内容大小
+(CGSize)caculateTextSizeWithContent:(NSString *)contentStr Scope:(CGSize)scopeSize Font:(UIFont *)font ParagraphStyle:(NSMutableParagraphStyle *)paragraphStyle{
    NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName,paragraphStyle,NSParagraphStyleAttributeName,nil];
    CGSize  actualsize;
    actualsize =[contentStr boundingRectWithSize:scopeSize options:NSStringDrawingUsesLineFragmentOrigin  attributes:tdic context:nil].size;
    actualsize.width +=1;
    actualsize.height +=1;
    if (actualsize.height * 0.75 > font.lineHeight + paragraphStyle.lineSpacing) {
        return actualsize;
    }else{
        actualsize.height -= paragraphStyle.lineSpacing;
    }
    return actualsize;
}

#pragma mark -根据文字的宽度计算高度
+(CGSize)calculateTextHeightWithContent:(NSString *)contentStr Font:(UIFont *)font maxW:(CGFloat)maxW{
    NSMutableDictionary *attrDic=[NSMutableDictionary dictionary];
    attrDic[NSFontAttributeName]=font;
    CGSize maxSize=CGSizeMake(maxW, MAXFLOAT);
    return [contentStr boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrDic context:nil].size;
}

#pragma mark -根据文字的高度计算宽度
+(CGSize)calculateTextWidthWithContent:(NSString *)contentStr Font:(UIFont *)font maxH:(CGFloat)maxH{
    NSMutableDictionary *attrDic=[NSMutableDictionary dictionary];
    attrDic[NSFontAttributeName]=font;
    CGSize maxSize=CGSizeMake(MAXFLOAT, maxH);
    return [contentStr boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrDic context:nil].size;
}

#pragma mark -判断是否是空字符串
+(BOOL)isBlankString:(NSString *)string{
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([string isKindOfClass:[NSString class]]) {
        if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
            return YES;
        }
    }
    return NO;
}

@end
