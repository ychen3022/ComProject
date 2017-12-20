//
//  DatePickViewController.m
//  项目模板
//
//  Created by 陈园 on 2017/7/13.
//  Copyright © 2017年 ComProject. All rights reserved.
//

#import "DatePickViewController.h"
#import "ComDatePickerView.h"

@interface DatePickViewController ()<ComDatePickerViewDelegate>

@end

@implementation DatePickViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"时间选择";
    [self creatButton];
    
}

-(void)creatButton{
    UIButton *datePickBtn=[[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 30)];
    datePickBtn.backgroundColor=[UIColor orangeColor];
    [datePickBtn setTitle:@"时间选择器" forState:UIControlStateNormal];
    [datePickBtn addTarget:self action:@selector(datePickBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:datePickBtn];
}


-(void)datePickBtnAction:(UIButton *)btn{
    ComDatePickerView *dataPickerView=[[ComDatePickerView  alloc] initWithFrame:CGRectMake(0, KScreenH-216, KScreenW, 216) Mode:UIDatePickerModeDate];
    dataPickerView.delegate=self;
    [self.view addSubview:dataPickerView];
}



#pragma mark -datePicker的代理事件
-(void)datePickerViewSelected:(ComDatePickerView *)datePickerView{
    NSLog(@"选择");
    NSLog(@"%@",datePickerView.datePicker.date);
    [datePickerView removeFromSuperview];
    datePickerView=nil;
}


-(void)datePickerViewCanceled:(ComDatePickerView *)datePickerView{
    NSLog(@"取消");
    [datePickerView removeFromSuperview];
    datePickerView=nil;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
