//
//  RecommedUserListModel.h
//  ComProject
//
//  Created by 陈园 on 2017/11/29.
//  Copyright © 2017年 陈园. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecommedUserModel : NSObject
 
@property(nonatomic,copy)NSString *header;//头像
@property(nonatomic,copy)NSString *screen_name;//名字
@property(nonatomic,assign)NSInteger fans_count;//粉丝数量


@end


@interface RecommedUserListModel : NSObject

@property(nonatomic,strong)NSMutableArray *list;//用户数组
@end
