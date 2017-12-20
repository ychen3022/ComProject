//
//  ComProgressSlider.m
//  项目模板
//
//  Created by ychen on 16/10/8.
//  Copyright © 2016年 ComProject. All rights reserved.
//


#import "ComProgressSlider.h"

@implementation ComProgressSlider


-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor=[UIColor clearColor];
        self.progressWidth=3.0;
        
        
        self.bufferProgress=0;
        
        CGRect progressBounds = [self trackRectForBounds:self.bounds];
        progressBounds.origin.y -= 1;
        self.bufferProgressTintColor = [UIColor greenColor];
        self.progressWidth = 3.0;
        self.bufferProgressLayer = [CAShapeLayer layer];
        self.bufferProgressLayer.frame = progressBounds;
        self.bufferProgressLayer.fillColor = nil;
        self.bufferProgressLayer.lineWidth = 2;
        self.bufferProgressLayer.strokeColor = self.bufferProgressTintColor.CGColor;
        self.bufferProgressLayer.strokeStart = 0.0;
        self.bufferProgressLayer.strokeEnd = 0.0;
        [self.layer addSublayer:self.bufferProgressLayer];
        
        
        self.continuous = YES;//默认YES  如果设置为NO，则每次滑块停止移动后才触发事件
        [self setMinimumValue:0.0];
        [self setMaximumValue:1.0];
        
        self.value = 0.0;
        
        [self setThumbImage:[UIImage imageNamed:@"player-kit-slider_indicator"] forState:UIControlStateNormal];
        [self setMinimumTrackImage:[UIImage imageNamed:@"player-kit-slider_track_fill"] forState:UIControlStateNormal];
        
        [self setMaximumTrackImage: [UIImage imageNamed:@"player-kit-slider_track_empty"] forState:UIControlStateNormal];
    }
    return self;
}

+ (instancetype)initilzerProgressViewWithFrame:(CGRect)frame {
    ComProgressSlider *progressView = [[ComProgressSlider alloc] initWithFrame:frame];
    return progressView;
}


#pragma mark - Propertys

- (void)setProgress:(CGFloat)progress {
    [self setProgress:progress animated:NO];
}

- (void)setProgress:(CGFloat)progress animated:(BOOL)animated {
    if (_progress == progress) {
        return;
    }
    if (progress > 1.0) {
        progress = 1.0;
    } else if (progress < 0.0 || isnan(progress)) {
        progress = 0.0;
    }
    _progress = progress;
    [self updateProgress];
}

- (void)setBufferProgress:(CGFloat)bufferProgress {
    [self setBufferProgress:bufferProgress animated:NO];
}

- (void)setBufferProgress:(CGFloat)bufferProgress animated:(BOOL)animated {
    if (_bufferProgress == bufferProgress) {
        return;
    }
    
    if (bufferProgress == INFINITY) {
        return;
    }
    if (bufferProgress > 1.0 ) {
        bufferProgress = 1.0;
    } else if (bufferProgress < 0.0 || isnan(bufferProgress)) {
        bufferProgress = 0.0;
    }
    _bufferProgress = bufferProgress;
    [self updateBufferProgress];
}

- (void)setBufferProgressTintColor:(UIColor *)bufferProgressTintColor {
    _bufferProgressTintColor = bufferProgressTintColor;
    self.bufferProgressLayer.strokeColor = bufferProgressTintColor.CGColor;
    [self.bufferProgressLayer setNeedsDisplay];
}

- (void)updateProgress {
    if (self.state == UIControlStateNormal) {
        self.value = self.progress;
    }
}

- (void)updateBufferProgress {
    self.bufferProgressLayer.strokeEnd = self.bufferProgress;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGRect bufferProgressLayerFrame = self.bufferProgressLayer.frame;
    bufferProgressLayerFrame.size.width = CGRectGetWidth(self.bounds);
    self.bufferProgressLayer.frame = bufferProgressLayerFrame;
    
    CGRect progressBounds = [self trackRectForBounds:self.bounds];
    
    CGFloat halfHeight = CGRectGetHeight(progressBounds) / 2.0;
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(0, halfHeight)];
    [bezierPath addLineToPoint:CGPointMake(CGRectGetWidth(progressBounds), halfHeight)];
    self.bufferProgressLayer.path = bezierPath.CGPath;
}

@end
