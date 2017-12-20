//
//  ComBaseViewController.m
//  ComProject
//
//  Created by 陈园 on 2017/9/28.
//  Copyright © 2017年 陈园. All rights reserved.
//

#import "ComBaseViewController.h"

@interface ComBaseViewController ()

@end

@implementation ComBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [ComTools getColorWithComColor:ComColorLightWhite];
   
    //使手指点击屏幕左侧向右滑动，能达到返回效果
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
}

#pragma mark - 状态栏高度
-(CGFloat)statusBarHeight{
    CGRect statusBar_rect = [[UIApplication sharedApplication] statusBarFrame];
    return statusBar_rect.size.height;
}

#pragma mark - 导航栏高度
-(CGFloat)navBarHeight{
    CGFloat navBar_height=self.navigationController.navigationBar.frame.size.height;
    if (navBar_height <= 0) {
        navBar_height=self.tabBarController.navigationController.navigationBar.frame.size.height;
    }
    return navBar_height;
}

#pragma mark -导航栏+状态栏高度
-(CGFloat)topBarHeight{
    return [self statusBarHeight]+[self navBarHeight];
}

#pragma mark - 底部tabbar高度
-(CGFloat)tabBarHeight{
    CGFloat tabBar_height=self.tabBarController.tabBar.height;
    return tabBar_height;
}


#pragma mark -设置状态栏颜色
- (void)setStatusBarBackgroundColor:(UIColor *)color {
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = color;
    }
}


#pragma mark -初始化导航栏文字标题
-(void)initNavigationTitleViewWithTitle:(NSString *)title{
    if (![ComTools isBlankString:title]) {
        self.navigationItem.title = title;
    }
}

#pragma mark -初始化导航栏照片标题
-(void)initNavigationTitleViewWithImage:(NSString *)imageName{
    if (![ComTools isBlankString:imageName]) {
       self.navigationItem.titleView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    }
}

#pragma mark -初始化导航栏TextField标题
-(void)initNavigationTitleViewTextFieldWithLeftImage:(NSString *)leftImgName PlaceHolderText:(NSString *)placeHolder Delegate:(id)textFieldDelegate{
    UITextField *searchTextField=[[UITextField alloc] initWithFrame:CGRectMake(0, 0, 250, 30)];
    [searchTextField setBorderStyle:UITextBorderStyleRoundedRect];
    UIImageView *leftSearchImage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:leftImgName]];
    leftSearchImage.frame= CGRectMake(0, 0, 18, 28);
    leftSearchImage.frame = CGRectInset(leftSearchImage.frame, -2, 0);
    leftSearchImage.contentMode=UIViewContentModeRight;
    searchTextField.leftViewMode = UITextFieldViewModeAlways;
    searchTextField.leftView = leftSearchImage;
    searchTextField.placeholder=placeHolder;
    searchTextField.clearButtonMode=UITextFieldViewModeWhileEditing;
    searchTextField.font=[UIFont systemFontOfSize:14];
    searchTextField.returnKeyType=UIReturnKeyDone;
    searchTextField.delegate=textFieldDelegate;
    [self.navigationItem setTitleView:searchTextField];
}



#pragma mark -初始化导航栏返回按钮无标题
-(void)initNavigationLeftButtonBack{
     [self initNavigationLeftButtonBackWithTitle:@"返回"];
}

#pragma mark -初始化导航栏返回按钮及标题
-(void)initNavigationLeftButtonBackWithTitle:(NSString *)title{
    [self initNavigationLeftButtonBackWithTitle:title imageName:@"navigationButtonReturn" titleColor:@"#333333"];
}

#pragma mark -初始化导航栏返回按钮及标题
-(void)initNavigationLeftButtonBackWithTitle:(NSString *)title imageName:(NSString *)imageName titleColor:(NSString *)titleColor{
    UIButton *backBtn=[[UIButton alloc] init];
    [backBtn setTitle:title forState:UIControlStateNormal];
    [backBtn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [backBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    backBtn.size=CGSizeMake(60, 40);
    
    //让按钮内部的所有内容左对齐
    backBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
    //让按钮的内容往左边偏移
    backBtn.contentEdgeInsets=UIEdgeInsetsMake(0, -10, 0, 0);
    [backBtn setTitleColor:[ComTools getColorWithHexString:titleColor] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backTo) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:backBtn];
}

#pragma mark -导航栏返回按钮返回动作
-(void)backTo{
    [self.navigationController popViewControllerAnimated:YES];
}



#pragma mark -自定义导航栏左侧按钮
-(void)initNavigationLeftButtonWithTitle:(NSString *)title TitleColor:(UIColor *)titleColor Image:(NSString *)imageName{
    if ([ComTools isBlankString:title]) {
        UIButton *navLeftBtn=[[UIButton alloc] init];
        [navLeftBtn setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        navLeftBtn.size=navLeftBtn.currentBackgroundImage.size;
        [navLeftBtn addTarget:self action:@selector(doNavigationLeftBtnAction) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *navLeftItem=[[UIBarButtonItem alloc] initWithCustomView:navLeftBtn];
        self.navigationItem.leftBarButtonItem = navLeftItem;
    }else{
        UIBarButtonItem *navLeftBtn =[[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:self action:@selector(doNavigationLeftBtnAction)];
        navLeftBtn.tintColor=titleColor;
        [self.navigationItem setLeftBarButtonItem:navLeftBtn animated:NO];
        [self.navigationItem.leftBarButtonItem setTitleTextAttributes:@{NSFontAttributeName:[ComTools getFontWithComFont:ComFont4]} forState:UIControlStateNormal];
    }
}

#pragma mark -自定义导航栏左侧按钮返回动作
-(void)doNavigationLeftBtnAction{
    NSLog(@"自定义导航栏左侧按钮返回动作");
}



#pragma mark -自定义导航栏右侧按钮
-(void)initNavigationRightButtonWithTitle:(NSString *)title TitleTColor:(UIColor *)titleColor Image:(NSString *)imageName{
    if ([ComTools isBlankString:title]) {
        UIButton *navRightBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        navRightBtn.titleLabel.font = [ComTools getFontWithComFont:ComFont4];
        navRightBtn.frame=CGRectMake(0, 0, 60, 30);
        [navRightBtn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        [navRightBtn setImage:[UIImage imageNamed:imageName] forState:UIControlStateHighlighted];
        [navRightBtn addTarget:self action:@selector(doNavigationRightBtnAction) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *rightItem=[[UIBarButtonItem alloc] initWithCustomView:navRightBtn];
        UIBarButtonItem *fixSpace=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        fixSpace.width=-25;
        self.navigationItem.rightBarButtonItems=@[fixSpace,rightItem];
    }else{
        UIBarButtonItem *navRightBtn=[[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:self action:@selector(doNavigationRightBtnAction)];
        navRightBtn.tintColor=titleColor;
        [self.navigationItem setRightBarButtonItem:navRightBtn animated:NO];
        [self.navigationItem.rightBarButtonItem setTitleTextAttributes:@{NSFontAttributeName:[ComTools getFontWithComFont:ComFont4]} forState:UIControlStateNormal];
    }
}

#pragma mark -自定义导航栏右侧按钮返回动作
-(void)doNavigationRightBtnAction{
    NSLog(@"自定义导航栏右侧按钮返回动作");
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
