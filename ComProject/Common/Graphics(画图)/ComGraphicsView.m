//
//  ComGraphicsView.m
//  ComProject
//
//  Created by 陈园 on 2017/11/2.
//  Copyright © 2017年 陈园. All rights reserved.
//

#import "ComGraphicsView.h"
#import <CoreText/CoreText.h>

@implementation ComGraphicsView



-(void)drawLine:(CGContextRef)ctx{
//    1.画一条简单的线,从起点到终点
    CGPoint points1[] = {CGPointMake(10, 30),CGPointMake(300, 40)};
    CGContextAddLines(ctx,points1, 2);
    CGContextStrokePath(ctx);//描出笔触
    
    
//    2.画线方法2 ,使用CGContextAddLineToPoint画线，需要先设置一个起始点
//      设置起始点
    CGContextMoveToPoint(ctx, 50, 50);
    //添加一个点
    CGContextAddLineToPoint(ctx, 100,50);
    //在添加一个点，变成折线
    CGContextAddLineToPoint(ctx, 150, 100);
    CGContextStrokePath(ctx);//描出笔触


//    3.画线方法3:构造线路径的点数组
    CGPoint points2[] = {CGPointMake(60, 60),CGPointMake(80, 120),CGPointMake(20, 300)};
    CGContextAddLines(ctx,points2, 3);
    CGContextStrokePath(ctx);//描出笔触
   

//    4.利用路径去画一组点（推荐使用路径的方式，虽然多了几行代码，但是逻辑更清晰了）
//    第一个路径
    CGMutablePathRef path1 = CGPathCreateMutable();
    CGPathMoveToPoint(path1, &CGAffineTransformIdentity, 0, 200);
    //CGAffineTransformIdentity 类似于初始化一些参数
    CGPathAddLineToPoint(path1, &CGAffineTransformIdentity, 100, 250);
    CGPathAddLineToPoint(path1, &CGAffineTransformIdentity, 310, 210);
    //路径1加入context
    CGContextAddPath(ctx, path1);
    //path同样有方法CGPathAddLines(),和CGContextAddLines()差不多用户，可以自己试下
     CGContextStrokePath(ctx);//描出笔触
}

-(void)drawSharp:(CGContextRef)ctx{
    CGContextSetFillColorWithColor(ctx, [UIColor redColor].CGColor);
    
    //画椭圆，如果长宽相等就是圆
    CGContextAddEllipseInRect(ctx, CGRectMake(0, 250, 50, 50));
    
    //画矩形,长宽相等就是正方形
    CGContextAddRect(ctx, CGRectMake(70, 250, 50, 50));
    
    //画多边形，多边形是通过path完成的
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, &CGAffineTransformIdentity, 120, 250);
    CGPathAddLineToPoint(path, &CGAffineTransformIdentity, 200, 250);
    CGPathAddLineToPoint(path, &CGAffineTransformIdentity, 180, 300);
    CGPathCloseSubpath(path);
    CGContextAddPath(ctx, path);
    
    //填充
    CGContextFillPath(ctx);
}


-(void)drawPicture:(CGContextRef)ctx{
    UIImage *image = [UIImage imageNamed:@"commentLikeButtonClick"];
    [image drawInRect:CGRectMake(10, 300, 100, 100)];
}

-(void)drawCircle:(CGContextRef)ctx{
    /* 绘制路径 方法一
     void CGContextAddArc (
     CGContextRef c,
     CGFloat x,             //圆心的x坐标
     CGFloat y,    //圆心的x坐标
     CGFloat radius,   //圆的半径
     CGFloat startAngle,    //开始弧度
     CGFloat endAngle,   //结束弧度
     int clockwise          //0表示顺时针，1表示逆时针
     );
     */
//    CGContextSetStrokeColorWithColor(ctx, [UIColor purpleColor].CGColor);
//    CGContextAddArc(ctx, 50, 50, 50, 0, M_PI*2, 0);
//    CGContextStrokePath(ctx);
//
//    CGContextAddArc(ctx, 100, 200, 50, 0, M_PI*0.5, 0);
//    CGContextStrokePath(ctx);
    
    
    //绘制路径 方法二
//    这方法适合绘制弧度 ，端点p1和p2是弧线的控制点，类似photeshop中钢笔工具控制曲线，还不明白请去了解贝塞尔曲线
    //    void CGContextAddArcToPoint(
    //                                CGContextRef c,
    //                                CGFloat x1,  //端点1的x坐标
    //                                CGFloat y1,  //端点1的y坐标
    //                                CGFloat x2,  //端点2的x坐标
    //                                CGFloat y2,  //端点2的y坐标
    //                                CGFloat radius //半径
    //                                );
    CGContextMoveToPoint(ctx, 100, 100);
    CGContextAddArcToPoint(ctx, 200, 100,300, 100, 100);
//    CGContextAddArcToPoint(ctx, 400, 100,400, 200, 100);
//    CGContextAddArcToPoint(ctx, 400, 300,300, 300, 100);
//    CGContextAddArcToPoint(ctx, 200, 300,200, 200, 100);
    CGContextStrokePath(ctx);
    
}


-(void)drawText:(CGContextRef)ctx{
    NSString *str =@"张三丰3022";
    [str drawInRect:CGRectMake(100, 100, 100, 100) withAttributes:nil];
    CGPoint points1[] = {CGPointMake(10, 30),CGPointMake(300, 40)};
    CGContextAddLines(ctx,points1, 2);
    
}


-(void)drawWaterSign:(CGContextRef)ctx{
    CGFloat startX =100;
    CGFloat startY =100;
    CGFloat width = 50;
    CGFloat height = 50;
    CGFloat space = 10;
    
    CGRect hourRect = CGRectMake(startX, startY, width, height);
    UIBezierPath* hourPath = [UIBezierPath bezierPathWithRect:hourRect];
//    [KMainItemColor setFill];
    [hourPath fill];
//    [whiteColor setFill];
    NSAttributedString *hourAttri = [[NSAttributedString alloc] initWithString:@"hahahah "
                                                                    attributes:nil];
    [hourAttri drawAtPoint:CGPointMake(CGRectGetMidX(hourRect)-hourAttri.size.width/2, CGRectGetMidY(hourRect)-hourAttri.size.height/2)];
}

















//- (void)drawRect:(CGRect)rect{
//    CGContextRef ctx = UIGraphicsGetCurrentContext();  // 获取该控件的绘图CGContextRef
//    CGContextSetCharacterSpacing (ctx, 4);  // 设置字符间距
//    CGContextSetRGBFillColor (ctx, 1, 0, 1, 1);  // 设置填充颜色
//    CGContextSetRGBStrokeColor (ctx, 0, 0, 1, 1);  // 设置线条颜色
//    CGContextSetTextDrawingMode (ctx, kCGTextFill);  // 设置使用填充模式绘制文字
//    // 绘制文字
//     [@"疯狂iOS讲义" drawAtPoint:CGPointMake(10 ,20)
//         withAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
//                         [UIFont fontWithName:@"Arial Rounded MT Bold" size: 45],
//                         NSFontAttributeName,
//                         [UIColor magentaColor] , NSForegroundColorAttributeName , nil]];
//
//    // 设置使用描边模式绘制文字
//    CGContextSetTextDrawingMode (ctx, kCGTextStroke);
//    // 绘制文字
//    [@"疯狂Android讲义" drawAtPoint:CGPointMake(10 ,80)
//             withAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
//                             [UIFont fontWithName:@"Heiti SC" size: 40],NSFontAttributeName,
//                             [UIColor blueColor] , NSForegroundColorAttributeName , nil]];
//    // 设置使用填充、描边模式绘制文字
//    CGContextSetTextDrawingMode (ctx, kCGTextFillStroke);
//    // 绘制文字
//    [@"疯狂Ajax讲义" drawAtPoint:CGPointMake(10 ,130)
//          withAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
//                          [UIFont fontWithName:@"Heiti SC" size: 50], NSFontAttributeName,
//                          [UIColor magentaColor] , NSForegroundColorAttributeName , nil]];
//
//
//    // 定义一个垂直镜像的变换矩阵
//     CGAffineTransform yRevert = CGAffineTransformMake(1, 0, 0, -1, 0, 0);
//    // 设置绘制文本的字体和字体大小
//     CGContextSelectFont (ctx, "Courier New" , 10, kCGEncodingMacRoman);
//    // 为yRevert变换矩阵根据scaleRate添加缩放变换矩阵
//    CGAffineTransform scale = CGAffineTransformScale(yRevert,15, 15);
//    // 为scale变换矩阵根据rotateAngle添加旋转变换矩阵
//    CGAffineTransform rotate = CGAffineTransformRotate(scale,
//                                                   M_PI * 15 / 180);
//    CGContextSetTextMatrix(ctx, rotate);  // 对CGContextRef绘制文字时应用变换
////    CGContextShowTextAtPoint(ctx, 50, 500, "hahh", 100);  // 绘制文本
////    CGContextShowGlyphsAtPoint(ctx, 50, 500, @"中文文字", 100);
//
//
//}

- (UIImage *)addImageWithLogoText:(UIImage *)img text:(NSString *)text1
{
    
    if (text1) {
        CGSize size = CGSizeMake(img.size.width, img.size.height + 20);          //设置上下文（画布）大小
        UIGraphicsBeginImageContext(size);                       //创建一个基于位图的上下文(context)，并将其设置为当前上下文
        CGContextRef contextRef = UIGraphicsGetCurrentContext(); //获取当前上下文
        CGContextTranslateCTM(contextRef, 0, img.size.height);   //画布的高度
        CGContextScaleCTM(contextRef, 1.0, -1.0);                //画布翻转
        CGContextDrawImage(contextRef, CGRectMake(0, 0, img.size.width, img.size.height), [img CGImage]);  //在上下文种画当前图片
        
        [[UIColor grayColor] set];                                //上下文种的文字属性
        CGContextTranslateCTM(contextRef, 0, img.size.height);
        CGContextScaleCTM(contextRef, 1.0, -1.0);
        UIFont *font = [UIFont boldSystemFontOfSize:16];
        [@"hahahahahahh" drawInRect:CGRectMake(0, 50, 100, 50) withFont:font];       //此处设置文字显示的位置
        UIImage *targetimg =UIGraphicsGetImageFromCurrentImageContext();  //从当前上下文种获取图片
        UIGraphicsEndImageContext();                            //移除栈顶的基于当前位图的图形上下文。
//        CGContextRelease(contextRef);
        return targetimg;
    }
    
    return img;
    
}


@end
