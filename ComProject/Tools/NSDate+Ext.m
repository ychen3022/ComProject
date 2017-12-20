//
//  NSDate+Ext.m
//  项目模板
//
//  Created by ychen on 16/10/8.
//  Copyright © 2016年 ComProject. All rights reserved.
//

#import "NSDate+Ext.h"

@implementation NSDate (Ext)

#pragma mark -比较from和self的时间差值
-(NSDateComponents *)compareFrom:(NSDate *)from{
    //日历
    NSCalendar *calendar=[NSCalendar currentCalendar];
    //比较时间
    NSCalendarUnit unit=NSCalendarUnitDay|NSCalendarUnitMonth|NSCalendarUnitYear|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond;
    return [calendar components:unit fromDate:from toDate:self options:0];
}



#pragma mark -是否是今年
-(BOOL)isThisYear{
    //日历
    NSCalendar *calendar=[NSCalendar currentCalendar];
    NSInteger nowYear=[calendar component:NSCalendarUnitYear fromDate:[NSDate date]];
    NSInteger selfYear=[calendar component:NSCalendarUnitYear fromDate:self];
    return nowYear==selfYear;
}



#pragma mark -是否是今天
-(BOOL)isToday{
    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
    formatter.dateFormat=@"yyyy-MM-dd";
    NSString *nowString=[formatter stringFromDate:[NSDate date]];
    NSString *selfString=[formatter stringFromDate:self];
    return [nowString isEqualToString:selfString];
}


#pragma mark -是否是昨天
-(BOOL)isYestorday{
    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
    formatter.dateFormat=@"yyyy-MM-dd";
    NSDate *nowDate=[formatter dateFromString:[formatter stringFromDate:[NSDate date]]];
    NSDate *selfDate=[formatter dateFromString:[formatter stringFromDate:self]];
    
    NSCalendar *calendar=[NSCalendar currentCalendar];
    NSDateComponents *cmps=[calendar components:NSCalendarUnitDay|NSCalendarUnitMonth|NSCalendarUnitYear fromDate:selfDate toDate:nowDate options:0];
    return cmps.year==0 && cmps.month==0 && cmps.day==1;
}
@end
