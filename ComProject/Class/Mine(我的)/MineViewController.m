//
//  MineViewController.m
//  ComProject
//
//  Created by 陈园 on 2017/9/28.
//  Copyright © 2017年 陈园. All rights reserved.
//

#import "MineViewController.h"
#import "LoginViewController.h"
#import "UserInfoManager.h"

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatNavItem];
    [self creatSubView];
}

#pragma mark -布局
-(void)creatNavItem{
    [self initNavigationTitleViewWithTitle:@"我的"];
}

-(void)creatSubView{
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(50, 100, 100, 50)];
    btn.center = self.view.center;
    btn.backgroundColor = [UIColor redColor];
    [btn setTitle:@"去登录" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

#pragma mark -事件
-(void)btnAction{
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    [self.navigationController pushViewController:loginVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
