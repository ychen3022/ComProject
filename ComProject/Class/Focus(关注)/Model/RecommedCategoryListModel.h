//
//  RecommedCategoryListModel.h
//  ComProject
//
//  Created by 陈园 on 2017/11/29.
//  Copyright © 2017年 陈园. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecommedCategoryModel : NSObject
@property(nonatomic,assign)NSInteger count;//该类别下用户的总数
@property(nonatomic,assign)NSInteger id;//该类别id
@property(nonatomic,copy)NSString *name;//该类别名字
@property (nonatomic, strong) NSMutableArray *userArr;//该类别下用户数组（手动保存进来）
@end



@interface RecommedCategoryListModel : NSObject
@property(nonatomic,strong)NSMutableArray *list;//类别数组
@property(nonatomic,assign)NSInteger total;//类别总数
@end
