//
//  UIBarButtonItem+Ext.m
//  项目模板
//
//  Created by ychen on 16/10/8.
//  Copyright © 2016年 ComProject. All rights reserved.
//

#import "UIBarButtonItem+Ext.h"

@implementation UIBarButtonItem (Ext)

#pragma mark - *  设置UIBarButtonItem的样式
+(instancetype)itemWithImage:(NSString *)imageStr andHighImage:(NSString *)highImageStr target:(id)target action:(SEL)action{
    
    UIButton *itemBtn=[[UIButton alloc] init];
    [itemBtn setBackgroundImage:[UIImage imageNamed:imageStr] forState:UIControlStateNormal];
    [itemBtn setBackgroundImage:[UIImage imageNamed:highImageStr] forState:UIControlStateHighlighted];
    itemBtn.size=itemBtn.currentBackgroundImage.size;
    [itemBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[self alloc] initWithCustomView:itemBtn];
}
@end
