//
//  UIBarButtonItem+Ext.h
//  项目模板
//
//  Created by ychen on 16/10/8.
//  Copyright © 2016年 ComProject. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Ext)

/**
 *  设置UIBarButtonItem的样式
 *
 *  @param imageStr     一般情况下的显示image
 *  @param highImageStr  点击情况下的显示image
 *  @param target       target是谁
 *  @param action       action对于的操作
 *
 *  @return UIBarButtonItem
 */
+(instancetype)itemWithImage:(NSString *)imageStr andHighImage:(NSString *)highImageStr target:(id)target action:(SEL)action;

@end
