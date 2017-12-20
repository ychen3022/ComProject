//
//  ComGraphicsViewController.m
//  ComProject
//
//  Created by 陈园 on 2017/11/2.
//  Copyright © 2017年 陈园. All rights reserved.
//

#import "ComGraphicsViewController.h"
#import "ComGraphicsView.h"
#import <CoreText/CoreText.h>

@interface ComGraphicsViewController ()

@property (nonatomic, strong) ComGraphicsView *bgView;

@end

@implementation ComGraphicsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatBGView];
}

-(void)creatBGView{
    self.bgView= [[ComGraphicsView alloc] initWithFrame:CGRectMake(20, 70, KScreenW-40, KScreenH-100)];
    UIImage *image= [self.bgView addImageWithLogoText:[UIImage imageNamed:@"head_background"] text:@"水印"];
    self.bgView.backgroundColor= [UIColor orangeColor];
//    [self.view addSubview:image];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    imageView.image = image;
   
    
    [self.view addSubview:self.bgView];
     [self.view addSubview:imageView];
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
