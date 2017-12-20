//
//  UIView+Ext.h
//  项目模板
//
//  Created by ychen on 16/10/8.
//  Copyright © 2016年 ComProject. All rights reserved.
//

#import <UIKit/UIKit.h>

CGPoint CGRectGetCenter(CGRect rect);
CGRect  CGRectMoveToCenter(CGRect rect, CGPoint center);


@interface UIView (Ext)

@property CGPoint origin;
@property CGSize size;
@property CGFloat width;
@property CGFloat height;
@property CGFloat centerY;
@property CGFloat centerX;
@property CGFloat top;
@property CGFloat bottom;
@property CGFloat left;
@property CGFloat right;



/**
 *  视图中心移动
 *
 *  @param delta 偏移量
 */
- (void) moveBy: (CGPoint) delta;

/**
 *  视图缩放
 *
 *  @param scaleFactor 比例
 */
- (void) scaleBy: (CGFloat) scaleFactor;

/**
 *  视图按 新Size长边缩放
 *
 *  @param aSize 新边框大小
 */
- (void) fitInSize: (CGSize) aSize;

/**
 *  视图垂直方向动画移动到y坐标
 *
 *  @param y 垂直方向的坐标
 */
-(void)viewMoveToY:(float)y;



-(void)makeCycleSharp;
- (void)addTopLine;
- (void)addTopLineWithHexColor:(NSString *)hexColor;
- (void)removeTopLine;
- (void)addUnderLine;
- (void)addUnderLineWithHexColor:(NSString *)hexColor;
- (void)removeUnderLine;
- (void)addLeftLine;
- (void)addLeftLineWithHexColor:(NSString *)hexColor;
- (void)removeLeftLine;
- (void)addRightLine;
- (void)addRightLineWithHexColor:(NSString *)hexColor;
- (void)removeRightLine;

- (void)addLineWithEdgeInset:(UIEdgeInsets)inset;
@end
