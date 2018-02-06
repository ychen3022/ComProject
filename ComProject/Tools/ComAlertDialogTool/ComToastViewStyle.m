//
//  ComToastViewStyle.m
//  ComProject
//
//  Created by 陈园 on 2018/2/1.
//  Copyright © 2018年 陈园. All rights reserved.
//

#import "ComToastViewStyle.h"

@interface ComToastViewStyle()
@property (nonatomic, assign) ToastColorStyle colorStyle;
@property (nonatomic,copy) ComToastViewStyleConfigBlock styleConfigBlock;
@end



@implementation ComToastViewStyle
static id sharedInstance = nil;
+ (instancetype)sharedInstance {
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [super allocWithZone:zone];
    });
    return sharedInstance;
}

- (instancetype)copyWithZone:(NSZone *)zone{
    return sharedInstance;
}

- (instancetype)mutableCopyWithZone:(NSZone *)zone {
    return sharedInstance;
}

-(instancetype)init{
    self = [super init];
    if (self) {
        [self configToastColorStyle:ToastColorStyle_Black styleConfigBlock:nil];
    }
    return self;
}


#pragma mark -设置toastView的颜色样式
-(void)configToastColorStyle:(ToastColorStyle)colorStyle styleConfigBlock:(ComToastViewStyleConfigBlock)styleConfigBlock{
    self.colorStyle = colorStyle;
    self.styleConfigBlock = styleConfigBlock;
    switch (colorStyle) {
        case ToastColorStyle_Custom:
        {
            if (self.styleConfigBlock) {
                self.styleConfigBlock(self);
                break;
            }
        }
        case ToastColorStyle_White:
        {
            self.coverColor = [ComTools getColorWithComColor:ComColorBlack];
            self.windowColor = [ComTools getColorWithComColor:ComColorWhite];
            self.messageColor = [ComTools getColorWithComColor:ComColorBlack];
            break;
        }
        case ToastColorStyle_Black:
        default:
            self.coverColor = [UIColor clearColor];
            self.windowColor = [ComTools getColorWithComColor:ComColorLightBlack alpha:0.5];
            self.messageColor = [ComTools getColorWithComColor:ComColorWhite];
            break;
    }
}

#pragma mark -获取当前toastView颜色样式
-(ToastColorStyle)getCurrentToastColorStyle{
    return self.colorStyle;
}

@end
