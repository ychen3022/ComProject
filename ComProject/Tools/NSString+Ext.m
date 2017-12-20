//
//  NSString+Ext.m
//  项目模板
//
//  Created by ychen on 16/10/8.
//  Copyright © 2016年 ComProject. All rights reserved.
//

#import "NSString+Ext.h"

@implementation NSString (Ext)

#pragma mark -计算文字的高度
-(CGSize)calculateTextHeightWithFont:(UIFont *)font maxW:(CGFloat)maxW{
    NSMutableDictionary *attrDic=[NSMutableDictionary dictionary];
    attrDic[NSFontAttributeName]=font;
    CGSize maxSize=CGSizeMake(maxW, MAXFLOAT);
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrDic context:nil].size;
}



#pragma mark -计算文字的宽度
-(CGSize)calculateTextWidthWithFont:(UIFont *)font maxH:(CGFloat)maxH{
    NSMutableDictionary *attrDic=[NSMutableDictionary dictionary];
    attrDic[NSFontAttributeName]=font;
    CGSize maxSize=CGSizeMake(MAXFLOAT, maxH);
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrDic context:nil].size;
}

@end
