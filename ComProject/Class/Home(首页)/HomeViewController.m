//
//  HomeViewController.m
//  ComProject
//
//  Created by 陈园 on 2017/9/28.
//  Copyright © 2017年 陈园. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()
@property (nonatomic, strong) UIButton *btn;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatNavItem];
    [self creatSubView];
    
    
    
    
    
}

#pragma mark -布局
-(void)creatNavItem{
    [self initNavigationTitleViewWithImage:@"MainTitle"];
}

-(void)creatSubView{
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 300, 300)];
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    self.btn = btn;
}

-(void)btnAction:(UIButton *)btn{
    NSLog(@"番茄 测试");
    [ComAlertDialogTool showLoadingViewWithMessage:@"加载ing" TimeOutBlcok:^{
        NSLog(@"超时,然后消失");
    } InView:self.btn];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    NSLog(@"番茄 测试");
//    [ComAlertDialogTool configToastViewStyle:ToastColorStyle_Black];
//    [ComAlertDialogTool configAlertViewStyle:AlertColorStyle_Red];
//    [ComAlertDialogTool showDemo];

  
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
