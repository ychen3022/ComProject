//
//  ComMessageBox.h
//  项目模板
//
//  Created by ychen on 16/10/8.
//  Copyright © 2016年 ComProject. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ComMessageBox : NSObject

/**
 * ComMessageBox的样式
 *
 * comMessageBoxStyleNone 不显示messageBox
 * comMessageBoxStyleAlert AlertView样式的messageBox
 * comMessageBoxStyleHUD HUD样式的messageBox
 */
typedef enum{
    comMessageBoxStyleNone,
    comMessageBoxStyleAlert,
    comMessageBoxStyleHUD,
}ComMessageBoxStyle;



/**
 *  提示信息的弹框
 *
 *  @param style   弹框类型
 *  @param title   弹框的title
 *  @param message 弹框的message
 */
+(void)showMessageBoxWithStyle:(ComMessageBoxStyle)style title:(NSString *)title message:(NSString *)message;

@end




