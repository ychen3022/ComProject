//
//  UserInfoManager.h
//  ComProject
//
//  Created by 陈园 on 2017/11/14.
//  Copyright © 2017年 陈园. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfoModel.h"

@interface UserInfoManager : NSObject

+ (id)sharedInstance;

/** 用户登录*/
-(void)didLoginInWithUserInfoModel:(UserInfoModel *)userInfoModel;

/** 用户退出登录*/
-(void)didLoginOut;

/** 获取当前用户信息*/
-(UserInfoModel *)getCurrentUserInfo;

/** 更新缓存中的用户信息*/
- (void)updateUserInfoWithUserInfoModel:(UserInfoModel *)userInfoModel;

@end
