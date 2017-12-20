//
//  ComBaseViewController.h
//  ComProject
//
//  Created by 陈园 on 2017/9/28.
//  Copyright © 2017年 陈园. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ComBaseViewController : UIViewController

-(CGFloat)statusBarHeight;
-(CGFloat)navBarHeight;
-(CGFloat)topBarHeight;
-(CGFloat)tabBarHeight;



- (void)setStatusBarBackgroundColor:(UIColor *)color;



-(void)initNavigationTitleViewWithTitle:(NSString *)title;
-(void)initNavigationTitleViewWithImage:(NSString *)imageName;
-(void)initNavigationTitleViewTextFieldWithLeftImage:(NSString *)leftImgName PlaceHolderText:(NSString *)placeHolder Delegate:(id)textFieldDelegate;



-(void)initNavigationLeftButtonBack;
-(void)initNavigationLeftButtonBackWithTitle:(NSString *)title;
-(void)initNavigationLeftButtonBackWithTitle:(NSString *)title imageName:(NSString *)imageName titleColor:(NSString *)titleColor;
-(void)backTo;



-(void)initNavigationLeftButtonWithTitle:(NSString *)title TitleColor:(UIColor *)titleColor Image:(NSString *)imageName;
-(void)doNavigationLeftBtnAction;



-(void)initNavigationRightButtonWithTitle:(NSString *)title TitleTColor:(UIColor *)titleColor Image:(NSString *)imageName;
-(void)doNavigationRightBtnAction;





@end
