//
//  BarCodeViewController.m
//  二维码生成与扫描
//
//  Created by ychen on 16/12/20.
//  Copyright © 2016年 ychen. All rights reserved.
//

#import "AppDelegate.h"
#import "BarCodeViewController.h"
#import "BarCodeScanViewController.h"
#import "BarCodeCreatViewController.h"

#define screen_H [UIScreen mainScreen].bounds.size.height
#define screen_W [UIScreen mainScreen].bounds.size.width


@interface BarCodeViewController ()

@end

@implementation BarCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"二维码";
    self.view.backgroundColor=[UIColor whiteColor];

    
    UIButton *scanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    scanBtn.frame = CGRectMake((screen_W-100)/2,200, 100, 50);
    [scanBtn setTitle:@"扫描" forState:UIControlStateNormal];
    [scanBtn setBackgroundColor:[UIColor orangeColor]];
    [scanBtn addTarget:self action:@selector(scan) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:scanBtn];
    
    
    
    UIButton *creatCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    creatCodeBtn.frame = CGRectMake((screen_W-100)/2,300, 100, 50);
    [creatCodeBtn setTitle:@"生成" forState:UIControlStateNormal];
    [creatCodeBtn setBackgroundColor:[UIColor orangeColor]];
    [creatCodeBtn addTarget:self action:@selector(creatCodeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:creatCodeBtn];

}

#pragma mark -二维码扫描
- (void)scan{
    BarCodeScanViewController *barCodeScanVC=[[BarCodeScanViewController alloc] init];
    [self.navigationController pushViewController:barCodeScanVC animated:YES];
}


#pragma mark -二维码生成
-(void)creatCodeBtnAction:(UIButton *)btn{
    BarCodeCreatViewController *barCodeCreatVC=[[BarCodeCreatViewController alloc] init];
    [self.navigationController pushViewController:barCodeCreatVC animated:YES];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
