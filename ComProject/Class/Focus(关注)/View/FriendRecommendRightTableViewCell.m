//
//  FriendRecommendRightTableViewCell.m
//  项目模板
//
//  Created by ychen on 16/10/8.
//  Copyright © 2016年 ComProject. All rights reserved.
//

#import "FriendRecommendRightTableViewCell.h"


@implementation FriendRecommendRightTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}


-(void)setUserModel:(RecommedUserModel *)userModel{
    _userModel = userModel;
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",userModel.header]] placeholderImage:nil];
    self.screenNameLabel.text=userModel.screen_name;
    self.fansCountLabel.text=[NSString stringWithFormat:@"粉丝数:%ld",(long)userModel.fans_count];
}

- (IBAction)attentionBtnAction:(UIButton *)sender {
}
@end
