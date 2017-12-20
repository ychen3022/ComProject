//
//  UIView+Ext.m
//  项目模板
//
//  Created by ychen on 16/10/8.
//  Copyright © 2016年 ComProject. All rights reserved.
//

#import "UIView+Ext.h"
#import "ComTools.h"

#define kLineHeight     0.5
#define kLineWidth      0.5
#define kTopLineTag     996
#define kUnderLineTag   997
#define kLeftLineTag    998
#define kRightLineTag   999


CGPoint CGRectGetCenter(CGRect rect)
{
    CGPoint pt;
    pt.x = CGRectGetMidX(rect);
    pt.y = CGRectGetMidY(rect);
    return pt;
}

CGRect CGRectMoveToCenter(CGRect rect, CGPoint center)
{
    CGRect newrect = CGRectZero;
    newrect.origin.x = center.x-CGRectGetMidX(rect);
    newrect.origin.y = center.y-CGRectGetMidY(rect);
    newrect.size = rect.size;
    return newrect;
}



@implementation UIView (Ext)

#pragma mark -origin的方法
- (CGPoint) origin{
    return self.frame.origin;
}

- (void) setOrigin: (CGPoint) aPoint{
    CGRect newframe = self.frame;
    newframe.origin = aPoint;
    self.frame = newframe;
}



#pragma mark -size的方法
- (CGSize) size{
    return self.frame.size;
}

- (void) setSize: (CGSize) aSize{
    CGRect newframe = self.frame;
    newframe.size = aSize;
    self.frame = newframe;
}



#pragma mark -width的方法
- (CGFloat) width{
    return self.frame.size.width;
}

- (void) setWidth: (CGFloat) newwidth{
    CGRect newframe = self.frame;
    newframe.size.width = newwidth;
    self.frame = newframe;
}


#pragma mark -height的方法
- (CGFloat) height{
    return self.frame.size.height;
}

- (void) setHeight: (CGFloat) newheight{
    CGRect newframe = self.frame;
    newframe.size.height = newheight;
    self.frame = newframe;
}



#pragma mark -CenterX的方法
-(CGFloat)centerX{
    return self.center.x;
}

-(void)setCenterX:(CGFloat) newCenterX{
    CGRect newframe = self.frame;
    CGFloat delta=newCenterX-self.center.x;
    newframe.origin.x+=delta;
    self.frame=newframe;
}



#pragma mark -CenterY的方法
-(CGFloat)centerY{
    return self.center.y;
}

-(void)setCenterY:(CGFloat) newCenterY{
    CGRect newframe = self.frame;
    CGFloat delta=newCenterY-self.center.y;
    newframe.origin.y+=delta;
    self.frame=newframe;
}



#pragma mark -top的方法
- (CGFloat) top{
    return self.frame.origin.y;
}

- (void) setTop: (CGFloat) newtop{
    CGRect newframe = self.frame;
    newframe.origin.y = newtop;
    self.frame = newframe;
}



#pragma mark -bottom的方法
- (CGFloat) bottom{
    return self.frame.origin.y + self.frame.size.height;
}

- (void) setBottom: (CGFloat) newbottom{
    CGRect newframe = self.frame;
    newframe.origin.y = newbottom - self.frame.size.height;
    self.frame = newframe;
}



#pragma mark -left的方法
- (CGFloat) left{
    return self.frame.origin.x;
}

- (void) setLeft: (CGFloat) newleft{
    CGRect newframe = self.frame;
    newframe.origin.x = newleft;
    self.frame = newframe;
}



#pragma mark -right的方法
- (CGFloat) right{
    return self.frame.origin.x + self.frame.size.width;
}

- (void) setRight: (CGFloat) newright{
    CGFloat delta = newright - (self.frame.origin.x + self.frame.size.width);
    CGRect newframe = self.frame;
    newframe.origin.x += delta ;
    self.frame = newframe;
}


//======================================
#pragma mark -视图中心移动
- (void) moveBy: (CGPoint) delta{
    CGPoint newcenter = self.center;
    newcenter.x += delta.x;
    newcenter.y += delta.y;
    self.center = newcenter;
}

#pragma mark -视图缩放
- (void) scaleBy: (CGFloat) scaleFactor{
    CGRect newframe = self.frame;
    newframe.size.width *= scaleFactor;
    newframe.size.height *= scaleFactor;
    self.frame = newframe;
}

#pragma mark -视图按 新Size长边缩放
- (void) fitInSize: (CGSize) aSize{
    CGFloat scale;
    CGRect newframe = self.frame;
    if (newframe.size.height && (newframe.size.height > aSize.height)){
        scale = aSize.height / newframe.size.height;
        newframe.size.width *= scale;
        newframe.size.height *= scale;
    }
    if (newframe.size.width && (newframe.size.width >= aSize.width)){
        scale = aSize.width / newframe.size.width;
        newframe.size.width *= scale;
        newframe.size.height *= scale;
    }
    self.frame = newframe;
}

#pragma mark -视图垂直方向动画移动到y坐标
-(void)viewMoveToY:(float)y{
    [UIView animateWithDuration:0.3 animations:^{
        self.top=y;
    }];
}

#pragma mark -使视图变正圆
-(void)makeCycleSharp{
    [self.layer setCornerRadius:CGRectGetHeight([self bounds]) / 2];
    self.layer.masksToBounds=YES;
}

#pragma mark -添加上划线
- (void)addTopLine {
    [self addTopLineWithHexColor:kLineColor];
}

- (void)addTopLineWithHexColor:(NSString *)hexColor {
    [self removeTopLine];
    UIView *topLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, kLineHeight)];
    topLine.tag = kTopLineTag;
    topLine.backgroundColor = [ComTools getColorWithHexString:hexColor];
    [self addSubview:topLine];
}

- (void)removeTopLine {
    [[self viewWithTag:kTopLineTag] removeFromSuperview];
}



#pragma mark -添加下划线
- (void)addUnderLine {
    [self addUnderLineWithHexColor:kLineColor];
}

- (void)addUnderLineWithHexColor:(NSString *)hexColor {
    [self removeUnderLine];
    UIView *underLine = [[UIView alloc] initWithFrame:CGRectMake(0, self.height - kLineHeight, self.width, kLineHeight)];
    underLine.tag = kUnderLineTag;
    underLine.backgroundColor = [ComTools getColorWithHexString:hexColor];
    [self addSubview:underLine];
}

- (void)removeUnderLine {
    [[self viewWithTag:kUnderLineTag] removeFromSuperview];
}



#pragma mark -添加左划线
- (void)addLeftLine{
 [self addLeftLineWithHexColor:kLineColor];
}

- (void)addLeftLineWithHexColor:(NSString *)hexColor{
    [self removeLeftLine];
    UIView *leftLine = [[UIView alloc] initWithFrame:CGRectMake(0, self.width-kLineWidth, kLineWidth, self.height)];
    leftLine.tag = kLeftLineTag;
    leftLine.backgroundColor = [ComTools getColorWithHexString:hexColor];
    [self addSubview:leftLine];
}

- (void)removeLeftLine{
    [[self viewWithTag:kLeftLineTag] removeFromSuperview];
}



#pragma mark -添加右划线
- (void)addRightLine{
    [self addRightLineWithHexColor:kLineColor];
}

- (void)addRightLineWithHexColor:(NSString *)hexColor {
    [self removeRightLine];
    UIView *rightLine = [[UIView alloc] initWithFrame:CGRectMake(self.width-kLineWidth, 0, kLineWidth, self.height)];
    rightLine.tag = kRightLineTag;
    rightLine.backgroundColor = [ComTools getColorWithHexString:hexColor];
    [self addSubview:rightLine];
}

- (void)removeRightLine {
    [[self viewWithTag:kRightLineTag] removeFromSuperview];
}

- (void)addLineWithEdgeInset:(UIEdgeInsets)inset {
    CGFloat left = fabs(inset.left);
    CGFloat right = fabs(inset.right);
    CGFloat top = fabs(inset.top);
    if (left+right >= KScreenW) {
        return;
    }
    if (top >= self.height) {
        top = self.height-0.5;
    }
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(left, top, KScreenW-left-right, 0.5)];
    line.backgroundColor = [ComTools getColorWithHexString:@"#c7c7c7"];
    [self addSubview:line];
}
@end
