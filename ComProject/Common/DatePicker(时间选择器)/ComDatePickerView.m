//
//  ComDatePickerView.m
//  项目模板
//
//  Created by ychen on 16/10/19.
//  Copyright © 2016年 ComProject. All rights reserved.
//

#import "ComDatePickerView.h"

static CGFloat titleLableH=25;
static CGFloat bottomViewH=40;
#define  datePickerDefaultColor [UIColor orangeColor]



@implementation ComDatePickerView

-(void)awakeFromNib{
    [super awakeFromNib];
}

#pragma mark -创建ComDatePickerView
- (instancetype)initWithFrame:(CGRect)frame Mode:(UIDatePickerMode)datePickerMode{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor whiteColor];
        
        //标题
        UILabel *titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 0,self.width, titleLableH)];
        titleLabel.backgroundColor=datePickerDefaultColor;
        titleLabel.text=@"选择时间";
        titleLabel.font=[UIFont systemFontOfSize:15];
        titleLabel.textColor=[UIColor whiteColor];
        titleLabel.textAlignment=NSTextAlignmentCenter;
        [self addSubview:titleLabel];
        
        //datePicker
        _datePicker=[[UIDatePicker alloc] initWithFrame:CGRectMake(0,titleLableH,self.width,self.height-titleLableH-bottomViewH)];
        _datePicker.backgroundColor=[UIColor whiteColor];
        _datePicker.datePickerMode = datePickerMode;
        [self addSubview:_datePicker];
        
        //bottomView
        UIView *bottomView=[[UIView alloc] initWithFrame:CGRectMake(0,self.height-bottomViewH, self.width, bottomViewH)];
        bottomView.backgroundColor=datePickerDefaultColor;
        UIButton *sureBtn=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, KScreenW/2, bottomViewH)];
        sureBtn.backgroundColor=[UIColor clearColor];
        [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        [sureBtn addTarget:self action:@selector(sureBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [bottomView addSubview:sureBtn];
        
        UIButton *cancelBtn=[[UIButton alloc] initWithFrame:CGRectMake(KScreenW/2, 0, KScreenW/2, bottomViewH)];
        cancelBtn.backgroundColor=[UIColor clearColor];
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [cancelBtn addTarget:self action:@selector(cancelBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [bottomView addSubview:cancelBtn];
        [self addSubview:bottomView];
    }
    return self;
}


#pragma mark -确定按钮
-(void)sureBtnAction:(UIButton *)sureBtn{
    if ([self.delegate respondsToSelector:@selector(datePickerViewSelected:)]) {
        [self.delegate datePickerViewSelected:self];
    }
}


#pragma mark -取消按钮
-(void)cancelBtnAction:(UIButton *)cancelBtn{
    if ([self.delegate respondsToSelector:@selector(datePickerViewCanceled:)]) {
        [self.delegate datePickerViewCanceled:self];
    }
}

@end

