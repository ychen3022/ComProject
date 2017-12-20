//
//  FriendRecommendLeftTableViewCell.m
//  项目模板
//
//  Created by ychen on 16/10/8.
//  Copyright © 2016年 ComProject. All rights reserved.
//

#import "FriendRecommendLeftTableViewCell.h"

@implementation FriendRecommendLeftTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor=KColorWithRGB(244, 244, 244);
    self.colView.backgroundColor=KColorWithRGB(237, 71, 119);
}

-(void)setCategoryModel:(RecommedCategoryModel *)categoryModel{
    _categoryModel = categoryModel;
    self.textLabel.text = categoryModel.name;
}


/**
 *  可以在这个方法中监听当前cell的选中与没有被选中的状态
 */
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.colView.hidden=!selected;
    self.textLabel.textColor=selected?KColorWithRGB(237, 71, 119):KColorWithRGB(78, 78, 78);
}

-(void)layoutSubviews{
    [super layoutSubviews];
    //重新调整textLabel的frame
    self.textLabel.top=2;
    self.textLabel.height=self.contentView.height-2*self.textLabel.top;
}
@end
