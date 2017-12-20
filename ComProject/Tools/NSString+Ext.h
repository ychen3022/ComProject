//
//  NSString+Ext.h
//  项目模板
//
//  Created by ychen on 16/10/8.
//  Copyright © 2016年 ComProject. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Ext)

/**
 *  计算文字的高度
 *
 *  @param text 文字
 *  @param font 字体大小
 *  @param maxW size的宽度
 *
 *  @return 包含文字宽度和高度的size
 */
-(CGSize)calculateTextHeightWithFont:(UIFont *)font maxW:(CGFloat)maxW;



/**
 *  计算文字的宽度
 *
 *  @param text 文字
 *  @param font 字体大小
 *  @param maxW size的高度
 *
 *  @return 包含文字宽度和高度的size
 */
-(CGSize)calculateTextWidthWithFont:(UIFont *)font maxH:(CGFloat)maxH;
@end
