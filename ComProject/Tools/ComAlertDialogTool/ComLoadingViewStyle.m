//
//  ComLoadingViewStyle.m
//  ComProject
//
//  Created by 陈园 on 2018/2/1.
//  Copyright © 2018年 陈园. All rights reserved.
//

#import "ComLoadingViewStyle.h"

@interface ComLoadingViewStyle()
@property (nonatomic, assign) LoadingImageStyle imageStyle;
@property (nonatomic,copy) ComLoadingViewStyleConfigBlock styleConfigBlock;
@end

@implementation ComLoadingViewStyle
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
        [self configLoadingImageStyle:LoadingImageStyle_Default styleConfigBlock:nil];
    }
    return self;
}


#pragma mark -设置toastView的颜色样式
-(void)configLoadingImageStyle:(LoadingImageStyle)imageStyle styleConfigBlock:(ComLoadingViewStyleConfigBlock)styleConfigBlock{
    self.imageStyle = imageStyle;
    self.styleConfigBlock = styleConfigBlock;
    [self.loadingImageArr removeAllObjects];
    switch (imageStyle) {
        case LoadingImageStyle_Custom:
        {
            if (self.styleConfigBlock) {
                self.styleConfigBlock(self);
                break;
            }
        }
        case LoadingImageStyle_Default:
        default:
            self.coverColor = [ComTools getColorWithComColor:ComColorBlack];
            self.windowColor = [ComTools getColorWithComColor:ComColorWhite];
            self.messageColor = [ComTools getColorWithComColor:ComColorGray];
            for (int i = 0; i<24; i++) {
                [self.loadingImageArr addObject:[UIImage imageNamed:[NSString stringWithFormat:@"LoadingCar%d",i]]];
            }
            break;
    }
}

#pragma mark -获取当前loadingView图标样式
-(LoadingImageStyle)getCurrentLoadingImageStyle{
    return self.imageStyle;
}


-(NSMutableArray *)loadingImageArr{
    if (!_loadingImageArr) {
        _loadingImageArr = [[NSMutableArray alloc] init];
    }
    return _loadingImageArr;
}
@end
