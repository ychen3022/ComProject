//
//  ComAlertViewStyle.m
//  ComProject
//
//  Created by 陈园 on 2018/1/26.
//  Copyright © 2018年 陈园. All rights reserved.
//

#import "ComAlertViewStyle.h"

@interface ComAlertViewStyle()
@property (nonatomic, assign) AlertColorStyle colorStyle;
@property (nonatomic,copy) ComAlertViewStyleConfigBlock styleConfigBlock;
@end



@implementation ComAlertViewStyle
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
        [self configAlertColorStyle:AlertColorStyle_System styleConfigBlock:nil];
    }
    return self;
}


#pragma mark -设置alertView的颜色样式
-(void)configAlertColorStyle:(AlertColorStyle)colorStyle styleConfigBlock:(ComAlertViewStyleConfigBlock)styleConfigBlock{
    self.colorStyle = colorStyle;
    self.styleConfigBlock = styleConfigBlock;
    switch (colorStyle) {
        case AlertColorStyle_Custom:
        {
            if (self.styleConfigBlock) {
                self.styleConfigBlock(self);
                break;
            }
        }
        case AlertColorStyle_Red:
        {
            self.labelTitleColor = [ComTools getColorWithComColor:ComColorBlack];
            self.labelMessageColor= [ComTools getColorWithComColor:ComColorLightBlack];
            self.buttonOkColor = [ComTools getColorWithHexString:@"#e83c36"];
            self.buttonCancelColor = [ComTools getColorWithHexString:@"#333333"];
            self.buttonOtherColor = [ComTools getColorWithHexString:@"#333333"];
            break;
        }
        case AlertColorStyle_System:
        default:
            self.labelTitleColor = [ComTools getColorWithHexString:@"#333333"];
            self.labelMessageColor= [ComTools getColorWithHexString:@"#333333"];
            break;
    }
}


#pragma mark -获取当前alertView颜色样式
-(AlertColorStyle)getCurrentAlertColorStyle{
    return self.colorStyle;
}

@end
