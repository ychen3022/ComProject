//
//  PublishView.h
//  ComProject
//
//  Created by 陈园 on 2017/12/12.
//  Copyright © 2017年 陈园. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PublishView : UIView

//取消按钮
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;

- (IBAction)cancelBtnAction:(id)sender;

/** 显示发布界面*/
+(void)show;

@end
