//
//  ComPlayer.m
//  项目模板
//
//  Created by ychen on 16/10/8.
//  Copyright © 2016年 ComProject. All rights reserved.
//


#import "ComPlayer.h"
#import "ComPlayerView.h"


// Player Item Load Keys
static NSString * const XHPlayerTracksKey = @"tracks";
static NSString * const XHPlayerPlayableKey = @"playable";
static NSString * const XHPlayerDurationKey = @"duration";


@interface ComPlayer()<ComPlayerViewDelegate>

@property (nonatomic, strong) AVPlayer *player;
@property(nonatomic,strong)AVPlayerLayer *playerLayer;
@property(nonatomic,strong)ComPlayerView *playerView;
@property(nonatomic, strong)AVPlayerItem *playerItem;

@end

@implementation ComPlayer

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
    }
    return self;
}

//初始化播放器
- (void)creatPlayer {
    _player = [[AVPlayer alloc] init];
    _playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    [self.layer addSublayer:self.playerLayer];
    //设置player
    _playerItem= [AVPlayerItem playerItemWithURL:[NSURL URLWithString:_mediaPath]];
    [self.player replaceCurrentItemWithPlayerItem:_playerItem];
    [self.player play];
    
   
}

//初始化PlayerView
- (void)creatPlayerView {
    if (!_playerView) {
         _playerView = [[ComPlayerView alloc] init];
         _playerView.delegate = self;
    }
}

//加载播放数据
- (void)loadMediaData {
    if (!self.mediaAsset) {
        return;
    }
    [self showIndicator];  // 展示加载indicator
    
    NSArray *keys = @[XHPlayerTracksKey,
                      XHPlayerPlayableKey,
                      XHPlayerDurationKey];
    
    __weak typeof(self.mediaAsset) weakAsset = self.mediaAsset;
    __weak typeof(self) weakSelf = self;
    
    // 异步加载数据,防止阻塞主线程
    [self.mediaAsset loadValuesAsynchronouslyForKeys:keys completionHandler:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            // check the keys
            for (NSString *key in keys) {
                NSError *error = nil;
                AVKeyValueStatus keyStatus = [weakAsset statusOfValueForKey:key error:&error];
                if (keyStatus == AVKeyValueStatusFailed) {
//                    [weakSelf callBackDelegateWithPlaybackState:PlayerPlaybackStateFailed]; // 加载失败
                    NSLog(@"error (%@)", [[error userInfo] objectForKey:AVPlayerItemFailedToPlayToEndTimeErrorKey]);
                    return;
                }
            }
            
            // check playable
            if (!weakAsset.playable) { // 不能播放
//                [weakSelf callBackDelegateWithPlaybackState:PlayerPlaybackStateFailed];
                return;
            }
            
            // setup player
            AVPlayerItem *playerItem = [AVPlayerItem playerItemWithAsset:weakAsset];
            [weakSelf setPlayerItem:playerItem];
        });
    }];
}


- (void)showIndicator {
    if ([self.playerView respondsToSelector:@selector(showIndicator)]) {
        [self.playerView showIndicator];
    }
}


@end
