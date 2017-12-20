//
//  RecommedUserListModel.m
//  ComProject
//
//  Created by 陈园 on 2017/11/29.
//  Copyright © 2017年 陈园. All rights reserved.
//

#import "RecommedUserListModel.h"

@implementation RecommedUserModel

@end

@implementation RecommedUserListModel
+ (NSDictionary *)mj_objectClassInArray{
    return @{
             @"list" : [RecommedUserModel class],
             };
}
@end

