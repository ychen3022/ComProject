//
//  ComLoadingIndicator.m
//  项目模板
//
//  Created by ychen on 16/10/8.
//  Copyright © 2016年 ComProject. All rights reserved.
//

#import "ComLoadingIndicator.h"
#import "ComGifView.h"

#define COM_IMAGE_WIDTH   100
#define COM_IMAGE_HEIGHT  120
#define COM_SCRENTCENTER  [UIApplication sharedApplication].keyWindow.center
#define COM_IMAGE_FRAME   CGRectMake(COM_SCRENTCENTER.x-COM_IMAGE_WIDTH/2,COM_SCRENTCENTER.y-COM_IMAGE_HEIGHT/2,COM_IMAGE_WIDTH,COM_IMAGE_HEIGHT)



@interface ComLoadingIndicator ()
{
    ComGifView  *_gifView;
    NSInteger   _index;
    ComReturnValue _returnBlock;
}
@end



@implementation ComLoadingIndicator

#pragma mark -单例
static ComLoadingIndicator  *_defaultIndicator = nil;
- (ComLoadingIndicator *)sharedIndicator{
    return [self initWithFrame:CGRectZero];
}

- (instancetype)init{
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame{
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        _defaultIndicator = [super initWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds))];
        _index = 0;
        _defaultIndicator.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0];
        [self initUI];
    });
    return _defaultIndicator;
}

- (instancetype)copy{
    return [self sharedIndicator];
}



#pragma mark -创建gif显示图
- (void)initUI{
    UIButton *bgButton = [[UIButton alloc] initWithFrame:_defaultIndicator.frame];
    bgButton.backgroundColor = [UIColor clearColor];//背景button占据了全屏幕
    [bgButton addTarget:self action:@selector(bgButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_defaultIndicator addSubview:bgButton];
    
    UIButton *imageBgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    imageBgBtn.frame = COM_IMAGE_FRAME;
    imageBgBtn.backgroundColor = [UIColor clearColor];//照片button是一个照片的差不多大小
    [imageBgBtn addTarget:self action:@selector(imageBgBtnAct:) forControlEvents:UIControlEventTouchUpInside];
    [bgButton addSubview:imageBgBtn];
    
    NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ur_loading_image" ofType:@"gif"]];
    _gifView = [[ComGifView alloc] initWithFrame:CGRectMake(0, 0, COM_IMAGE_WIDTH, COM_IMAGE_HEIGHT) data:data];
    _gifView.userInteractionEnabled = NO;
    [imageBgBtn addSubview:_gifView];
    
    [[UIApplication sharedApplication].keyWindow addSubview:_defaultIndicator];
    _defaultIndicator.alpha = 0.0;
}



#pragma mark -点击bgButton对应的事件
- (void)bgButtonAction:(UIButton *)button{
    
}



#pragma mark -点击imageButton对应的事件
- (void)imageBgBtnAct:(UIButton *)button{
    _index = 1;
    [self stopLoading];
    if (_returnBlock) {
        _returnBlock(nil);
    }
}



#pragma mark -开始显示加载指示器，并且带了一个block
- (void)startLoadingWithCancel:(ComReturnValue)returnValue;{
    [self startLoading];
    _returnBlock = returnValue;
}



#pragma mark -显示加载指示器
- (void)startLoading{
    ++_index;
    if (_index == 1) {
        [_gifView startGif];
        _defaultIndicator.alpha = 1.0;
    }
}



#pragma mark -停止显示加载指示器
- (void)stopLoading{
    --_index;
    if (_index<0) {
        _index = 0;
    }
    if (_index == 0) {
        [UIView animateWithDuration:0.5 animations:^{
            [_gifView stopGif];
            _defaultIndicator.alpha = 0.0;
        }];
    }
}
@end
