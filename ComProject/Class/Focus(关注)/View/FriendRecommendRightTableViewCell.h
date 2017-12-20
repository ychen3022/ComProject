//
//  FriendRecommendRightTableViewCell.h
//  项目模板
//
//  Created by ychen on 16/10/8.
//  Copyright © 2016年 ComProject. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecommedUserListModel.h"

@interface FriendRecommendRightTableViewCell : UITableViewCell

@property(nonatomic,strong)RecommedUserModel *userModel;

/* 头像*/
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
/* 姓名*/
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;
/* 粉丝数*/
@property (weak, nonatomic) IBOutlet UILabel *fansCountLabel;
/* 关注按钮*/
@property (weak, nonatomic) IBOutlet UIButton *attentionBtn;

- (IBAction)attentionBtnAction:(UIButton *)sender;

@end
