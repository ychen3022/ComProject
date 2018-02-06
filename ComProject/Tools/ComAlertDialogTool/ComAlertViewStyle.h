//
//  ComAlertViewStyle.h
//  ComProject
//
//  Created by 陈园 on 2018/1/26.
//  Copyright © 2018年 陈园. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ComAlertViewStyle;



typedef NS_ENUM(NSInteger, AlertColorStyle) {
    AlertColorStyle_Custom = 0,     //自定义
    AlertColorStyle_Red = 1,        //红色
    AlertColorStyle_System = 2      //系统
};

/** 设置ComAlertViewStyle样式block*/
typedef void(^ComAlertViewStyleConfigBlock)(ComAlertViewStyle *alertViewStyle);



@interface ComAlertViewStyle : NSObject
@property (nonatomic, strong) UIColor *labelTitleColor;//title字体颜色
@property (nonatomic, strong) UIColor *labelMessageColor;//message字体颜色
@property (nonatomic, strong) UIColor *buttonOkColor;//ok按钮字体颜色
@property (nonatomic, strong) UIColor *buttonCancelColor;//cancel按钮字体颜色
@property (nonatomic, strong) UIColor *buttonOtherColor;//other按钮字体颜色

//单例方法
+(instancetype)sharedInstance;

/** 设置alertView的颜色样式*/
/** 当style为AlertColorStyle_Custom时，block中对单例ComAlertViewStyle的配置才会生效*/
-(void)configAlertColorStyle:(AlertColorStyle)colorStyle styleConfigBlock:(ComAlertViewStyleConfigBlock)styleConfigBlock;

/** 获取当前alertView颜色样式*/
-(AlertColorStyle)getCurrentAlertColorStyle;

@end
