//
//  ComTabBarController.m
//  项目模板
//
//  Created by ychen on 16/10/8.
//  Copyright © 2016年 ComProject. All rights reserved.
//

#import "ComTabBarController.h"
#import "ComTabBar.h"
#import "ComNavigationController.h"
#import "HomeViewController.h"
#import "NewViewController.h"
#import "FriendViewController.h"
#import "MineViewController.h"

@interface ComTabBarController ()

@end

@implementation ComTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpTabBar];
}

#pragma mark -设置Tabbar
-(void)setUpTabBar{
    //首页
    HomeViewController *homeVC=[[HomeViewController alloc] init];
    [self addChildViewController:homeVC withTitle:@"首页" andImage:@"tabBar_essence_icon" andSelectIamge:@"tabBar_essence_click_icon"];
    
    //新帖
    NewViewController *newVC=[[NewViewController alloc] init];
    [self addChildViewController:newVC withTitle:@"新帖" andImage:@"tabBar_new_icon" andSelectIamge:@"tabBar_new_click_icon"];
    
    //关注
    FriendViewController *focusVC=[[FriendViewController alloc] init];
    [self addChildViewController:focusVC withTitle:@"关注" andImage:@"tabBar_friendTrends_icon" andSelectIamge:@"tabBar_friendTrends_click_icon"];
    
    //个人中心
    MineViewController *mineVC=[[MineViewController alloc] init];
    [self addChildViewController:mineVC withTitle:@"我的" andImage:@"tabBar_me_icon" andSelectIamge:@"tabBar_me_click_icon"];
    
    //更换tabBar
    [self setValue:[[ComTabBar alloc] init] forKey:@"tabBar"];
}

-(void)addChildViewController:(UIViewController *)childVC withTitle:(NSString *)title andImage:(NSString *)imageStr andSelectIamge:(NSString *)selectImageStr{

    NSMutableDictionary *attrsDic=[NSMutableDictionary dictionary];
    attrsDic[NSFontAttributeName]=[UIFont systemFontOfSize:12];
    attrsDic[NSForegroundColorAttributeName]=[UIColor grayColor];
    //[childVC.tabBarItem setTitleTextAttributes:attrsDic forState:UIControlStateNormal];
    NSMutableDictionary *selectAttrsDic=[NSMutableDictionary dictionary];
    selectAttrsDic[NSFontAttributeName]=[UIFont systemFontOfSize:12];
    selectAttrsDic[NSForegroundColorAttributeName]=[UIColor darkGrayColor];
    //[childVC.tabBarItem setTitleTextAttributes:selectAttrsDic forState:UIControlStateSelected];

    //通过带有appearance统一设置所有UITabBarItem的文字属性
    //后面带有UI_APPEARANCE_SELECTOR的方法，都可以通过appearance对象来统一设置
    UITabBarItem *item=[UITabBarItem appearance];
    [item setTitleTextAttributes:attrsDic forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectAttrsDic forState:UIControlStateSelected];
    
    
    childVC.tabBarItem.title=title;
    childVC.tabBarItem.image=[UIImage imageNamed:imageStr];
    childVC.tabBarItem.selectedImage=[[UIImage imageNamed:selectImageStr] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //包装一个nav的导航控制器,并设置其背景颜色
    ComNavigationController *navVC=[[ComNavigationController alloc] initWithRootViewController:childVC];
    [navVC.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
    [self addChildViewController:navVC];
}
@end
