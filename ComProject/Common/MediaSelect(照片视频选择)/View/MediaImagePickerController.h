//
//  MediaImagePickerController.h
//  照片视频Demo
//
//  Created by 陈园 on 2017/7/12.
//  Copyright © 2017年 陈园. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MediaImagePickerController : UIImagePickerController

@property (nonatomic ,copy) void(^handleVideoPath)(NSString *path);

@end
