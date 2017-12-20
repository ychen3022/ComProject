//
//  ComTabBar.m
//  项目模板
//
//  Created by ychen on 16/10/8.
//  Copyright © 2016年 ComProject. All rights reserved.
//

#import "ComTabBar.h"
#import "PublishView.h"
#import "PublishView.h"

@interface ComTabBar()

@property(nonatomic,strong)UIButton *publishBtn;

@end



@implementation ComTabBar

-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        //设置TabBar的背景图片
        [self setBackgroundImage:[UIImage imageNamed:@"tabbar-light"]];
        
        //添加发布按钮
        self.publishBtn=[[UIButton alloc] init];
        [self.publishBtn addTarget:self action:@selector(publishBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.publishBtn setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [self.publishBtn setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateSelected];
        self.publishBtn.size=self.publishBtn.currentBackgroundImage.size;
        [self addSubview:self.publishBtn];
    }
    return self;
}


//发布按钮
-(void)publishBtnAction:(UIButton *)sender{
    [PublishView show];
}


-(void)layoutSubviews{
    [super layoutSubviews];
    
    //设置发布按钮的frame
    self.publishBtn.bounds=CGRectMake(0, 0, self.publishBtn.currentBackgroundImage.size.width, self.publishBtn.currentBackgroundImage.size.height);
    self.publishBtn.center=CGPointMake(self.frame.size.width*0.5, self.frame.size.height*0.5);
    
    //设置其他UITabBarButton的frame
    CGFloat buttonY=0;
    CGFloat buttonW=self.frame.size.width/5;
    CGFloat buttonH=self.frame.size.height;
    NSInteger index=0;
    for (UIView *btn in self.subviews) {
        if([btn isKindOfClass:NSClassFromString(@"UITabBarButton")]){
            btn.frame=CGRectMake(index*buttonW, buttonY, buttonW, buttonH);
            if (index==1) {
                index++;
            }
            index++;
        }
    }
}

@end
