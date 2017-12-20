//
//  ComPlayer.h
//  项目模板
//
//  Created by ychen on 16/10/8.
//  Copyright © 2016年 ComProject. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
@class ComPlayer;

/** 播放器状态*/
typedef NS_ENUM(NSInteger, PlayerPlayState) {
    PlayerPlaybackStateStopped = 0, //停止播放
    PlayerPlaybackStatePlaying, //正在播放
    PlayerPlaybackStatePaused,  //暂停播放
    PlayerPlaybackStateFailed, //播放失败
};

/** 缓存状态*/
typedef NS_ENUM(NSInteger, PlayerBufferingState) {
    PlayerBufferingStateBuffering = 0,//正在缓存
    PlayerBufferingStateKeepUp,//Buffering keepUp
    PlayerBufferingStateDelayed,// Delayed buffering
    PlayerBufferingStateFull,//缓存完成
    PlayerBufferingStateUpToGrade,//Up to grade
};


@interface ComPlayer : UIView

/** 播放器状态*/
@property (nonatomic, assign) PlayerPlayState playerPlayState;
/** 播放完成后是否要进行从头播放,默认为no*/
@property (nonatomic, assign) BOOL playLoops;
/** 播放器的标题*/
@property(nonatomic,strong)NSString *title;
/** 初始时所在的父控件 */
/** 全屏 是将player 添加到window上,当要退出全屏,要将player重新添回到初始的父控件中 */
@property (nonatomic, weak) UIView *firstSuperView;


#pragma mark - 可以通过改变下面三个任意一个改变播放器地址
/** 播放地址*/
@property (nonatomic, copy) NSString *mediaPath;
@property (nonatomic, strong) AVAsset *mediaAsset;


#pragma mark - 是否自动全屏
/**
 *  yes 不用手动去设置全屏的方法,no 需要用户自己去实现全屏的代码,默认是yes
 *  如果要手动实现全屏的代码,实现代理方法即可
 */
@property (nonatomic, assign) BOOL isAutoFullScreen;

#pragma mark - customMethod
/**
 *  当要退出控制器,或者要移除播放器的时候要调用这个方法
 */
- (void)close;

- (void)play;
- (void)pause;

-(void)creatPlayer;

@end
