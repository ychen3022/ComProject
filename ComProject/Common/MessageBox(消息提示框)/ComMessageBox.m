//
//  ComMessageBox.m
//  项目模板
//
//  Created by ychen on 16/10/8.
//  Copyright © 2016年 ComProject. All rights reserved.
//

#import "ComMessageBox.h"
#import "MBProgressHUD.h"


@implementation ComMessageBox


+(void)showMessageBoxWithStyle:(ComMessageBoxStyle)style title:(NSString *)title message:(NSString *)message{
    switch (style) {
        //AlertView样式的messageBox
        case comMessageBoxStyleAlert:
        {
            if ([[UIDevice currentDevice] systemVersion].floatValue < 8.0) {//小于8.0,使用UIAlertView
                UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:title
                                                                 message:message
                                                                delegate:self
                                                       cancelButtonTitle:@"知道啦"
                                                        otherButtonTitles:nil];
                [alertView show];
            
            }else{//大于等于8.0,使用UIAlertViewController
                UIAlertController *alertVC=[UIAlertController alertControllerWithTitle:title
                                                                               message:message
                                                                        preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *cancelAction=[UIAlertAction actionWithTitle:@"知道啦"
                                                                     style:UIAlertActionStyleCancel
                                                                   handler:nil];
                
               
                [alertVC addAction:cancelAction];
                [[ComTools getCurrentViewController] presentViewController:alertVC animated:YES completion:nil];
            }
        }
            break;

            //HUD样式的messageBox
        case comMessageBoxStyleHUD:
        {
            MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:[ComTools getCurrentViewController].view animated:YES];
            hud.alpha=0.9;
            hud.mode = MBProgressHUDModeText;
            hud.detailsLabel.text=message;
            [hud hideAnimated:YES afterDelay:2.0f];
        }
            break;
            
            //不显示messageBox
        case comMessageBoxStyleNone:
        default:
            return;
            break;
    }
}

@end
