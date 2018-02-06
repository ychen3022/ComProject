//
//  ComToastViewStyle.h
//  ComProject
//
//  Created by 陈园 on 2018/2/1.
//  Copyright © 2018年 陈园. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ComToastViewStyle;


typedef NS_ENUM(NSInteger, ToastColorStyle) {
    ToastColorStyle_Custom = 0,     //自定义
    ToastColorStyle_White = 1,      //白色窗体
    ToastColorStyle_Black = 2       //黑色窗体
};

/** 设置ComToastViewStyle样式block*/
typedef void(^ComToastViewStyleConfigBlock)(ComToastViewStyle *toastViewStyle);



@interface ComToastViewStyle : NSObject
@property (nonatomic, strong) UIColor *coverColor;//浮层颜色
@property (nonatomic, strong) UIColor *windowColor;//窗体颜色
@property (nonatomic, strong) UIColor *messageColor;//字体颜色

//单例方法
+(instancetype)sharedInstance;

/** 设置toastView的颜色样式*/
/** 当style为ToastColorStyle_Custom时，block中对单例ComToastViewStyle的配置才会生效*/
-(void)configToastColorStyle:(ToastColorStyle)colorStyle styleConfigBlock:(ComToastViewStyleConfigBlock)styleConfigBlock;

/** 获取当前toastView颜色样式*/
-(ToastColorStyle)getCurrentToastColorStyle;

@end


