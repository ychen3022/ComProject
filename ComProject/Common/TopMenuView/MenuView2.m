//
//  MenuView2.m
//  RKTopTagsMenu
//
//  Created by ychen on 16/10/26.
//  Copyright © 2016年 Snail. All rights reserved.
//

#import "MenuView2.h"

@interface MenuView2 ()

@end

@implementation MenuView2

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor orangeColor];
    UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(0, 300, [UIScreen mainScreen].bounds.size.width, 50)];
    label.text=@"电视剧";
    label.textAlignment=NSTextAlignmentCenter;
    label.textColor=[UIColor whiteColor];
    label.font=[UIFont systemFontOfSize:30];
    [self.view addSubview:label];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
