//
//  UserInfoManager.m
//  ComProject
//
//  Created by 陈园 on 2017/11/14.
//  Copyright © 2017年 陈园. All rights reserved.
//

#import "UserInfoManager.h"

@implementation UserInfoManager

static id sharedInstance = nil;
+ (id)sharedInstance{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

+(instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance=[super allocWithZone:zone];
    });
    return sharedInstance;
}

-(id)copyWithZone:(NSZone *)zone{
    return sharedInstance;
}

-(id)mutableCopyWithZone:(NSZone *)zone{
    return sharedInstance;
}



#pragma mark -用户登录
-(void)didLoginInWithUserInfoModel:(UserInfoModel *)userInfoModel{
    [[NSUserDefaults standardUserDefaults] setObject:[userInfoModel toJSONData] forKey:kUserInfoFlag];
    [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:kIsLoginFlag];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark -用户退出登录
-(void)didLoginOut{
    [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:kIsLoginFlag];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark -获取当前用户信息
-(UserInfoModel *)getCurrentUserInfo{
    NSData *userInfoData = [[NSUserDefaults standardUserDefaults] objectForKey:kUserInfoFlag];
    NSError *error = nil;
    UserInfoModel *userInfoModel= [[UserInfoModel alloc] initWithData:userInfoData error:&error];
    [[NSUserDefaults standardUserDefaults] synchronize];
    DLog(@"用户信息 = %@",userInfoModel);
    return userInfoModel;
}

#pragma mark -更新缓存中的用户信息*
- (void)updateUserInfoWithUserInfoModel:(UserInfoModel *)userInfoModel{
    [[NSUserDefaults standardUserDefaults] setObject:userInfoModel forKey:kUserInfoFlag];
}

@end
