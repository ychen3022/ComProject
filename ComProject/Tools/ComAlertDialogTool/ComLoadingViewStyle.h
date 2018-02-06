//
//  ComLoadingViewStyle.h
//  ComProject
//
//  Created by 陈园 on 2018/2/1.
//  Copyright © 2018年 陈园. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ComLoadingViewStyle;


typedef NS_ENUM(NSInteger, LoadingImageStyle) {
    LoadingImageStyle_Custom = 0,     //自定义
    LoadingImageStyle_Default = 1,    //默认加载图标
};

/** 设置ComLoadingViewStyle样式block*/
typedef void(^ComLoadingViewStyleConfigBlock)(ComLoadingViewStyle *loadingViewStyle);



@interface ComLoadingViewStyle : NSObject
@property (nonatomic, strong) UIColor *coverColor;//浮层颜色
@property (nonatomic, strong) UIColor *windowColor;//窗体颜色
@property (nonatomic, strong) UIColor *messageColor;//字体颜色
@property (nonatomic, strong) NSMutableArray *loadingImageArr;//加载图标数组，24张最佳

//单例方法
+(instancetype)sharedInstance;

/** 设置LoadingView的加载样式*/
/** 在block回调中对单例BTBaseLoadingViewStyle设置可以自定义加载图标，不设置或者设置block=nil显示默认加载图标*/
-(void)configLoadingImageStyle:(LoadingImageStyle)imageStyle styleConfigBlock:(ComLoadingViewStyleConfigBlock)styleConfigBlock;

/** 获取当前loadingView图标样式*/
-(LoadingImageStyle)getCurrentLoadingImageStyle;

@end

