//
//  RecommendTagsModel.h
//  项目模板
//
//  Created by ychen on 16/10/8.
//  Copyright © 2016年 ComProject. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecommendTagsModel : NSObject

@property(nonatomic,copy)NSString *image_list;
@property(nonatomic,assign)NSInteger is_default;
@property(nonatomic,assign)NSInteger is_sub;
@property(nonatomic,copy)NSString *sub_number;
@property(nonatomic,copy)NSString *theme_id;
@property(nonatomic,copy)NSString *theme_name;

@end
