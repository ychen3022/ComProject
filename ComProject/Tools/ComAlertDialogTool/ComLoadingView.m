//
//  ComLoadingView.m
//  ComProject
//
//  Created by 陈园 on 2018/2/1.
//  Copyright © 2018年 陈园. All rights reserved.
//

#import "ComLoadingView.h"

#define kLoadingImageView_W 45
#define kLoadingImageView_H 45
#define kLoadingImageView_Padding 25
#define kWindowView_W 165
#define kWindowView_H 120

#define kContent_maxH KScreenH - kWindowView_H - 2 * kWindowView_Padding
#define kMessage_Font 14

#define kLoadingTimeOut 50
#define kLoadingViewTag 66666
#define kWindowLoadingViewTag 66667



@interface ComLoadingView()<CAAnimationDelegate>
/** LoadingView上的image动画显示计数*/
@property(nonatomic,assign)NSInteger timeoutCount;
/** LoadingView上的image动画显示计数 >= (是否超时) kLoadingTimeOut*/
@property(nonatomic,assign)BOOL isTimeOut;
/** LoadingView上的image动画是否消失*/
@property(nonatomic,assign)BOOL isDismiss;
/** LoadingView上的控件*/
@property (nonatomic, strong) UIView *coverView;
@property (nonatomic, strong) UIView *windonView;
@property (nonatomic, strong) UIImageView *loadingImgView;
@property (nonatomic, strong) UILabel *loadingMessageLabel;
/** LoadingView上的控件内容*/
@property (nonatomic, strong) UIImage *reminderImage;
@property (nonatomic, strong) NSMutableArray *loadingImageArray;
@property (nonatomic, copy) NSString *messageStr;
@end

@implementation ComLoadingView
#pragma mark -初始化loadingView
-(instancetype)initWithMessage:(NSString *)message LoadingImage:(UIImage *)image Frame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.reminderImage = image;
        self.messageStr = message;
        [self creatLoadingView];
        self.tag = kWindowLoadingViewTag;
    }
    return self;
}

-(instancetype)initWithMessage:(NSString *)message LoadingImageArray:(NSArray *)images Frame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.loadingImageArray = [NSMutableArray arrayWithArray:images];
        self.messageStr = message;
        [self creatLoadingView];
        self.tag = kWindowLoadingViewTag;
        [self addNotificationObserver];
    }
    return self;
}

-(instancetype)initWithLoadingImage:(UIImage *)image Frame:(CGRect)frame{
    if ( self = [super initWithFrame:frame]) {
        self.reminderImage = image;
        [self creatLoadingView];
        self.tag = kWindowLoadingViewTag;
    }
    return self;
}

-(instancetype)initWithLoadingImageArray:(NSArray *)images Frame:(CGRect)frame{
    if ( self = [super initWithFrame:frame]) {
        self.loadingImageArray = [NSMutableArray arrayWithArray:images];
        [self creatLoadingView];
        self.tag = kWindowLoadingViewTag;
        [self addNotificationObserver];
    }
    return self;
}

#pragma mark -布局
-(void)creatLoadingView{
    self.backgroundColor = [UIColor clearColor];
    
    //coverView
    _coverView = [[UIView alloc] initWithFrame:self.frame];
    _coverView.backgroundColor = [ComLoadingViewStyle sharedInstance].coverColor;
    _coverView.alpha = 0;
    _coverView.userInteractionEnabled = NO;
    _coverView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self addSubview:_coverView];
    
    //windonView
    _windonView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWindowView_W, kWindowView_H)];
    _windonView.center = CGPointMake(_coverView.frame.size.width/2,_coverView.frame.size.height/2);
    _windonView.backgroundColor = [ComLoadingViewStyle sharedInstance].windowColor;
    _windonView.layer.cornerRadius = 5;
    _windonView.layer.masksToBounds = YES;
    [_coverView addSubview:_windonView];
    
    //loadingImgView
    _loadingImgView = [[UIImageView alloc] initWithFrame:CGRectMake((kWindowView_W-kLoadingImageView_W)/2, kLoadingImageView_Padding, kLoadingImageView_W, kLoadingImageView_H)];
    [_windonView addSubview:_loadingImgView];
    
    //loadingMessageLabel
    CGFloat messageHeigh = [self calculateHeightWithString:self.messageStr fontSize:kMessage_Font width:kWindowView_W];
    _loadingMessageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, _loadingImgView.bottom + kLoadingImageView_Padding, kWindowView_W, messageHeigh)];
    _loadingMessageLabel.font = [UIFont boldSystemFontOfSize:kMessage_Font];
    _loadingMessageLabel.textColor = [ComLoadingViewStyle sharedInstance].messageColor;;
    _loadingMessageLabel.textAlignment = NSTextAlignmentCenter;
    _loadingMessageLabel.numberOfLines = 0;
    _loadingMessageLabel.text = self.messageStr;
    _loadingMessageLabel.lineBreakMode = NSLineBreakByCharWrapping;
    [_windonView addSubview:_loadingMessageLabel];
    
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
}

#pragma mark -调整布局
-(void)willMoveToSuperview:(UIView *)newSuperview{
    CGFloat height = _loadingMessageLabel.bottom + kLoadingImageView_Padding;;
    _windonView.height = height;
    _windonView.center = _coverView.center;
    if([ComTools isBlankString:self.messageStr]){
        _loadingImgView.top+=15 ;
    }
}

#pragma mark -事件
-(void)showWithAnimated:(BOOL)animated{
    __weak typeof(self) wkself = self;
    [self isHaveSuperView];
    if (animated) {
        [UIView animateWithDuration:0.5 animations:^{
            _coverView.alpha = 0.5;
        } completion:^(BOOL finished) {
        }];
    }else{
        _coverView.alpha = 0.5;
    }
    if (self.isAutoDismiss) {//是否自动消失
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [wkself dismissWithCompletionBlock:^{
                if (wkself.dismissBlock) {
                    wkself.dismissBlock();
                }
            }];
        });
    }
    self.isTimeOut = NO;
    self.isDismiss = NO;
    self.timeoutCount = 1;
    [self toShowImagesAnimation];
}

-(void)toShowImagesAnimation{
    if (self.loadingImageArray.count>0) {
        [self.loadingImgView.layer removeAllAnimations];
        CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"contents"];
        animation.removedOnCompletion = NO;
        animation.duration = 0.9;
        animation.delegate = self;
        animation.repeatCount = 0;
        animation.fillMode = kCAFillModeForwards;
        NSMutableArray *array = [NSMutableArray array];
        for (UIImage *img in self.loadingImageArray) {
            CGImageRef cgimg = img.CGImage;
            [array addObject:(__bridge UIImage *)cgimg];
        }
        animation.values = array;
        [self.loadingImgView.layer addAnimation:animation forKey:@"pullImageAnimation"];
    }else{
        self.loadingImgView.image = self.reminderImage;
    }
}

#pragma mark -- animation delegate
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    BOOL isContinueAnimation = YES;
    if (self.tag == kLoadingViewTag) {
        if (self.superView == nil) {//如果是在父视图中加载loading的样式，当父视图已经释放，则不再继续loading动画，以免造成死循环。
            isContinueAnimation = NO;
        }
    }
    if (isContinueAnimation) {
        if (flag) {
            self.timeoutCount++;
        }
        if (self.timeoutCount>=kLoadingTimeOut) {
            self.timeoutCount = 1;
            self.isTimeOut = YES;
        }
        if (self.isTimeOut) {
            __weak typeof(self) wkself = self;
            [self dismissWithCompletionBlock:^{
                if (wkself.loadingTimeOutBlock) {
                    wkself.loadingTimeOutBlock();
                }
            }];
        }else{
            if (!self.isDismiss) {
                [self toShowImagesAnimation];
            }
        }
    }else{
        [self dismiss];
    }
}

-(void)dismiss{
    self.isDismiss = YES;
    [self.loadingImgView.layer removeAllAnimations];
    [self removeFromSuperview];
}

- (void)dismissWithCompletionBlock:(LoadingDismissBlock)block{
    __weak typeof(self) wkself = self;
    [UIView animateWithDuration:0.2 animations:^{
        wkself.alpha = 0.0;
    } completion:^(BOOL finished) {
        if (block) {
            block();
        }
        wkself.isDismiss = YES;
        [wkself.loadingImgView.layer removeAllAnimations];
        [wkself removeFromSuperview];
    }];
}



#pragma mark -设置父视图
-(void)setSuperView:(UIView *)superView{
    _superView = superView;
    if ([superView isKindOfClass:[UIWindow class]]) {
        self.tag = kWindowLoadingViewTag;
    }else{
        self.tag = kLoadingViewTag;
    }
}

-(void)isHaveSuperView{
    if (_superView) {
        [_superView addSubview:self];
    }else{
        [[self topView] addSubview:self];
    }
}

-(UIView*)topView{
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    return  window;
}

-(void)addNotificationObserver{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resumeAnimation) name:UIApplicationDidBecomeActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pauseAnimation) name:UIApplicationWillResignActiveNotification object:nil];
}

-(void)resumeAnimation{
    [self resumeLayer:self.loadingImgView.layer];
}

-(void)pauseAnimation{
    [self pauseLayer:self.loadingImgView.layer];
}

- (void)resumeLayer:(CALayer*)layer{
    CFTimeInterval pausedTime = [layer timeOffset];
    layer.speed = 1.0;
    layer.timeOffset = 0.0;
    layer.beginTime = 0.0;
    CFTimeInterval timeSincePause = [layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    layer.beginTime = timeSincePause;
}

- (void)pauseLayer:(CALayer*)layer{
    CFTimeInterval pausedTime = [layer convertTime:CACurrentMediaTime() fromLayer:nil];
    layer.speed = 0.0;
    layer.timeOffset = pausedTime;
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (CGFloat)calculateHeightWithString:(NSString*)string fontSize:(CGFloat)fontSize width:(CGFloat)width{
    NSDictionary *attrs = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]};
    CGFloat height = [string boundingRectWithSize:CGSizeMake(width, 0) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrs context:nil].size.height;
    return height;
}

#pragma mark -从窗体上查找存在的ComLoadingView
+(ComLoadingView *)getCurrentLoadingViewFromWindow{
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    UIView *targetView = [window viewWithTag:kWindowLoadingViewTag];
    if (targetView) {
        if ([targetView isKindOfClass:[ComLoadingView class]]) {
            return targetView;
        }
    }
    return nil;
}

#pragma mark -从指定的视图中查找存在的ComLoadingView
+(ComLoadingView *)getCurrentLoadingViewFromSuperView:(UIView *)superView{
    UIView *targetView = [superView viewWithTag:kLoadingViewTag];
    if (targetView) {
        if ([targetView isKindOfClass:[ComLoadingView class]]) {
            return targetView;
        }
    }
    return nil;
}
@end
