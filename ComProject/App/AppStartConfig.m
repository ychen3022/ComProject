//
//  AppStartConfig.m
//  ComProject
//
//  Created by 陈园 on 2017/11/9.
//  Copyright © 2017年 陈园. All rights reserved.
//

#import "AppStartConfig.h"

@interface AppStartConfig ()

@end

@implementation AppStartConfig

static id sharedInstance = nil;
+ (instancetype)sharedInstance {
    return [[self alloc] init];
}

+(instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [super allocWithZone:zone];
    });
    return sharedInstance;
}

- (instancetype)init{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [super init];
    });
    return sharedInstance;
}

- (id)copyWithZone:(NSZone *)zone{
    return  sharedInstance;
}

+ (id)copyWithZone:(struct _NSZone *)zone{
    return  sharedInstance;
}

+ (id)mutableCopyWithZone:(struct _NSZone *)zone{
    return sharedInstance;
}

- (id)mutableCopyWithZone:(NSZone *)zone{
    return sharedInstance;
}

-(void)configAppStatus{
    [self configKeyBoardManager];
}

#pragma mark -设置键盘
-(void)configKeyBoardManager{
    [[IQKeyboardManager sharedManager] setEnable:YES];
}
@end
