//
//  ComVideoPlayerView.m
//  项目模板
//
//  Created by ychen on 16/10/8.
//  Copyright © 2016年 ComProject. All rights reserved.
//


#import "ComVideoPlayerView.h"
#import "EssenceContentModel.h"

@implementation ComVideoPlayerView

-(instancetype)init{
    self=[super init];
    if (self) {
        self.userInteractionEnabled=YES;
        
    }
    return self;
}

- (AVPlayer *)player{
    if (!_player) {
        _player = [[AVPlayer alloc] init];
    }
    return _player;
}

-(void)playVideo{
    //创建播放器
    [self  creatPlayer];
    //创建工具条
    [self creatToolView];
    _toolView.hidden=YES;
}


//单纯使用AVPlayer类是无法显示视频的，要将视频层添加至AVPlayerLayer中，这样才能将视频显示出来
-(void)creatPlayer{
    _player = [[AVPlayer alloc] init];
    _playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    [self.layer addSublayer:self.playerLayer];
    //设置player
    _playerItem= [AVPlayerItem playerItemWithURL:[NSURL URLWithString:_contentModel.videouri]];
    [self.player replaceCurrentItemWithPlayerItem:_playerItem];
    [self.player play];
    
    
    
    NSLog(@"--%lf",self.playerLayer.frame.size.width);
    [self addProgressTimer];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self addGestureRecognizer:tap];
}

-(void)tap:(UITapGestureRecognizer *)tap{
    //显示或者隐藏底部工具条
    [UIView animateWithDuration:0.5 animations:^{
        self.toolView.hidden=! _toolView.isHidden;
    }];
}

-(UIView *)creatToolView{
    if (!_toolView) {
        
        _toolView=[[UIView alloc] initWithFrame:CGRectMake(0,self.height-40, self.width,40)];
        _toolView.userInteractionEnabled=YES;
        _toolView.backgroundColor=KColorWithRGB(58, 58, 58);
        _toolView.alpha=0.5;
        
        //播放按钮
        _playOrPauseBtn=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        [_playOrPauseBtn setImage:[UIImage imageNamed:@"full_play_btn_hl"] forState:UIControlStateNormal];
        [_playOrPauseBtn setImage:[UIImage imageNamed:@"full_pause_btn_hl"] forState:UIControlStateSelected];
        _playOrPauseBtn.selected=YES;
        [_playOrPauseBtn addTarget:self action:@selector(playOrPauseBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [_toolView addSubview:_playOrPauseBtn];
       
        
        //进度条
        _progressSlider=[[UISlider alloc] initWithFrame:CGRectMake(_playOrPauseBtn.width,15,self.width-160,10)];
        _progressSlider.minimumTrackTintColor=[UIColor redColor];
        _progressSlider.backgroundColor=[UIColor grayColor];
        [_progressSlider addTarget:self action:@selector(progressSliderChange:) forControlEvents:UIControlEventValueChanged];
        [_toolView addSubview:_progressSlider];
        
        //时长label
        _timeLabel=[[UILabel alloc] initWithFrame:CGRectMake(self.width-120,10,80,20)];
        _timeLabel.font=[UIFont systemFontOfSize:13];
        _timeLabel.textColor=[UIColor whiteColor];
        _timeLabel.textAlignment=NSTextAlignmentRight;
        NSInteger minute=_contentModel.videotime / 60 ;
        NSInteger second=_contentModel.videotime % 60 ;
        _timeLabel.text=[NSString stringWithFormat:@"00:00/%ld:%.2ld",minute,second];
        [_toolView addSubview:_timeLabel];
      
        [self addSubview:_toolView];
        
        //全屏播放
        _fullScreenBtn=[[UIButton alloc] initWithFrame:CGRectMake(self.width-40,0,40,40)];
        [_fullScreenBtn setImage:[UIImage imageNamed:@"full_minimize_btn_hl"] forState:UIControlStateNormal];
        [_fullScreenBtn addTarget:self action:@selector(showFullViewBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [_toolView addSubview:_fullScreenBtn];
    }
    return _toolView;
}


-(void)playOrPauseBtnAction:(UIButton *)sender{
    sender.selected = !sender.selected;
    if (sender.selected) {
        [self.player play];
        [self addProgressTimer];
    } else {
        [self.player pause];
        [self removeProgressTimer];
    }
}


//添加计时器
-(void)addProgressTimer{
    self.progressTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateProgressInfo) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.progressTimer forMode:NSRunLoopCommonModes];
}

//移除计时器
- (void)removeProgressTimer{
    [self.progressTimer invalidate];
    self.progressTimer = nil;
}

-(void)progressSliderChange:(UISlider *)slider{
     NSTimeInterval currentTime = CMTimeGetSeconds(self.player.currentItem.duration) * self.progressSlider.value;
    // 设置当前播放时间
    [self.player seekToTime:CMTimeMakeWithSeconds(currentTime, NSEC_PER_SEC) toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero];
    [self addProgressTimer];
    [self.player play];
    self.playOrPauseBtn.selected=YES;
}



- (void)updateProgressInfo{
    //1.总的时间
    NSTimeInterval duration = CMTimeGetSeconds(self.player.currentItem.duration);
    NSInteger dMin = duration / 60;
    NSInteger dSec = (NSInteger)duration % 60;
    
    //2.当前时间
    NSTimeInterval currentTime = CMTimeGetSeconds(self.player.currentTime);
    NSInteger cMin = currentTime / 60;
    NSInteger cSec = (NSInteger)currentTime % 60;
    
    NSString *durationString = [NSString stringWithFormat:@"%02ld:%02ld", dMin, dSec];
    NSString *currentString = [NSString stringWithFormat:@"%02ld:%02ld", cMin, cSec];
    
    _timeLabel.text=[NSString stringWithFormat:@"%@/%@",currentString,durationString];
    
    self.progressSlider.value = CMTimeGetSeconds(self.player.currentTime) / CMTimeGetSeconds(self.player.currentItem.duration);
}



-(void)showFullViewBtnAction{
    
}

-(void)setContentModel:(EssenceContentModel *)contentModel{
    _contentModel=contentModel;
    [self playVideo];
}





-(void)layoutSubviews{
    //player的fame
    
    self.playerLayer.frame=self.bounds;

    //设置播放条toolView的frame
     _toolView.frame=CGRectMake(0, self.height-40, self.width,40);
    _playOrPauseBtn.frame=CGRectMake(0, 0, 40, 40);
    _fullScreenBtn.frame=CGRectMake(self.width-40,0,40,40);
    _timeLabel.frame=CGRectMake(self.width-120,10,80,20);
    _progressSlider.frame=CGRectMake(_playOrPauseBtn.width,15,self.width-160,10);
    
   
    [super layoutSubviews];
}
@end
