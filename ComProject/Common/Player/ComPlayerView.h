//
//  ComPlayerView.h
//  项目模板
//
//  Created by ychen on 16/10/8.
//  Copyright © 2016年 ComProject. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "ComProgressSlider.h"


@protocol ComPlayerViewDelegate <NSObject>
- (void)playerViewDidClickBackButton;
- (void)playViewDidDoubleTap;
- (void)playViewDidSwipeOver:(NSInteger)seconds;
- (void)playViewDidChangeVolume:(CGFloat)volume;
@end


@interface ComPlayerView : UIView

/** 播放器*/
@property (nonatomic, strong)AVPlayer *player;
/** 播放器的Layer*/
@property (nonatomic, strong) AVPlayerLayer *playerLayer;
/** 播放器的Item*/
@property (nonatomic, strong)AVPlayerItem *playerItem;


/** 菊花指示器 */
@property(nonatomic,strong)UIActivityIndicatorView *indicatorView;
/** 显示器转动*/
- (void)showIndicator;
/** 隐藏指示器*/
- (void)hideIndicator;

/** 底部工具栏视图 */
@property (nonatomic,strong )UIView *bottomView;
/** 暂停或者播放的按钮*/
@property (nonatomic,strong)UIButton *playOrPauseBtn;
/** 进度条*/
@property(nonatomic,strong)ComProgressSlider *progressSlider;
/** 当前播放时长*/
@property(nonatomic,strong)UILabel *currentTimeLabel;
/** 总时长*/
@property (nonatomic,strong)UILabel *totalTimeLabel;
/** 全屏播放*/
@property(nonatomic,strong)UIButton *fullScreenBtn;
/* 定时器 */
@property (nonatomic, strong) NSTimer *progressTimer;


@property(nonatomic,weak)id<ComPlayerViewDelegate>delegate;


@end
