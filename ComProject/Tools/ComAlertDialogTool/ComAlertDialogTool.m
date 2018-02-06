//
//  ComAlertDialogTool.m
//  ComProject
//
//  Created by 陈园 on 2018/2/1.
//  Copyright © 2018年 陈园. All rights reserved.
//

#import "ComAlertDialogTool.h"
#import "ComTools.h"


@implementation ComAlertDialogTool

#pragma mark -配置alertView样式
+(void)configAlertViewStyle:(AlertColorStyle)colorStyle{
    [[ComAlertViewStyle sharedInstance] configAlertColorStyle:colorStyle styleConfigBlock:nil];
}
+(void)configAlertViewStyleByConfigBlock:(ComAlertViewStyleConfigBlock)styleConfigBlock{
    [[ComAlertViewStyle sharedInstance] configAlertColorStyle:AlertColorStyle_Custom styleConfigBlock:styleConfigBlock];
}

#pragma mark - 显示弹框AS1
+(ComAlertView *)showAS1_Message:(NSString *)message{
    ComAlertView *alertView = [self creatBaseAlertView_TopImage:nil Title:nil message:message okButtonTitle:nil okAction:nil cancelButtonTitle:nil cancelAction:nil otherButtonTitle:nil otherAction:nil];
    alertView.isToastStyle = YES;
    alertView.seconds = 3;
    alertView.dismissBlock = ^{
        NSLog(@"dismissBlock生效");
    };
    return alertView;
}
#pragma mark - 显示弹框AS2
+(ComAlertView *)showAS2_Message:(NSString *)message okButtonTitle:(NSString *)okTitle okAction:(AlertButtonItemHandler)okAction{
    ComAlertView *alertView = [self creatBaseAlertView_TopImage:nil Title:nil message:message okButtonTitle:okTitle okAction:okAction cancelButtonTitle:nil cancelAction:nil otherButtonTitle:nil otherAction:nil];
    return alertView;
}
#pragma mark - 显示弹框AS3
+(ComAlertView *)showAS3_Message:(NSString *)message okButtonTitle:(NSString *)okTitle okAction:(AlertButtonItemHandler)okAction cancelButtonTitle:(NSString *)cancelTitle cancelAction:(AlertButtonItemHandler)cancelAction{
    ComAlertView *alertView = [self creatBaseAlertView_TopImage:nil Title:nil message:message okButtonTitle:okTitle okAction:okAction cancelButtonTitle:cancelTitle cancelAction:cancelAction otherButtonTitle:nil otherAction:nil];
    return alertView;
}
#pragma mark - 显示弹框AS4
+(ComAlertView *)showAS4_Title:(NSString *)title message:(NSString *)message okButtonTitle:(NSString *)okTitle okAction:(AlertButtonItemHandler)okAction{
    ComAlertView *alertView = [self creatBaseAlertView_TopImage:nil Title:title message:message okButtonTitle:okTitle okAction:okAction cancelButtonTitle:nil cancelAction:nil otherButtonTitle:nil otherAction:nil];
    return alertView;
}
#pragma mark - 显示弹框AS5
+(ComAlertView *)showAS5_Title:(NSString *)title message:(NSString *)message okButtonTitle:(NSString *)okTitle okAction:(AlertButtonItemHandler)okAction cancelButtonTitle:(NSString *)cancelTitle cancelAction:(AlertButtonItemHandler)cancelAction{
    ComAlertView *alertView = [self creatBaseAlertView_TopImage:nil Title:title message:message okButtonTitle:okTitle okAction:okAction cancelButtonTitle:cancelTitle cancelAction:cancelAction otherButtonTitle:nil otherAction:nil];
    return alertView;
}
#pragma mark - 显示弹框AS6
+(ComAlertView *)showAS6_Title:(NSString *)title message:(NSString *)message okButtonTitle:(NSString *)okTitle okAction:(AlertButtonItemHandler)okAction cancelButtonTitle:(NSString *)cancelTitle cancelAction:(AlertButtonItemHandler)cancelAction otherButtonTitle:(NSString *)otherTitle otherAction:(AlertButtonItemHandler)otherAction{
    ComAlertView *alertView = [self creatBaseAlertView_TopImage:nil Title:title message:message okButtonTitle:okTitle okAction:okAction cancelButtonTitle:cancelTitle cancelAction:cancelAction otherButtonTitle:otherTitle otherAction:otherAction];
    return alertView;
}
#pragma mark - 显示弹框AS7
+(ComAlertView *)showAS7_TopImage:(NSString *)imageName Title:(NSString *)title message:(NSString *)message okButtonTitle:(NSString *)okTitle okAction:(AlertButtonItemHandler)okAction{
    ComAlertView *alertView = [self creatBaseAlertView_TopImage:imageName Title:title message:message okButtonTitle:okTitle okAction:okAction cancelButtonTitle:nil cancelAction:nil otherButtonTitle:nil otherAction:nil];
    return alertView;
}
#pragma mark - 显示弹框AS8
+(ComAlertView *)showAS8_TopImage:(NSString *)imageName Title:(NSString *)title message:(NSString *)message okButtonTitle:(NSString *)okTitle okAction:(AlertButtonItemHandler)okAction cancelButtonTitle:(NSString *)cancelTitle cancelAction:(AlertButtonItemHandler)cancelAction{
    ComAlertView *alertView = [self creatBaseAlertView_TopImage:imageName Title:title message:message okButtonTitle:okTitle okAction:okAction cancelButtonTitle:cancelTitle cancelAction:cancelAction otherButtonTitle:nil otherAction:nil];
    return alertView;
}
#pragma mark - 创建基础弹出层
+(ComAlertView *)creatBaseAlertView_TopImage:(NSString *)imageName Title:(NSString *)title message:(NSString *)message okButtonTitle:(NSString *)okTitle okAction:(AlertButtonItemHandler)okAction cancelButtonTitle:(NSString *)cancelTitle cancelAction:(AlertButtonItemHandler)cancelAction otherButtonTitle:(NSString *)otherTitle otherAction:(AlertButtonItemHandler)otherAction{
    ComAlertView *alertView;
    if ([ComTools isBlankString:imageName]) {
        alertView = [[ComAlertView alloc] initWithTitle:title message:message topImageName:nil];
    }else{
        alertView = [[ComAlertView alloc] initWithTitle:title message:message topImageName:imageName];
    }
    if (![ComTools isBlankString:cancelTitle]) {
        [alertView addButton:AlertButton_CANCEL withTitle:cancelTitle handler:cancelAction];
    }
    if (![ComTools isBlankString:otherTitle]) {
        [alertView addButton:AlertButton_OTHER withTitle:otherTitle handler:otherAction];
    }
    if (![ComTools isBlankString:okTitle]) {
        [alertView addButton:AlertButton_OK withTitle:okTitle handler:okAction];
    }
    return alertView;
}



#pragma mark - 配置toastView样式
+(void)configToastViewStyle:(ToastColorStyle)colorStyle{
    [[ComToastViewStyle sharedInstance] configToastColorStyle:colorStyle styleConfigBlock:nil];
}
+(void)configToastViewStyleByConfigBlock:(ComToastViewStyleConfigBlock)styleConfigBlock{
    [[ComToastViewStyle sharedInstance] configToastColorStyle:ToastColorStyle_Custom styleConfigBlock:styleConfigBlock];
}

#pragma mark - 显示提示语弹框:message
+(void)showToastWithMessage:(NSString *)message{
    return [self showToastWithMessage:message dismissAfter:1.5];
}
#pragma mark - 显示提示语弹框:message、seconds
+(void)showToastWithMessage:(NSString *)message dismissAfter:(CGFloat)seconds {
    if ([ComTools isBlankString:message]) {
        NSLog(@"showToast message is empty...");
        return;
    }
    ComToastView *toastView = [[ComToastView alloc] initMessage:message];
    toastView.isTapShadowDismiss = YES;
    toastView.seconds = seconds;
    [toastView show];
}
#pragma mark - 显示提示语弹框:message、seconds、dismissBlock
+(void)showToastWithMessage:(NSString *)message dismissAfter:(CGFloat)seconds dismissBlock:(ToastDismissBlock)dismissblock {
    if ([ComTools isBlankString:message]) {
        NSLog(@"showToast message is empty...");
        return;
    }
    ComToastView *toastView = [[ComToastView alloc] initMessage:message];
    toastView.isTapShadowDismiss = NO;
    toastView.toastDismissBlock = dismissblock;
    toastView.seconds = seconds;
    [toastView show];
}



#pragma mark - 配置loadingView样式
+(void)configLoadingViewStyle:(LoadingImageStyle)imageStyle{
    [[ComLoadingViewStyle sharedInstance] configLoadingImageStyle:imageStyle styleConfigBlock:nil];
}
+(void)configLoadingViewStyleByConfigBlock:(ComLoadingViewStyleConfigBlock)styleConfigBlock{
    [[ComLoadingViewStyle sharedInstance] configLoadingImageStyle:LoadingImageStyle_Custom styleConfigBlock:styleConfigBlock];
}

#pragma mark - 显示loadingView弹框:需主动dismiss,否则超时才会消失
+(void)showLoadingViewWithMessage:(NSString *)message{
    if ([ComLoadingView getCurrentLoadingViewFromWindow]) {
        [[ComLoadingView getCurrentLoadingViewFromWindow] dismiss];
        [self creatLoadingViewWithMessage:message timeOutBlock:nil animated:NO];
    }else{
       [self creatLoadingViewWithMessage:message timeOutBlock:nil animated:YES];
    }
}
#pragma mark - 显示loadingView弹框:带超时消失block,需主动dismiss,否则超时才会消失
+(void)showLoadingViewWithMessage:(NSString *)message TimeOutBlcok:(LoadingTimeOutBlock)block{
    if ([ComLoadingView getCurrentLoadingViewFromWindow]) {
        [[ComLoadingView getCurrentLoadingViewFromWindow] dismiss];
        [self creatLoadingViewWithMessage:message timeOutBlock:block animated:NO];
    }else{
         [self creatLoadingViewWithMessage:message timeOutBlock:block animated:YES];
    }
}
#pragma mark - 显示loadingView弹框:有父视图,带超时消失block,需主动dismiss,否则超时才会消失
+(void)showLoadingViewWithMessage:(NSString *)message TimeOutBlcok:(LoadingTimeOutBlock)block InView:(UIView *)superView{
    if ([ComLoadingView getCurrentLoadingViewFromSuperView:superView]) {
        [[ComLoadingView getCurrentLoadingViewFromSuperView:superView] dismiss];
        [self creatLoadingViewWithSuperView:superView Message:message timeOutBlock:block animated:NO];
    }else{
        [self creatLoadingViewWithSuperView:superView Message:message timeOutBlock:block animated:YES];
    }
}
#pragma mark - loadingView弹框消失
+(void)dismissLoadingView{
    ComLoadingView *loadingView = [ComLoadingView getCurrentLoadingViewFromWindow];
    if (loadingView) {
        [loadingView dismissWithCompletionBlock:nil];
    }
}
#pragma mark - loadingView弹框消失,带消失block
+(void)dismissLoadingViewWithDismissBlock:(LoadingDismissBlock)block{
    ComLoadingView *loadingView = [ComLoadingView getCurrentLoadingViewFromWindow];
    if (loadingView) {
        [loadingView dismissWithCompletionBlock:block];
    }
}
#pragma mark - loadingView弹框从父视图消失,带消失block
+(void)dismissLoadingViewInView:(UIView *)superView DismissBlock:(LoadingDismissBlock)block{
    ComLoadingView *loadingView = [ComLoadingView getCurrentLoadingViewFromSuperView:superView];
    if (loadingView) {
        [loadingView dismissWithCompletionBlock:block];
    }
}
#pragma mark - 显示成功提示弹框
+(void)showSuccessAlertViewWithMessage:(NSString *)message{
    if ([ComLoadingView getCurrentLoadingViewFromWindow]) {
        [[ComLoadingView getCurrentLoadingViewFromWindow] dismiss];
        [self creatSuccessLoadingViewWithMessage:message AutoDissmissBlock:nil animated:NO];
    }else{
        [self creatSuccessLoadingViewWithMessage:message AutoDissmissBlock:nil animated:YES];
    }
}
#pragma mark - 显示成功提示弹框,带消失block
+(void)showSuccessAlertViewWithMessage:(NSString *)message DismissBlock:(LoadingDismissBlock)block{
    if ([ComLoadingView getCurrentLoadingViewFromWindow]) {
        [[ComLoadingView getCurrentLoadingViewFromWindow] dismiss];
        [self creatSuccessLoadingViewWithMessage:message AutoDissmissBlock:block animated:NO];
    }else{
        [self creatSuccessLoadingViewWithMessage:message AutoDissmissBlock:block animated:YES];
    }
}
#pragma mark - 显示失败提示弹框
+(void)showFailedAlertViewWithMessage:(NSString *)message{
    if ([ComLoadingView getCurrentLoadingViewFromWindow]) {
        [[ComLoadingView getCurrentLoadingViewFromWindow] dismiss];
        [self creatFailedLoadingViewWithMessage:message AutoDissmissBlock:nil animated:NO];
    }else{
        [self creatFailedLoadingViewWithMessage:message AutoDissmissBlock:nil animated:YES];
    }
}
#pragma mark - 显示失败提示弹框,带消失block
+(void)showFailedAlertViewWithMessage:(NSString *)message DissmissBlock:(LoadingDismissBlock)block{
    if ([ComLoadingView getCurrentLoadingViewFromWindow]) {
        [[ComLoadingView getCurrentLoadingViewFromWindow] dismiss];
        [self creatFailedLoadingViewWithMessage:message AutoDissmissBlock:block animated:NO];
    }else{
        [self creatFailedLoadingViewWithMessage:message AutoDissmissBlock:block animated:YES];
    }
}
#pragma mark - 创建基础loadingView:无父视图
+(void)creatLoadingViewWithMessage:(NSString *)message timeOutBlock:(LoadingTimeOutBlock)block animated:(BOOL)animated{
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    ComLoadingView *loadingView;
    if ([ComTools isBlankString:message]) {
        NSArray *loadImgArr = [ComLoadingViewStyle sharedInstance].loadingImageArr;
        loadingView = [[ComLoadingView alloc] initWithLoadingImageArray:loadImgArr Frame:window.frame];
    }else{
        NSArray *loadImgArr = [ComLoadingViewStyle sharedInstance].loadingImageArr;
        loadingView = [[ComLoadingView alloc] initWithMessage:message LoadingImageArray:loadImgArr Frame:window.frame];
    }
    if (block) {
        [loadingView setLoadingTimeOutBlock:block];
    }
    [loadingView showWithAnimated:animated];
}
#pragma mark - 创建基础loadingView:有父视图
+(void)creatLoadingViewWithSuperView:(UIView *)superView Message:(NSString *)message timeOutBlock:(LoadingTimeOutBlock)block animated:(BOOL)animated{
    ComLoadingView *loadingView;
    if ([ComTools isBlankString:message]) {
        NSArray *loadImgArr = [ComLoadingViewStyle sharedInstance].loadingImageArr;
        loadingView = [[ComLoadingView alloc] initWithLoadingImageArray:loadImgArr Frame:superView.bounds];
    }else{
        NSArray *loadImgArr = [ComLoadingViewStyle sharedInstance].loadingImageArr;
        loadingView = [[ComLoadingView alloc] initWithMessage:message LoadingImageArray:loadImgArr Frame:superView.bounds];
    }
    loadingView.superView = superView;
    if (block) {
        [loadingView setLoadingTimeOutBlock:block];
    }
    [loadingView showWithAnimated:animated];
}
#pragma mark - 创建基础成功提示图
+(void)creatSuccessLoadingViewWithMessage:(NSString *)message AutoDissmissBlock:(LoadingDismissBlock)block animated:(BOOL)animated{
    UIImage *success_image = [UIImage imageNamed:@"reminder"];
    CGRect frame = [UIScreen mainScreen].bounds;
    ComLoadingView *loadingView;
    if ([ComTools isBlankString:message]) {
        loadingView = [[ComLoadingView alloc] initWithLoadingImage:success_image Frame:frame];
    }else{
        loadingView = [[ComLoadingView alloc] initWithMessage:message LoadingImage:success_image Frame:frame];
    }
    loadingView.isAutoDismiss = YES;
    loadingView.dismissBlock = block;
    [loadingView showWithAnimated:animated];
}
#pragma mark - 创建基础失败提示图
+(void)creatFailedLoadingViewWithMessage:(NSString *)message AutoDissmissBlock:(LoadingDismissBlock)block animated:(BOOL)animated{
    UIImage *fail_image = [UIImage imageNamed:@"reminder"];
    CGRect frame = [UIScreen mainScreen].bounds;
    ComLoadingView *loadingView;
    if ([ComTools isBlankString:message]) {
        loadingView = [[ComLoadingView alloc] initWithLoadingImage:fail_image Frame:frame];
    }else{
        loadingView = [[ComLoadingView alloc] initWithMessage:message LoadingImage:fail_image Frame:frame];
    }
    loadingView.isAutoDismiss = YES;
    loadingView.dismissBlock = block;
    [loadingView showWithAnimated:animated];
}



#pragma mark - 判断指定tag的ComAlertView子类是否正在窗体上
+(BOOL)isSpecialAlertViewAlreadyOnWindow:(NSInteger)alertViewTag{
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    UIView *targetView = [window viewWithTag:alertViewTag];
    if (targetView) {
        if ([targetView isKindOfClass:[ComAlertView class]]) {
            return YES;
        }
    }
    return NO;
}



#pragma mark - 一连串的例子展示
+(void)showDemo{
    [ComAlertDialogTool showToastWithMessage:@"这里是toastView的样式" dismissAfter:2.0 dismissBlock:^{
        [[ComAlertDialogTool showAS8_TopImage:@"reminder" Title:@"AS8的样式" message:@"这里是提示内容这里是提示内容这里是提示内容这里是提示内容这里是提示内容这里是提示内容这里是提示内容这里是提示内容" okButtonTitle:@"确定" okAction:^(AlertButtonItem *item) {
            [[ComAlertDialogTool showAS7_TopImage:@"reminder" Title:@"AS7的样式" message:@"这里是提示内容这里是提示内容这里是提示内容这里是提示内容这里是提示内容这里是提示内容这里是提示内容这里是提示内容" okButtonTitle:@"确定" okAction:^(AlertButtonItem *item) {
                [[ComAlertDialogTool showAS6_Title:@"AS6的样式" message:@"这里是提示内容这里是提示内容这里是提示内容这里是提示内容这里是提示内容这里是提示内容这里是提示内容这里是提示内容" okButtonTitle:@"确定" okAction:^(AlertButtonItem *item) {
                    [[ComAlertDialogTool showAS5_Title:@"AS5的样式" message:@"这里是提示内容这里是提示内容这里是提示内容这里是提示内容这里是提示内容这里是提示内容这里是提示内容这里是提示内容" okButtonTitle:@"确定" okAction:^(AlertButtonItem *item) {
                        [[ComAlertDialogTool showAS4_Title:@"AS4的样式" message:@"这里是提示内容这里是提示内容这里是提示内容这里是提示内容这里是提示内容这里是提示内容这里是提示内容这里是提示内容" okButtonTitle:@"知道了" okAction:^(AlertButtonItem *item) {
                            [[ComAlertDialogTool showAS3_Message:@"AS3的样式\n这里是提示内容这里是提示内容这里是提示内容这里是提示内容这里是提示内容这里是提示内容这里是提示内容这里是提示内容" okButtonTitle:@"确定" okAction:^(AlertButtonItem *item) {
                                [[ComAlertDialogTool showAS2_Message:@"AS2的样式\n这里是提示内容这里是提示内容这里是提示内容这里是提示内容这里是提示内容这里是提示内容这里是提示内容这里是提示内容" okButtonTitle:@"知道了" okAction:^(AlertButtonItem *item) {
                                    [[ComAlertDialogTool showAS1_Message:@"AS1的样式\n这里是提示内容这里是提示内容这里是提示内容这里是提示内容这里是提示内容这里是提示内容这里是提示内容这里是提示内容这里是提示内容"] show];
                                }] show];
                            } cancelButtonTitle:@"取消" cancelAction:^(AlertButtonItem *item) {
                            }] show];
                        }] show];
                    } cancelButtonTitle:@"取消" cancelAction:^(AlertButtonItem *item) {
                        
                    }] show];
                } cancelButtonTitle:@"取消" cancelAction:^(AlertButtonItem *item) {
                } otherButtonTitle:@"其他" otherAction:^(AlertButtonItem *item) {
                }] show];
            }] show];
        } cancelButtonTitle:@"取消" cancelAction:^(AlertButtonItem *item) {
        }] show];
    }];
}
@end

