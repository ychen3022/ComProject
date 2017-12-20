//
//  AppStartConfig.h
//  ComProject
//
//  Created by 陈园 on 2017/11/9.
//  Copyright © 2017年 陈园. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppStartConfig : NSObject

//单例方法
+(instancetype)sharedInstance;

-(void)configAppStatus;

@end
