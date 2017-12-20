//
//  PublishViewButton.m
//  项目模板
//
//  Created by ychen on 16/10/8.
//  Copyright © 2016年 ComProject. All rights reserved.
//

#import "PublishViewButton.h"

@implementation PublishViewButton

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        self.titleLabel.textAlignment=NSTextAlignmentCenter;
    }
    return self;
}


-(void)layoutSubviews{
    [super layoutSubviews];
    // 调整图片
    self.imageView.left = 0;
    self.imageView.top = 0;
    self.imageView.width = self.width;
    self.imageView.height = self.imageView.width;
    
    // 调整文字
    self.titleLabel.left = 0;
    self.titleLabel.top = self.imageView.height;
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.titleLabel.top;
}

@end
