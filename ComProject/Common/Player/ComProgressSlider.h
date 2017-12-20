//
//  ComProgressSlider.h
//  项目模板
//
//  Created by ychen on 16/10/8.
//  Copyright © 2016年 ComProject. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface ComProgressSlider : UISlider

@property (nonatomic, strong) CAShapeLayer *bufferProgressLayer;

@property (nonatomic, strong) CAShapeLayer *progressLayer;

@property (nonatomic, assign) CGFloat progressWidth;
@property (nonatomic, assign) CGFloat totalLength;


@property (nonatomic, strong) UIColor *bufferProgressTintColor;
@property (nonatomic, strong) UIColor *bufferTintColor;

@property (nonatomic, assign) CGFloat bufferProgress;
@property (nonatomic, assign) CGFloat progress;

+ (instancetype)initilzerProgressViewWithFrame:(CGRect)frame;

- (void)setProgress:(CGFloat)progress animated:(BOOL)animated;
- (void)setBufferProgress:(CGFloat)bufferProgress animated:(BOOL)animated;
@end
