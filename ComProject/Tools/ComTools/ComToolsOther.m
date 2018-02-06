//
//  ComToolsOther.m
//  ComProject
//
//  Created by 陈园 on 2017/9/30.
//  Copyright © 2017年 陈园. All rights reserved.
//

#import "ComToolsOther.h"

@implementation ComToolsOther

#pragma mark -获取屏幕当前页面
+ (UIViewController *)getCurrentViewController{
    UIViewController* activityViewController = nil;
    
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    if(window.windowLevel != UIWindowLevelNormal){
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow *tmpWin in windows){
            if(tmpWin.windowLevel == UIWindowLevelNormal){
                window = tmpWin;
                break;
            }
        }
    }
    NSArray *viewsArray = [window subviews];
    if([viewsArray count] > 0){
        UIView *frontView = [viewsArray objectAtIndex:0];
        
        id nextResponder = [frontView nextResponder];
        
        if([nextResponder isKindOfClass:[UIViewController class]]){
            activityViewController = nextResponder;
        }
        else{
            activityViewController = window.rootViewController;
        }
    }
    return activityViewController;
}

@end
