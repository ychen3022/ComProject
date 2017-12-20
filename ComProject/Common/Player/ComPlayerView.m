//
//  ComPlayerView.m
//  项目模板
//
//  Created by ychen on 16/10/8.
//  Copyright © 2016年 ComProject. All rights reserved.
//


#import "ComPlayerView.h"
#import "ComPlayer.h"

@interface ComPlayerView()

/** 总的播放时间*/
@property(nonatomic,assign)NSInteger totlaTime;


@end


@implementation ComPlayerView

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        [self creatTopView];
        [self creatBottomView];
        [self creatIndicatorView];
        [self creatGesture];
    }
    return self;
}


-(void)creatTopView{
    
}


#pragma mark -底部工具栏
-(void)creatBottomView{
    //---bottomView
    _bottomView=[[UIView alloc] initWithFrame:CGRectMake(0, 0,self.width, 20)];
    _bottomView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"player_touming"]];
    [self addSubview:_bottomView];
    //---playOrPauseBtn
    _playOrPauseBtn = [[UIButton alloc ] init];
    [_playOrPauseBtn setImage:[UIImage imageNamed:@"player_bofang"] forState:UIControlStateNormal];
    _playOrPauseBtn.selected = YES;
    [_playOrPauseBtn setImage:[UIImage imageNamed:@"player_pause"] forState:UIControlStateSelected];
    [_playOrPauseBtn addTarget:self action:@selector(playOrPauseBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView addSubview:_playOrPauseBtn];
    
    //---currentTimeLabel
   _currentTimeLabel = [[UILabel alloc] init];
    _currentTimeLabel.textAlignment = NSTextAlignmentCenter;
    _currentTimeLabel.font = [UIFont systemFontOfSize:14];
    _currentTimeLabel.textColor = [UIColor whiteColor];
    _currentTimeLabel.text = @"00:00";
    [_bottomView addSubview:_currentTimeLabel];
    
     //---progressSlider
    _progressSlider = [ComProgressSlider initilzerProgressViewWithFrame:CGRectMake(0, 10, 375, 20)];
   [_bottomView addSubview:_progressSlider];

    
    //---totalTimeLabel
    _totalTimeLabel = [[UILabel alloc] init];
    _totalTimeLabel.text = @"99:99";
    _totalTimeLabel.textAlignment = NSTextAlignmentCenter;
    _totalTimeLabel.font = [UIFont systemFontOfSize:14];
    _totalTimeLabel.textColor = [UIColor whiteColor];
    [_bottomView addSubview:_totalTimeLabel];
    
    //---fullScreenBtn
    _fullScreenBtn = [[UIButton alloc ] init];
    [_fullScreenBtn setImage:[UIImage imageNamed:@"player_fullscreen"] forState:UIControlStateNormal];
    [_fullScreenBtn setImage:[UIImage imageNamed:@"player_embeddedscreen"] forState:UIControlStateSelected];
    [_fullScreenBtn addTarget:self action:@selector(fullScreenBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_fullScreenBtn];
}

-(void)playOrPauseBtnAction:(UIButton *)sender{
    
}


-(void)fullScreenBtnAction:(UIButton *)sender{
    
}


-(void)creatIndicatorView{
    
}

-(void)creatGesture{
    
}

-(void)layoutSubviews{
    
    
    [super layoutSubviews];
}


#pragma mark - 显示菊花的控件
- (void)showIndicator {
    [self.indicatorView startAnimating];
}
- (void)hideIndicator {
    [self.indicatorView stopAnimating];
}
@end
