//
//  CirCleViewController.m
//  项目模板
//
//  Created by ychen on 17/1/22.
//  Copyright © 2017年 ComProject. All rights reserved.
//

#import "CirCleViewController.h"
#import "TopCircleView.h"
#import "CirCleHeader.h"
#import "ImgViewController.h"

@interface CirCleViewController ()

/** 网络图片 */
@property (nonatomic, strong)NSArray *urlArr;
/** 本地图片 */
@property (nonatomic, strong)NSArray *localArr;

@property(nonatomic,strong)TopCircleView *topCircleView;
@property(nonatomic,strong)UIButton *stopBtn;
@property(nonatomic,strong)UIButton *startBtn;
@property(nonatomic,strong)UIButton *stopWave;
@property(nonatomic,strong)UIButton *startWave;

@end

@implementation CirCleViewController

-(TopCircleView *)topCircleView{
    if (!_topCircleView) {
        _topCircleView=[[TopCircleView alloc] initWithFrame:CGRectMake(0, 0, KScreenW, 300)];
        [self.view addSubview:_topCircleView];
    }
    return _topCircleView;
}


-(UIButton *)startBtn{
    if (!_startBtn) {
        _startBtn=[[UIButton alloc] initWithFrame:CGRectMake(50, 400, 100, 40)];
        _startBtn.backgroundColor=[UIColor orangeColor];
        [_startBtn setTitle:@"开始" forState:UIControlStateNormal];
        [_startBtn addTarget:self action:@selector(startBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_startBtn];
    }
    return _startBtn;
}


-(UIButton *)stopBtn{
    if (!_stopBtn) {
        _stopBtn=[[UIButton alloc] initWithFrame:CGRectMake(KScreenW-150, 400, 100, 40)];
        _stopBtn.backgroundColor=[UIColor orangeColor];
        _stopBtn.backgroundColor=[UIColor orangeColor];
        [_stopBtn setTitle:@"停止" forState:UIControlStateNormal];
        [_stopBtn addTarget:self action:@selector(stopBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_stopBtn];
    }
    return _stopBtn;
}

-(UIButton *)startWave{
    if (!_startWave) {
        _startWave=[[UIButton alloc] initWithFrame:CGRectMake(50, 500, 100, 40)];
        _startWave.backgroundColor=[UIColor orangeColor];
        [_startWave setTitle:@"开始波浪" forState:UIControlStateNormal];
        [_startWave addTarget:self action:@selector(startWaveAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_startWave];
    }
    return _stopBtn;
}


-(UIButton *)stopWave{
    if (!_stopWave) {
        _stopWave=[[UIButton alloc] initWithFrame:CGRectMake(KScreenW-150, 500, 100, 40)];
        _stopWave.backgroundColor=[UIColor orangeColor];
        [_stopWave setTitle:@"停止波浪" forState:UIControlStateNormal];
        [_stopWave addTarget:self action:@selector(stopWaveAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_stopWave];
    }
    return _stopWave;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"轮播图";
    [self topCircleView];
    [self startBtn];
    [self stopBtn];
    [self startWave];
    [self stopWave];
    [self setUpImages];
}

- (void)setUpImages{
    
    __weak typeof(self) weakSelf = self;
    //加载网络图片
#if 1
    self.urlArr = @[kInterfaceOne, kInterfaceTwo, kInterfaceThree, kInterfaceFour, kInterfaceFive];
    [self.topCircleView setUpOnlineImageWithSource:self.urlArr PlaceHolderImage:[UIImage imageNamed:@"001"] ClickBlock:^(NSInteger index, NSString *imgStr, UIImage *img) {
         [weakSelf pushToImgViewControllerWithIndex:index Image:img ImageSource:imgStr];
    }];
#endif
    
    //加载本地图片
#if 0
    self.localArr = @[@"1.jpg", @"2.jpg",@"3.jpg"];
    [self.khAdView setUpLocalImagesWithSource:self.localArr
                                 ClickHandler:^(NSInteger index, NSString *imgSrc, UIImage *img) {
                                     [weakSelf pushToImgViewControllerWithIndex:index Image:img ImageSource:imgSrc];
                                 }];
#endif
    
    
    //自定义轮播器
#if 0
    self.TopCircleView.bottomViewColor = [UIColor redColor];
    self.TopCircleView.currentPageIndicatorTintColor = [UIColor blackColor];
    self.TopCircleView.pageIndicatorTintColor = [UIColor yellowColor];
    self.TopCircleView.direction = KHScrollDirectionFromLeft;
    self.TopCircleView.bottomViewHeight = 50;
    self.TopCircleView.timeInterval = 1.f;
    self.TopCircleView.alpha = 0.5;
    
#endif
    
    
    //启动波浪效果
#if 1
    self.topCircleView.hideBottomBGView = YES;
    self.topCircleView.hidePageControl = YES;
    [self.topCircleView setUpWavingWithDuration:0.f
                                  WaveSpeed:12.f
                                 WaveHeight:12.f
                                  WaveColor:[UIColor whiteColor]];
#endif
    
}



- (void)pushToImgViewControllerWithIndex:(NSInteger)index
                                   Image:(UIImage *)img
                             ImageSource:(NSString *)imgSrc{
    
    ImgViewController *imgCtrler = [[ImgViewController alloc] init];
    imgCtrler.index = index;
    imgCtrler.srcStr = imgSrc;
    imgCtrler.image = img;
    [self.navigationController pushViewController:imgCtrler animated:YES];
}


-(void)startBtnAction:(UIButton *)btn{
    [self.topCircleView startTimer];
}

-(void)stopBtnAction:(UIButton *)btn{
    [self.topCircleView stopTimer];
}

-(void)startWaveAction:(UIButton *)btn{
    [self.topCircleView startWaving];
}

-(void)stopWaveAction:(UIButton *)btn{
    [self.topCircleView stopWaving];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
