//
//  ComToolView.m
//  ComProject
//
//  Created by 陈园 on 2017/9/30.
//  Copyright © 2017年 陈园. All rights reserved.
//

#import "ComToolView.h"

@implementation ComToolView

#pragma mark -根据枚举值获取固定圆角大小
+(CGFloat )getCornerRadiusWithComCR:(ComCR)radius{
    return radius/2;
}

#pragma mark -生成指定颜色大小的Image
+(UIImage *)createImageWithColor:(UIColor *)color Size:(CGSize)size{
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

+(void)creatCycleSharpWithView:(UIView *)view{
    [view.layer setCornerRadius:CGRectGetHeight([view bounds]) / 2];
    view.layer.masksToBounds=YES;
}

@end
