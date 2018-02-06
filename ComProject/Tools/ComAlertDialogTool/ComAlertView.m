//
//  ComAlertView.m
//  ComProject
//
//  Created by 陈园 on 2018/1/26.
//  Copyright © 2018年 陈园. All rights reserved.
//

#import "ComAlertView.h"

#define kMainView_W 270
#define kMainView_H 75
#define kAlertView_W 270
#define kAlertView_H 45
#define kAlertView_Padding 25
#define kTopImageView_H 60
#define kItemButton_H 44
#define kContent_maxH KScreenH - kMainView_H - kAlertView_H - kTopImageView_H - kItemButton_H

#define kTitle_Font 17
#define kMessage_Font 14
#define kButton_Font 15


@implementation AlertButtonItem
@end



@interface ComAlertView()<UIGestureRecognizerDelegate>
/** 阴影部分点击手势*/
@property(nonatomic,strong)UITapGestureRecognizer *tapGes;
/** AlertView上的控件*/
@property (nonatomic, strong) UIView *coverView;
@property (nonatomic, strong) UIView *mainView;
@property (nonatomic, strong) UIView *alertView;
@property (nonatomic, strong) UIImageView *topImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextView *messageTextView;
@property (nonatomic, strong) UIScrollView *buttonScrollView;
/** AlertView上的控件内容*/
@property (nonatomic, copy) NSString *topImageName;
@property (nonatomic, copy) NSString *titleStr;
@property (nonatomic, copy) NSString *messageStr;
@property (nonatomic, strong) NSMutableArray *buttonItems;
@end


@implementation ComAlertView
#pragma mark -初始化alertView
- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message topImageName:(NSString *)imageName{
    if (self = [super init]) {
        _topImageName = imageName;
        _titleStr  = title;
        _messageStr = message;
        _buttonItems = [[NSMutableArray alloc] init];
        _isTapShadowDismiss=NO;
        _isToastStyle=NO;
        [self creatAlertView];
    }
    return self;
}

- (void)addButton:(AlertButtonType)type withTitle:(NSString *)title handler:(AlertButtonItemHandler)handler{
    AlertButtonItem *item = [[AlertButtonItem alloc] init];
    item.type = type;
    item.title = title;
    item.action = handler;
    [_buttonItems addObject:item];
    item.tag = [_buttonItems indexOfObject:item];
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
-(void)creatAlertView{
    self.frame = [self topView].bounds;
    self.backgroundColor = [UIColor clearColor];

    //coverView
    _coverView = [[UIView alloc] initWithFrame:[self topView].bounds];
    _coverView.backgroundColor = [UIColor blackColor];
    _coverView.alpha = 0;
    _coverView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _tapGes=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    _tapGes.delegate=self;
    if (_isTapShadowDismiss) {
        [self addGestureRecognizer:_tapGes];
    }
    [[self topView] addSubview:_coverView];
    
    //mainView
    _mainView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainView_W, kMainView_H)];
    _mainView.center = CGPointMake(self.frame.size.width/2,self.frame.size.height/2);
    _mainView.backgroundColor = [UIColor clearColor];
    [self addSubview:_mainView];
    
    //alertView
    _alertView = [[UIView alloc] initWithFrame:CGRectMake(0, 30, kAlertView_W, kAlertView_H)];
    _alertView.layer.cornerRadius = 12.5;
    _alertView.layer.masksToBounds = YES;
    _alertView.backgroundColor = [UIColor whiteColor];
    [_mainView addSubview:_alertView];
    
    //titleLabel
    CGFloat titleHeigh = [self calculateHeightWithString:self.titleStr fontSize:kTitle_Font width:kAlertView_W-2*kAlertView_Padding];
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(kAlertView_Padding, kAlertView_Padding, kAlertView_W-2*kAlertView_Padding, titleHeigh)];
    _titleLabel.font = [UIFont boldSystemFontOfSize:kTitle_Font];
    _titleLabel.textColor = [ComAlertViewStyle sharedInstance].labelTitleColor;
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.numberOfLines = 0;
    _titleLabel.text = _titleStr;
    _titleLabel.lineBreakMode = NSLineBreakByCharWrapping;
    [_alertView addSubview:_titleLabel];
    
    //messageTextView
    CGFloat messageHeigh = [self calculateHeightWithString:self.messageStr fontSize:kMessage_Font width:kAlertView_W-2*kAlertView_Padding];
    if ([ComTools isBlankString:self.titleStr]) {
        _messageTextView = [[UITextView alloc] initWithFrame:CGRectMake(kAlertView_Padding, _titleLabel.bottom, kAlertView_W-2*kAlertView_Padding, messageHeigh)];
    }else{
        _messageTextView = [[UITextView alloc] initWithFrame:CGRectMake(kAlertView_Padding, _titleLabel.bottom+kAlertView_Padding/2, kAlertView_W-2*kAlertView_Padding, messageHeigh)];
    }
    _messageTextView.font = [UIFont systemFontOfSize:kMessage_Font];
    _messageTextView.textColor = [ComAlertViewStyle sharedInstance].labelMessageColor;
    _messageTextView.textAlignment = NSTextAlignmentCenter;
    _messageTextView.editable = NO;
    _messageTextView.textContainerInset = UIEdgeInsetsMake(0, -5, 0, -5);
    _messageTextView.showsVerticalScrollIndicator = NO;
    _messageTextView.text = self.messageStr;
    [_alertView addSubview:_messageTextView];
    if(messageHeigh < kContent_maxH){
        _messageTextView.scrollEnabled = NO;
    }
    
    //topImageName
    if (![ComTools isBlankString:_topImageName]) {
        [self creatTopImageView:_topImageName];
    }
    
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
}

-(void)creatTopImageView:(NSString *)imageName{
    if (!_topImageView) {
        _topImageView=[[UIImageView alloc] initWithFrame:CGRectMake((kMainView_W-kTopImageView_H)/2, 0, kTopImageView_H, kTopImageView_H)];
        _topImageView.image=[UIImage imageNamed:imageName];
        [_mainView addSubview:_topImageView];
        _titleLabel.top+=15;
        _messageTextView.top+=15;
    }
}

- (void)creatButtonItems{
    _buttonScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, _alertView.frame.size.height- kItemButton_H,kAlertView_W, kItemButton_H)];
    _buttonScrollView.bounces = NO;
    _buttonScrollView.showsHorizontalScrollIndicator = NO;
    _buttonScrollView.showsVerticalScrollIndicator =  NO;
    CGFloat  width;
    if(self.buttonWidth){
        width = self.buttonWidth;
        _buttonScrollView.contentSize = CGSizeMake(width*[_buttonItems count], kItemButton_H);
    }else{
        width = _alertView.frame.size.width/[_buttonItems count];
    }
    [_buttonItems enumerateObjectsUsingBlock:^(AlertButtonItem *item, NSUInteger idx, BOOL *stop) {
        UIButton *button;
        if ([[ComAlertViewStyle sharedInstance] getCurrentAlertColorStyle] == AlertColorStyle_System) {//系统样式
            button = [UIButton buttonWithType:UIButtonTypeSystem];
        }else{
            button = [UIButton buttonWithType:UIButtonTypeCustom];
            if (item.type == AlertButton_OK) {
                [button setTitleColor:[ComAlertViewStyle sharedInstance].buttonOkColor forState:UIControlStateNormal];
            }else if (item.type == AlertButton_CANCEL){
                [button setTitleColor:[ComAlertViewStyle sharedInstance].buttonCancelColor forState:UIControlStateNormal];
            }else{
                [button setTitleColor:[ComAlertViewStyle sharedInstance].buttonOtherColor forState:UIControlStateNormal];
            }
        }
        button.frame = CGRectMake(idx*width, 1, width, kItemButton_H);
        button.backgroundColor = [UIColor whiteColor];
        button.layer.shadowColor = [[UIColor grayColor] CGColor];
        button.layer.shadowRadius = 0.5;
        button.layer.shadowOpacity = 1;
        button.layer.shadowOffset = CGSizeZero;
        button.layer.masksToBounds = NO;
        button.tag = 90000+ idx;
        [button setTitle:item.title forState:UIControlStateNormal];
        [button setTitle:item.title forState:UIControlStateSelected];
        [button.titleLabel setFont:[UIFont systemFontOfSize:kButton_Font]];
        [button addTarget:self action:@selector(buttonTouched:) forControlEvents:UIControlEventTouchUpInside];
        [_buttonScrollView addSubview:button];
    }];
    [_alertView addSubview:_buttonScrollView];
}

#pragma mark -调整布局
-(void)willMoveToSuperview:(UIView *)newSuperview{
    if(self.buttonItems.count > 0){
        [self creatButtonItems];
    }
    if (_isToastStyle) {
        CGFloat height = _messageTextView.bottom + kAlertView_Padding ;
        _mainView.height = height + 30;
        _mainView.center = self.center;
        _alertView.height = height;
        _mainView.top -=15;
    } else {
        CGFloat height = _messageTextView.bottom + kAlertView_Padding + kItemButton_H;
        _mainView.height = height + 30;
        _mainView.center = self.center;
        _alertView.height = height;
        _mainView.top -=15;
        _buttonScrollView.frame = CGRectMake(0, _alertView.frame.size.height-kItemButton_H,_alertView.frame.size.width, kItemButton_H);
    }
}

#pragma mark -事件
- (void)buttonTouched:(UIButton*)button{
    AlertButtonItem *item = _buttonItems[button.tag-90000];
    if (item.action) {
        item.action(item);
    }
    [self dismiss];
}

- (void)show {
    __weak typeof(self) wkself = self;
    [UIView animateWithDuration:0.5 animations:^{
        _coverView.alpha = 0.5;
    } completion:^(BOOL finished) {
        if (wkself.isToastStyle) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.seconds * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if (wkself.dismissBlock) wkself.dismissBlock();
                [wkself dismiss];
            });
        }
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
    [_mainView.layer addAnimation:popAnimation forKey:nil];
}

- (void)dismiss {
    [self hideAnimation];
}

- (void)hideAnimation{
    __weak typeof(self) wkself = self;
    [UIView animateWithDuration:0.4 animations:^{
        _coverView.alpha = 0.0;
        _mainView.alpha = 0.0;
        
    } completion:^(BOOL finished) {
        [wkself removeFromSuperview];
    }];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if ([touch.view isDescendantOfView:_mainView]) {
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

