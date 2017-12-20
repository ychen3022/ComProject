//
//  PublishTopicViewController.m
//  ComProject
//
//  Created by 陈园 on 2017/12/12.
//  Copyright © 2017年 陈园. All rights reserved.
//

#import "PublishTopicViewController.h"

@interface PublishTopicViewController ()

@end

@implementation PublishTopicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatNavItem];
}

#pragma mark -布局
-(void)creatNavItem{
     [self initNavigationTitleViewWithTitle:@"发段子"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
