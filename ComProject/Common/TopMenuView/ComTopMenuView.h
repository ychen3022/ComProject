//
//  ComTopMenuView.h
//  RKTopTagsMenu
//
//  Created by ychen on 16/10/25.
//  Copyright © 2016年 Snail. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  block方法
 *
 *  @param titleIndex Menu中选中按钮的位置
 */
typedef void(^ComTopMenuViewBlock)(int titleIndex);



@interface ComTopMenuView : UIView

/** 第一个按钮的起点X坐标*/
@property(nonatomic,assign)CGFloat firstBtnOriginX;

/** 两个按钮之间的横向间距*/
@property(nonatomic,assign)CGFloat btnSpace;

/** 按钮中标题文字与按钮边框的左右间距之和   (标题距离边框两边的距离和)*/
@property(nonatomic,assign)CGFloat titleSpace;

/** 按钮平常字体的大小*/
@property(nonatomic,assign)CGFloat titleNormalSize;

/** 按钮选中字体大小*/
@property(nonatomic,assign)CGFloat titleSelectedSize;

/** 按钮平常字体颜色*/
@property(nonatomic,strong)UIColor *titleNormalColor;

/** 按钮选中字体颜色*/
@property(nonatomic,strong)UIColor *titleSelectedColor;




/** 定义block，点击摸一个Btn的回调*/
@property(nonatomic,copy)ComTopMenuViewBlock myBlock;

/** 保存菜单视图上的所有button*/
@property(nonatomic,strong)NSMutableArray *allButtonArr;



/**
 *  设置TopMenuView的btn的显示文字数组
 *
 *  @param titlesArray btn上显示的文字
 */
- (void)creatTopMenuViewWithTitlesArray:(NSArray *)titlesArray;



/**
 *  TopMenuView中button的点击事件
 *
 *  @param  sender 点击的button
 */
-(void)btnAction:(UIButton *)sender;

@end





















