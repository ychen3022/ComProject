//
//  ComLoadingView.h
//  ComProject
//
//  Created by 陈园 on 2018/2/1.
//  Copyright © 2018年 陈园. All rights reserved.
//

#import "ComLoadingViewStyle.h"



typedef void(^LoadingTimeOutBlock)(void);
typedef void(^LoadingDismissBlock)(void);



@interface ComLoadingView : UIView
/** loadingView的父视图,默认是窗口*/
@property(nonatomic,weak)UIView *superView;
/** loadingView是否自动消失*/
@property(nonatomic,assign)BOOL isAutoDismiss;
/** loadingView正常消失后block*/
@property(nonatomic,copy)LoadingDismissBlock dismissBlock;
/** loadingView超时消失后block*/
@property(nonatomic,copy)LoadingTimeOutBlock loadingTimeOutBlock;

/** 初始化loadingView*/
-(instancetype)initWithMessage:(NSString *)message LoadingImage:(UIImage *)image Frame:(CGRect)frame;
-(instancetype)initWithMessage:(NSString *)message LoadingImageArray:(NSArray *)images Frame:(CGRect)frame;
-(instancetype)initWithLoadingImage:(UIImage *)image Frame:(CGRect)frame;
-(instancetype)initWithLoadingImageArray:(NSArray *)images Frame:(CGRect)frame;
- (void)showWithAnimated:(BOOL)animated;
- (void)dismiss;
- (void)dismissWithCompletionBlock:(LoadingDismissBlock)block;

/** 从窗体上查找存在的ComLoadingView*/
+(ComLoadingView *)getCurrentLoadingViewFromWindow;
/** 从指定的视图中查找存在的ComLoadingView*/
+(ComLoadingView *)getCurrentLoadingViewFromSuperView:(UIView *)superView;

@end
