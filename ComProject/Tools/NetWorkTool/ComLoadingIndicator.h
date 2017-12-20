//
//  ComLoadingIndicator.h
//  项目模板
//
//  Created by ychen on 16/10/8.
//  Copyright © 2016年 ComProject. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ComLoadingIndicator : UIView


/**
 *  加载指示器的样式
 */
typedef enum{
    comLoadingIndicatorStyleNone,//不显示加载指示器
    comLoadingIndicatorStyleGif,//显示gif加载指示器，照片可以替换
}ComLoadingIndicatorStyle;



/**
 *  创建加载指示器传回的block
 *
 *  @param returnValue  returnValue,主要是点击加载指示器，取消加载
 */
typedef void(^ComReturnValue)(id returnValue);



/**
 *  开始显示加载指示器
 */
- (void)startLoading;


/**
 *  开始显示加载指示器
 *
 *  @param returnValue 带有返回Block
 */
- (void)startLoadingWithCancel:(ComReturnValue)returnValue;



/**
 *  停止显示加载指示器
 */
- (void)stopLoading;


@end






