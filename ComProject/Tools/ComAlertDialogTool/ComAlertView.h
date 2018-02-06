//
//  ComAlertView.h
//  ComProject
//
//  Created by 陈园 on 2018/1/26.
//  Copyright © 2018年 陈园. All rights reserved.
//

#import "ComAlertViewStyle.h"
@class AlertButtonItem;



typedef NS_ENUM(NSInteger, AlertButtonType) {
    AlertButton_OK = 0,
    AlertButton_CANCEL = 1,
    AlertButton_OTHER = 2
};

typedef void(^AlertButtonItemHandler)(AlertButtonItem *item);
typedef void(^AlertDismissBlock)(void);



@interface AlertButtonItem : NSObject
@property (nonatomic) AlertButtonType type;
@property (nonatomic, copy) NSString *title;
@property (nonatomic) NSUInteger tag;
@property (nonatomic, copy) AlertButtonItemHandler action;
@end



@interface ComAlertView : UIView
/** 设置按钮宽度:如果赋值,菜单按钮宽之和,超过alertView宽,菜单会滚动*/
@property(assign,nonatomic)CGFloat buttonWidth;
/** 是否点击阴影消失*/
@property (nonatomic, assign) BOOL isTapShadowDismiss;
/** 是否Toast风格*/
@property(nonatomic,assign) BOOL isToastStyle;
/** Toast风格多少秒后消失*/
@property(nonatomic,assign) CGFloat seconds;
/** Toast消失后block*/
@property(nonatomic,copy) AlertDismissBlock dismissBlock;

/** 初始化alertView*/
- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message topImageName:(NSString *)imageName;
- (void)addButton:(AlertButtonType)type withTitle:(NSString *)title handler:(AlertButtonItemHandler)handler;
- (void)show;
- (void)dismiss;
@end
