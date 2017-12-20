//
//  ComDatePickerView.h
//  项目模板
//
//  Created by ychen on 16/10/19.
//  Copyright © 2016年 ComProject. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ComDatePickerView;



@protocol ComDatePickerViewDelegate <NSObject>

/**
 *  点击datePickerView的确定按钮
 *
 *  @param datePickerView datePickerView对象
 */
-(void)datePickerViewSelected:(ComDatePickerView *)datePickerView;



/**
 *  点击datePickerView的取消按钮
 *
 *  @param datePickerView datePickerView对象
 */
-(void)datePickerViewCanceled:(ComDatePickerView *)datePickerView;

@end



@interface ComDatePickerView : UIView

/** 时间选择器*/
@property(nonatomic,strong)UIDatePicker *datePicker;



/**
 *  代理
 */
@property(nonatomic,weak)id<ComDatePickerViewDelegate> delegate;



/**
 *  创建ComDatePickerView
 *
 *  @param frame          时间选择器的frame
 *  @param datePickerMode   时间选择器的Mode
 *
 *  @return ComDatePickerView
 */
- (instancetype)initWithFrame:(CGRect)frame Mode:(UIDatePickerMode)datePickerMode;


@end
