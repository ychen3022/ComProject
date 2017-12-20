//
//  NewViewController.m
//  ComProject
//
//  Created by 陈园 on 2017/9/28.
//  Copyright © 2017年 陈园. All rights reserved.
//

#import "NewViewController.h"
#import "ComMenuBaseViewController.h"
#import "BarCodeViewController.h"
#import "CirCleViewController.h"
#import "DatePickViewController.h"
#import "PhotoAndVideoViewController.h"
#import "ComGraphicsViewController.h"

@interface NewViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArr;

@end

@implementation NewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatNavItem];
    [self creatTableView];
    self.dataArr=@[@"菜单页",
                   @"二维码",
                   @"轮播图",
                   @"时间选择器",
                   @"照片视频选择",
                   @"系统权限管理",
                   @"画图"].mutableCopy;
}

#pragma mark -布局
-(void)creatNavItem{
    [self initNavigationTitleViewWithTitle:@"新帖"];
}

-(void)creatTableView{
    self.tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, KScreenW,KScreenH-64) style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.showsVerticalScrollIndicator=NO;
    self.tableView.showsHorizontalScrollIndicator=NO;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text=self.dataArr[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    if([cell.textLabel.text isEqualToString:@"菜单页"]){
        ComMenuBaseViewController *comMenuBaseVC = [[ComMenuBaseViewController alloc] init];
        [self.navigationController pushViewController:comMenuBaseVC animated:YES];
    }
    if ([cell.textLabel.text isEqualToString:@"二维码"]) {
        BarCodeViewController *barCodeVC=[[BarCodeViewController alloc] init];
        [self.navigationController pushViewController:barCodeVC  animated:YES];
    }
    if ([cell.textLabel.text isEqualToString:@"轮播图"]) {
        CirCleViewController *circleVC=[[CirCleViewController alloc] init];
        [self.navigationController pushViewController:circleVC  animated:YES];
    }
    if ([cell.textLabel.text isEqualToString:@"时间选择器"]) {
        DatePickViewController *datePickVC=[[DatePickViewController alloc] init];
        [self.navigationController pushViewController:datePickVC  animated:YES];
    }
    if ([cell.textLabel.text isEqualToString:@"照片视频选择"]) {
        PhotoAndVideoViewController *photoAndVideoVC=[[PhotoAndVideoViewController alloc] init];
        [self.navigationController pushViewController:photoAndVideoVC  animated:YES];
    }
    if([cell.textLabel.text isEqualToString:@"系统权限管理"]){
        NSLog(@"app系统权限管理");
    }
    if([cell.textLabel.text isEqualToString:@"画图"]){
        ComGraphicsViewController *comGraphicsVC = [[ComGraphicsViewController alloc] init];
        [self.navigationController pushViewController:comGraphicsVC animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
