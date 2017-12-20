//
//  TopCircleView.h
//  CirCleView
//
//  Created by ychen on 17/1/21.
//  Copyright © 2017年 ychen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, KScrollDirection){
    KScrollFromRightToLeft = 0,
    KScrollFromLeftToRight = 1
};

typedef NS_ENUM(NSInteger, KSourceType){
    KSourceOnlineType = 0,
    KSourceLocalType = 1
};


typedef void(^ClickImageBlock)(NSInteger index,NSString *imgStr,UIImage *img);


@interface TopCircleView : UIView

/** 广告轮播的时间间隔 */
@property (nonatomic, assign) NSTimeInterval timeInterval;
/** 滚动的方向 */
@property (nonatomic,assign) KScrollDirection direction;

/** 分页栏背景的背景色*/
@property (nonatomic,strong) UIColor *bottomBGViewColor;
/** 分页栏背景的透明度 */
@property (nonatomic, assign)CGFloat alpha;
/** 分页栏背景的高度 */
@property (nonatomic, assign)CGFloat bottomBGViewHeight;
/** 隐藏底部分页栏背景 */
@property (nonatomic, assign)BOOL hideBottomBGView;
/** 隐藏底部分页栏 */
@property (nonatomic, assign)BOOL hidePageControl;
/** 分页栏的指示颜色 */
@property (nonatomic, weak)UIColor *pageIndicatorTintColor;
/** 分页栏当前分页的指示颜色 */
@property (nonatomic, weak)UIColor *currentPageIndicatorTintColor;

/** 点击图片的回调*/
@property(nonatomic,copy)ClickImageBlock clickImageBlock;



/**
 设置本地照片

 @param dataSource 存放本地照片数组
 @param block 点击照片回调
 */
-(void)setUpLocalImageWithSource:(NSArray<NSString *> *)dataSource clickBlock:(ClickImageBlock)block;



/**
  设置网络照片

 @param dataSourece 存放网络照片的数组
 @param placeHolderImage 占位图片
 @param block 点击照片回调
 */
-(void)setUpOnlineImageWithSource:(NSArray<NSString *>*)dataSourece PlaceHolderImage:(UIImage *)placeHolderImage ClickBlock:(ClickImageBlock)block;



/**
 开启计时器
 */
-(void)startTimer;



/**
 关闭计时器
 */
-(void)stopTimer;



/**
 销毁计时器
 */
-(void)invalidateTimer;



/**
 初始化波浪View
 
 @param duration 持续时间(duration = 0默认波浪不消失)
 @param speed 波动速度
 @param height 波浪高度
 @param color 波浪颜色
 */
- (void)setUpWavingWithDuration:(NSTimeInterval)duration
                       WaveSpeed:(CGFloat)speed
                      WaveHeight:(CGFloat)height
                       WaveColor:(UIColor *)color;



/**
 开始波浪
 */
-(void)startWaving;



/**
 停止波浪
 */
-(void)stopWaving;


@end
