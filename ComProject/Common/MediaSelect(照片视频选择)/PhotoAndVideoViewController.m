//
//  PhotoAndVideoViewController.m
//  照片视频Demo
//
//  Created by 陈园 on 2017/7/11.
//  Copyright © 2017年 陈园. All rights reserved.
//

#import "PhotoAndVideoViewController.h"
#import "PhotoManageViewController.h"
#import "VideoManageViewController.h"

@interface PhotoAndVideoViewController ()

@property (nonatomic, strong) UIImagePickerController *pickerController;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataArr;

@end

static NSString *cellID = @"collectionViewCell";
@implementation PhotoAndVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.dataArr=[NSMutableArray array];
    [self creatView];
}

-(void)creatView{
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake((KScreenW-200)/3, 100, 100, 30)];
    [btn1 setTitle:@"照片" forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    btn1.backgroundColor=[UIColor orangeColor];
    btn1.tag=1100;
    [self.view addSubview:btn1];
    
    UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake((KScreenW-200)/3*2+100, 100, 100, 30)];
    [btn2 setTitle:@"视频" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    btn2.backgroundColor=[UIColor orangeColor];
    btn2.tag=1200;
    [self.view addSubview:btn2];
    
}

-(void)btnAction:(UIButton *)btn{
    if (btn.tag==1100) {//照片
        PhotoManageViewController *photoManageVC=[[PhotoManageViewController alloc] init];
        [self.navigationController pushViewController:photoManageVC animated:YES];
    }else if (btn.tag==1200) {//视频
        VideoManageViewController *videoManageVC=[[VideoManageViewController alloc] init];
        [self.navigationController pushViewController:videoManageVC animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end



