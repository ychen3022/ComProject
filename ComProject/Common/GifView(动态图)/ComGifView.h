//
//  ComGifView.h
//  项目模板
//
//  Created by ychen on 16/10/8.
//  Copyright © 2016年 ComProject. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ComGifView : UIView
/**
 *  初始化gifView
 *
 *  @param frame     gifView的frame
 *  @param _filePath gif的存放位置
 *
 *  @return gifView
 */
- (id)initWithFrame:(CGRect)frame filePath:(NSString *)filePath;



/**
 *  初始化gifView
 *
 *  @param frame gifView的frame
 *  @param _data gifView的数据
 *
 *  @return gifView
 */
- (id)initWithFrame:(CGRect)frame data:(NSData *)data;



/**
 *  开始gifView
 */
- (void)startGif;



/**
 *  停止gifView
 */
- (void)stopGif;

@end
