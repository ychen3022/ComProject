//
//  FriendViewController.m
//  项目模板
//
//  Created by ychen on 16/10/8.
//  Copyright © 2016年 ComProject. All rights reserved.
//

#import "FriendViewController.h"
#import "FriendRecommendViewController.h"

@interface FriendViewController ()

@end

@implementation FriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatNavItem];
    [self creatSubView];
}

#pragma mark -布局
-(void)creatNavItem{
    [self initNavigationTitleViewWithTitle:@"关注"];
    [self initNavigationLeftButtonWithTitle:nil TitleColor:nil Image:@"friendsRecommentIcon"];
}

-(void)creatSubView{
    
}

#pragma mark -事件
-(void)doNavigationLeftBtnAction{
    FriendRecommendViewController *recommendVC=[[FriendRecommendViewController alloc] init];
    [self.navigationController pushViewController:recommendVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
