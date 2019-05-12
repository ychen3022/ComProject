//
//  ComBaseViewController.h
//  ComProject
//
//  Created by 陈园 on 2017/9/28.
//  Copyright © 2017年 陈园. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ComBaseViewController : UIViewController

/** 获取页面各类bar的高度*/
-(CGFloat)statusBarHeight;
-(CGFloat)navBarHeight;
-(CGFloat)topBarHeight;
-(CGFloat)tabBarHeight;



/** 设置页面statusBar的颜色*/
- (void)setStatusBarBackgroundColor:(UIColor *)color;



/** 设置navBar中间标题*/
-(void)initNavigationTitleViewWithTitle:(NSString *)title;
-(void)initNavigationTitleViewWithImage:(NSString *)imageName;
-(void)initNavigationTitleViewTextFieldWithLeftImage:(NSString *)leftImgName PlaceHolderText:(NSString *)placeHolder Delegate:(id)textFieldDelegate;



/** 设置navBar左侧(返回)按钮*/
-(void)initNavigationLeftButtonBack;
-(void)initNavigationLeftButtonBackWithTitle:(NSString *)title;
-(void)initNavigationLeftButtonBackWithTitle:(NSString *)title imageName:(NSString *)imageName titleColor:(NSString *)titleColor;
-(void)backTo;



/** 自定义navBar左侧(非返回)按钮*/
-(void)initNavigationLeftButtonWithTitle:(NSString *)title TitleColor:(UIColor *)titleColor Image:(NSString *)imageName;
-(void)doNavigationLeftBtnAction;



/** 自定义navBar右侧按钮*/
-(void)initNavigationRightButtonWithTitle:(NSString *)title TitleTColor:(UIColor *)titleColor Image:(NSString *)imageName;
-(void)doNavigationRightBtnAction;





@end
