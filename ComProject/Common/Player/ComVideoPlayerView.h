//
//  ComVideoPlayerView.h
//  项目模板
//
//  Created by ychen on 16/10/8.
//  Copyright © 2016年 ComProject. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
@class EssenceContentModel;

@interface ComVideoPlayerView : UIView
/** 播放器*/
@property (nonatomic, strong)AVPlayer *player;
/** 播放器的Layer*/
@property (nonatomic, strong) AVPlayerLayer *playerLayer;
/** 播放器的Item*/
@property (nonatomic, strong)AVPlayerItem *playerItem;


/** 底部工具栏视图 */
@property (nonatomic,strong )UIView *toolView;
/** 暂停或者播放的按钮*/
@property (nonatomic,strong)UIButton *playOrPauseBtn;
/** 进度条*/
@property(nonatomic,strong)UISlider *progressSlider;
/** 时长*/
@property (nonatomic,strong)UILabel *timeLabel;
/** 全屏播放*/
@property(nonatomic,strong)UIButton *fullScreenBtn;
/* 定时器 */
@property (nonatomic, strong) NSTimer *progressTimer;



/** 播放器的数据模型*/
@property(nonatomic,strong)EssenceContentModel *contentModel;

@end
