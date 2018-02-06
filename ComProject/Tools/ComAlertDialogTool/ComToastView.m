//
//  ComToastView.m
//  ComProject
//
//  Created by 陈园 on 2018/2/1.
//  Copyright © 2018年 陈园. All rights reserved.
//

#import "ComToastView.h"

#define kWindowView_W 270
#define kWindowView_H 70
#define kWindowView_Padding 25
#define kContent_maxH KScreenH - kWindowView_H - 2 * kWindowView_Padding

#define kMessage_Font 14



@interface ComToastView()<UIGestureRecognizerDelegate>
/** 阴影部分点击手势*/
@property(nonatomic,strong)UITapGestureRecognizer *tapGes;
/** ToastView上的控件*/
@property (nonatomic, strong) UIView *coverView;
@property (nonatomic, strong) UIView *windonView;
@property (nonatomic, strong) UITextView *messageTextView;
/** ToastView上的控件内容*/
@property (nonatomic, copy) NSString *messageStr;
@end



@implementation ComToastView

#pragma mark -初始化toastView
- (instancetype)initMessage:(NSString *)message{
    if (self = [super init]) {
        _messageStr = message;
        _isTapShadowDismiss=NO;
        [self creatToastView];
    }
    return self;
}

-(void)setIsTapShadowDismiss:(BOOL)isTapShadowDismiss{
    if (isTapShadowDismiss!=_isTapShadowDismiss) {
        _isTapShadowDismiss=isTapShadowDismiss;
        if (_isTapShadowDismiss) {
            [self addGestureRecognizer:_tapGes];
        }else{
            [self removeGestureRecognizer:_tapGes];
        }
    }
}

#pragma mark -布局
-(void)creatToastView{
    self.frame = [self topView].bounds;
    self.backgroundColor = [UIColor clearColor];
    
    //coverView
    _coverView = [[UIView alloc] initWithFrame:[self topView].bounds];
    _coverView.backgroundColor = [ComToastViewStyle sharedInstance].coverColor;
    _coverView.alpha = 0;
    _coverView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _tapGes=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    _tapGes.delegate=self;
    if (_isTapShadowDismiss) {
        [self addGestureRecognizer:_tapGes];
    }
    [[self topView] addSubview:_coverView];
    
    //windonView
    _windonView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWindowView_W, kWindowView_H)];
    _windonView.center = CGPointMake(self.frame.size.width/2,self.frame.size.height/2);
    _windonView.backgroundColor = [ComToastViewStyle sharedInstance].windowColor;
    _windonView.layer.cornerRadius = 5;
    _windonView.layer.masksToBounds = YES;
    [self addSubview:_windonView];
    
    //messageTextView
    CGFloat messageHeigh = [self calculateHeightWithString:self.messageStr fontSize:kMessage_Font width:kWindowView_W-2*kWindowView_Padding];
    _messageTextView = [[UITextView alloc] initWithFrame:CGRectMake(kWindowView_Padding, kWindowView_Padding, kWindowView_W-2*kWindowView_Padding, messageHeigh)];
    _messageTextView.backgroundColor = [UIColor clearColor];
    _messageTextView.font = [UIFont systemFontOfSize:kMessage_Font];
    _messageTextView.textColor = [ComToastViewStyle sharedInstance].messageColor;
    _messageTextView.textAlignment = NSTextAlignmentCenter;
    _messageTextView.textContainerInset = UIEdgeInsetsMake(0, -5, 0, -5);
    _messageTextView.showsVerticalScrollIndicator = NO;
    _messageTextView.text = self.messageStr;
    [_windonView addSubview:_messageTextView];
    if(messageHeigh < kContent_maxH){
        _messageTextView.scrollEnabled = NO;
    }
    
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
}


#pragma mark -调整布局
-(void)willMoveToSuperview:(UIView *)newSuperview{
    CGFloat height = _messageTextView.bottom + kWindowView_Padding ;
    _windonView.height = height;
    _windonView.center = self.center;
}

#pragma mark -事件
- (void)show {
    __weak typeof(self) wkself = self;
    [UIView animateWithDuration:0.5 animations:^{
        _coverView.alpha = 0.5;
    } completion:^(BOOL finished) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.seconds * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (wkself.toastDismissBlock) wkself.toastDismissBlock();
            [wkself dismiss];
        });
    }];
    [[self topView] addSubview:self];
    [self showAnimation];
}

- (void)showAnimation {
    CAKeyframeAnimation *popAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    popAnimation.duration = 0.3;
    popAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.01f, 0.01f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0f, 1.0f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DIdentity]];
    popAnimation.keyTimes = @[@0.2f, @0.6f];
    popAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [_windonView.layer addAnimation:popAnimation forKey:nil];
}

- (void)dismiss {
    [self hideAnimation];
}

- (void)hideAnimation{
    __weak typeof(self) wkself = self;
    [UIView animateWithDuration:0.4 animations:^{
        _coverView.alpha = 0.0;
        _windonView.alpha = 0.0;
    } completion:^(BOOL finished) {
        [wkself removeFromSuperview];
    }];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if ([touch.view isDescendantOfView:_coverView]) {
        return NO;
    }
    return YES;
}

-(UIView*)topView{
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    return  window;
}

- (CGFloat)calculateHeightWithString:(NSString*)string fontSize:(CGFloat)fontSize width:(CGFloat)width{
    NSDictionary *attrs = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]};
    CGFloat height = [string boundingRectWithSize:CGSizeMake(width, 0) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrs context:nil].size.height;
    //做长度限制
    if (height > kContent_maxH) {
        return kContent_maxH;
    }else{
        return height;
    }
}

- (void)dealloc{
    [[UIDevice currentDevice] endGeneratingDeviceOrientationNotifications];
}

@end

