//
//  ComBaseWebViewController.m
//  ComProject
//
//  Created by 陈园 on 2017/9/28.
//  Copyright © 2017年 陈园. All rights reserved.
//

#import "ComBaseWebViewController.h"

@interface ComBaseWebViewController ()<WKUIDelegate,WKNavigationDelegate>

@end

@implementation ComBaseWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
}

#pragma mark -布局
-(void)setupwkWebViewWithStyle:(HyBirdStyle)style{
    if (style == HyBirdStyle_Full) {//全屏幕
        self.wkWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH)];
        self.wkWebView.scrollView.scrollEnabled = NO;
        self.wkWebView.backgroundColor = [UIColor clearColor];
        [self.wkWebView setOpaque:NO];
    }else{
        self.wkWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, self.topBarHeight, KScreenW, KScreenH - self.topBarHeight)];
    }
    self.wkWebView.scrollView.showsVerticalScrollIndicator=NO;
    self.wkWebView.navigationDelegate=self;
    self.wkWebView.UIDelegate=self;
    if (@available(iOS 11.0, *)) {
        self.wkWebView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    [self.view addSubview: self.wkWebView];
}


-(void)loadUrl:(NSString *)loadUrl{
    if (![ComTools isBlankString:loadUrl]) {
        NSURL *thisUrl=[NSURL URLWithString:loadUrl];
        if (!thisUrl) {
            thisUrl = [NSURL URLWithString:[loadUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]]];
        }
        //        self.isNativeH5 = NO;
        if ([thisUrl.scheme isEqualToString:@"http"]||[thisUrl.scheme isEqualToString:@"https"]) {
            //            NSLog(@"the url is http,load from net:%@",loadUrl);
        }else{
            //            NSString *fileUrl=[NSString stringWithFormat:@"%@/%@",LocalWebHost,url];
            //            NSString *baseNameUrl=fileUrl;
            //            if ([baseNameUrl rangeOfString:@"#"].location!=NSNotFound) {
            //                baseNameUrl=[[baseNameUrl componentsSeparatedByString:@"#"] firstObject];
            //            }
            //            if ([FileUtil isFileExisted:baseNameUrl]) {
            //                aUrl=[NSURL URLWithString:[NSString stringWithFormat:@"file://%@",fileUrl]];
            //                BTLogInfo(@"load from disk...");
            //                self.isNativeH5 = YES;
            //            }else{
            //                NSLog(@"页面不存在");
            //                return;
            //            }
        }
        NSURLRequest *req = [NSURLRequest requestWithURL:thisUrl cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60];
        [self loadRequest:req];
        self.loadUrl = loadUrl;
    }
}

- (void)loadRequest:(NSURLRequest *)request{
    if ([request.URL isFileURL]) {
        if ([self.wkWebView respondsToSelector:@selector(loadFileURL:allowingReadAccessToURL:)]) {
            NSURLComponents *comp = [NSURLComponents componentsWithURL:request.URL resolvingAgainstBaseURL:YES];
            comp.query = nil;
            NSURL *allowingURL = [comp.URL URLByDeletingLastPathComponent];
            if (@available(iOS 9.0, *)) {
                [self.wkWebView loadFileURL:request.URL allowingReadAccessToURL:allowingURL];
            } else {
                // Fallback on earlier versions
            }
        }
    } else {
        [self.wkWebView loadRequest:request];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
