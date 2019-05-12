//
//  ComBaseWebViewController.h
//  ComProject
//
//  Created by 陈园 on 2017/9/28.
//  Copyright © 2017年 陈园. All rights reserved.
//

#import "ComBaseViewController.h"
#import <WebKit/WKWebView.h>


typedef NS_ENUM(NSUInteger, HyBirdStyle) {
    HyBirdStyle_LikeNative=1, //非全屏显示
    HyBirdStyle_Full=2 //全屏显示
};

@interface ComBaseWebViewController : ComBaseViewController

@property (nonatomic, strong) WKWebView *wkWebView;
@property (nonatomic, strong) NSString *loadUrl;

-(void)setupwkWebViewWithStyle:(HyBirdStyle)style;
-(void)loadUrl:(NSString *)loadUrl;
@end
