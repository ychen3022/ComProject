//
//  NSDate+Ext.h
//  项目模板
//
//  Created by ychen on 16/10/8.
//  Copyright © 2016年 ComProject. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Ext)

/**
 *  比较from和self的时间差值
 */
-(NSDateComponents *)compareFrom:(NSDate *)from;

/**
 *  是否是今年
 */
-(BOOL)isThisYear;

/**
* 是否是今天
*/
-(BOOL)isToday;

/**
*  是否是昨天
*/
-(BOOL)isYestorday;

@end
