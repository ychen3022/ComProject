//
//  FriendRecommendLeftTableViewCell.h
//  项目模板
//
//  Created by ychen on 16/10/8.
//  Copyright © 2016年 ComProject. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecommedCategoryListModel.h"


@interface FriendRecommendLeftTableViewCell : UITableViewCell
/* 模型类别*/
@property(nonatomic,strong)RecommedCategoryModel *categoryModel;

@property (weak, nonatomic) IBOutlet UIView *colView;

@end
