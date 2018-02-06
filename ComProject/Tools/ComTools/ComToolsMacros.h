//
//  ComToolsMacros.h
//  ComProject
//
//  Created by 陈园 on 2017/12/20.
//  Copyright © 2017年 陈园. All rights reserved.
//

#ifndef ComToolsMacros_h
#define ComToolsMacros_h

/** 获取屏幕的宽度*/
#define KScreenW [UIScreen mainScreen].bounds.size.width

/** 获取屏幕的高度*/
#define KScreenH [UIScreen mainScreen].bounds.size.height

/** 设置RGB格式颜色*/
#define KColorWithRGB(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

/** 设置RGBA格式颜色+透明度*/
#define KColorWithRGBA(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(r)/255.0 blue:(r)/255.0 alpha:a]

/** 设置随机颜色*/
#define KRandomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0]

/** 当前系统大于等于系统版本v*/
#define kSystemVersion_GreaterThan_Or_Equal_To(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

/** 当前系统大于等于iOS10*/
#define kiOS10_Or_Later ( [[[UIDevice currentDevice] systemVersion] compare:@"10.0" options:NSNumericSearch] != NSOrderedAscending )

/** 当前系统大于等于iOS9*/
#define kiOS9_Or_Later  ( [[[UIDevice currentDevice] systemVersion] compare:@"9.0" options:NSNumericSearch] != NSOrderedAscending )

/** 当前系统大于等于iOS8*/
#define kiOS8_Or_Later  ( [[[UIDevice currentDevice] systemVersion] compare:@"8.0" options:NSNumericSearch] != NSOrderedAscending )



/** 自定义日志打印的NSLog*/
#ifdef DEBUG
#define DLog(...) NSLog(@"+++++\n***********************************\n %@\n\n\n\n",[NSString stringWithFormat:__VA_ARGS__])
#define HLog(...) NSLog(@"%@",[NSString stringWithFormat:__VA_ARGS__])
#else
#define DLog(...)
#define HLog(...)
#endif


#endif /* ComToolsMacros_h */
