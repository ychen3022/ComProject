//
//  ComAlertDialogTool.h
//  ComProject
//
//  Created by 陈园 on 2018/2/1.
//  Copyright © 2018年 陈园. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ComAlertViewStyle.h"
#import "ComAlertView.h"
#import "ComToastViewStyle.h"
#import "ComToastView.h"
#import "ComLoadingViewStyle.h"
#import "ComLoadingView.h"



@interface ComAlertDialogTool : NSObject
#pragma mark -alertView
/** 配置alertView样式*/
+(void)configAlertViewStyle:(AlertColorStyle)colorStyle;
+(void)configAlertViewStyleByConfigBlock:(ComAlertViewStyleConfigBlock)styleConfigBlock;
/** 显示alertView弹框*/
+(ComAlertView *)showAS1_Message:(NSString *)message;
+(ComAlertView *)showAS2_Message:(NSString *)message okButtonTitle:(NSString *)okTitle okAction:(AlertButtonItemHandler)okAction;
+(ComAlertView *)showAS3_Message:(NSString *)message okButtonTitle:(NSString *)okTitle okAction:(AlertButtonItemHandler)okAction cancelButtonTitle:(NSString *)cancelTitle cancelAction:(AlertButtonItemHandler)cancelAction;
+(ComAlertView *)showAS4_Title:(NSString *)title message:(NSString *)message okButtonTitle:(NSString *)okTitle okAction:(AlertButtonItemHandler)okAction;
+(ComAlertView *)showAS5_Title:(NSString *)title message:(NSString *)message okButtonTitle:(NSString *)okTitle okAction:(AlertButtonItemHandler)okAction cancelButtonTitle:(NSString *)cancelTitle cancelAction:(AlertButtonItemHandler)cancelAction;
+(ComAlertView *)showAS6_Title:(NSString *)title message:(NSString *)message okButtonTitle:(NSString *)okTitle okAction:(AlertButtonItemHandler)okAction cancelButtonTitle:(NSString *)cancelTitle cancelAction:(AlertButtonItemHandler)cancelAction otherButtonTitle:(NSString *)otherTitle otherAction:(AlertButtonItemHandler)otherAction;
+(ComAlertView *)showAS7_TopImage:(NSString *)imageName Title:(NSString *)title message:(NSString *)message okButtonTitle:(NSString *)okTitle okAction:(AlertButtonItemHandler)okAction;
+(ComAlertView *)showAS8_TopImage:(NSString *)imageName Title:(NSString *)title message:(NSString *)message okButtonTitle:(NSString *)okTitle okAction:(AlertButtonItemHandler)okAction cancelButtonTitle:(NSString *)cancelTitle cancelAction:(AlertButtonItemHandler)cancelAction;



#pragma mark -toastView
/** 配置toastView样式*/
+(void)configToastViewStyle:(ToastColorStyle)colorStyle;
+(void)configToastViewStyleByConfigBlock:(ComToastViewStyleConfigBlock)styleConfigBlock;
/** 显示toastView弹框*/
+(void)showToastWithMessage:(NSString *)message;
+(void)showToastWithMessage:(NSString *)message dismissAfter:(CGFloat)seconds;
+(void)showToastWithMessage:(NSString *)message dismissAfter:(CGFloat)seconds dismissBlock:(ToastDismissBlock)dismissblock;



#pragma mark -loadingView
/** 配置loadingView样式*/
+(void)configLoadingViewStyle:(LoadingImageStyle)imageStyle;
+(void)configLoadingViewStyleByConfigBlock:(ComLoadingViewStyleConfigBlock)styleConfigBlock;
/** 显示loadingView弹框*/
+(void)showLoadingViewWithMessage:(NSString *)message;//除非主动dismiss，否则超时才会消失
+(void)showLoadingViewWithMessage:(NSString *)message TimeOutBlcok:(LoadingTimeOutBlock)block;//除非主动dismiss，否则超时才会消失
+(void)showLoadingViewWithMessage:(NSString *)message TimeOutBlcok:(LoadingTimeOutBlock)block InView:(UIView *)superView;//除非主动dismiss,否则超时才会消失,带超时回调block
+(void)dismissLoadingView;//窗体消失
+(void)dismissLoadingViewWithDismissBlock:(LoadingDismissBlock)block;//窗体消失,带消失动画完成回调block
+(void)dismissLoadingViewInView:(UIView *)superView DismissBlock:(LoadingDismissBlock)block;//视图消失,带消失动画完成回调block
+(void)showSuccessAlertViewWithMessage:(NSString *)message;//窗体显示成功弹出层,会自动消失
+(void)showSuccessAlertViewWithMessage:(NSString *)message DismissBlock:(LoadingDismissBlock)block;//带自动消失后回调block
+(void)showFailedAlertViewWithMessage:(NSString *)message;//窗体显示失败弹出层,会自动消失
+(void)showFailedAlertViewWithMessage:(NSString *)message DissmissBlock:(LoadingDismissBlock)block;//带自动消失后回调block



/** 判断指定tag的ComAlertView子类是否正在窗体上*/
+(BOOL)isSpecialAlertViewAlreadyOnWindow:(NSInteger)alertViewTag;
/** 一连串的例子展示*/
+(void)showDemo;
@end
