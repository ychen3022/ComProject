//
//  ComToolView.h
//  ComProject
//
//  Created by 陈园 on 2017/9/30.
//  Copyright © 2017年 陈园. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, ComCR) {
    ComCR1 = 5,
    ComCR2 = 10
};



@interface ComToolView : NSObject

/** 根据枚举值获取固定圆角大小*/
+(CGFloat )getCornerRadiusWithComCR:(ComCR)radius;

/** 生成指定颜色大小的Image*/
+(UIImage *)createImageWithColor:(UIColor *)color Size:(CGSize)size;

/** 生成圆形view*/
+(void)creatCycleSharpWithView:(UIView *)view;

@end
