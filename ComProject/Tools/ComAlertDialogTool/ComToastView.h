//
//  ComToastView.h
//  ComProject
//
//  Created by 陈园 on 2018/2/1.
//  Copyright © 2018年 陈园. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void(^ToastDismissBlock)(void);



@interface ComToastView : UIView
/** 是否点击阴影消失*/
@property (nonatomic, assign) BOOL isTapShadowDismiss;
/** Toast多少秒后消失*/
@property(nonatomic,assign) CGFloat seconds;
/** Toast消失后block*/
@property(nonatomic,copy) ToastDismissBlock toastDismissBlock;

/** 初始化toastView*/
- (instancetype)initMessage:(NSString *)message;
- (void)show;
- (void)dismiss;
@end
