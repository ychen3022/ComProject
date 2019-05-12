//
//  ComMenuBaseViewController.m
//  RKTopTagsMenu
//
//  Created by ychen on 16/10/26.
//  Copyright © 2016年 Snail. All rights reserved.
//

#import "ComMenuBaseViewController.h"
#import "ComTopMenuView.h"
#import "MenuView1.h"
#import "MenuView2.h"
#import "MenuView3.h"
#import "MenuView4.h"
#import "MenuView5.h"
#import "MenuView6.h"
#import "MenuView7.h"
#import "MenuView8.h"


@interface ComMenuBaseViewController ()<UIScrollViewDelegate>

/** 头部菜单视图*/
@property(nonatomic,strong)ComTopMenuView *topMenuView;
/** 底部对应滑动视图*/
@property(nonatomic,strong)UIScrollView *scrollView;
/** 菜单视图对应的titlesArr*/
@property (nonatomic, strong) NSArray *titlesArr;

@end



@implementation ComMenuBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    self.automaticallyAdjustsScrollViewInsets = NO;//不要自动调整inset
    
    [self setupNav];//设置navigation
    
    [self setupChildViewController];//添加子控制器
    
    [self setupTopMenuView];//添加头部菜单视图
    
    [self setupScrollView];//添加底部滑动视图
}



#pragma mark -设置navigation
-(void)setupNav{
    self.navigationController.navigationBarHidden=NO;
    self.navigationItem.title=@"菜单页";
}

#pragma mark -添加所有子控制器
- (void)setupChildViewController {
    // 精选
    MenuView1 *oneVC = [[MenuView1 alloc] init];
    [self addChildViewController:oneVC];
    
    // 电视剧
    MenuView2 *twoVC = [[MenuView2 alloc] init];
    [self addChildViewController:twoVC];
    
    // 电影
    MenuView3 *threeVC = [[MenuView3 alloc] init];
    [self addChildViewController:threeVC];
    
    // 精选
    MenuView4 *fourVC = [[MenuView4 alloc] init];
    [self addChildViewController:fourVC];
    
    // 电视剧
    MenuView5 *fiveVC = [[MenuView5 alloc] init];
    [self addChildViewController:fiveVC];
    
    // 电影
    MenuView6 *sixVC = [[MenuView6 alloc] init];
    [self addChildViewController:sixVC];
    
    // 精选
    MenuView7 *VC7 = [[MenuView7 alloc] init];
    [self addChildViewController:VC7];
    
    // 电视剧
    MenuView8 *VC8 = [[MenuView8 alloc] init];
    [self addChildViewController:VC8];
}



#pragma mark -添加头部菜单视图
-(ComTopMenuView *)setupTopMenuView{
    if (!_topMenuView) {
        _topMenuView=[[ComTopMenuView alloc] initWithFrame:CGRectMake(0, 64,[UIScreen mainScreen].bounds.size.width ,40)];
        //这个位置可以设置topMenuView的样式
        _topMenuView.titleSelectedColor=[UIColor orangeColor];
        _titlesArr = @[@"精选", @"电视剧", @"电影", @"综艺", @"NBA", @"新闻", @"娱乐", @"音乐"];
        [_topMenuView creatTopMenuViewWithTitlesArray:self.titlesArr];
        [self.view addSubview:_topMenuView];
        
        __weak ComMenuBaseViewController *weakSelf=self;
        self.topMenuView.myBlock=^(int titleIndex) {
            [weakSelf showViewWithBtnTag:titleIndex];
            NSLog(@"番茄 tag=%d",titleIndex);
        };
    }
    return _topMenuView;
}


#pragma mark -点击MenuView上按钮的事件
-(void)showViewWithBtnTag:(int)btnTag{
    //计算滚动的位置
    CGFloat offsetX = btnTag * self.view.frame.size.width;
    self.scrollView.contentOffset = CGPointMake(offsetX, 0);
    
    //给对应位置添加对应子控制器
    [self showVc:btnTag];
}

#pragma mark -给对应位置添加对应子控制器
- (void)showVc:(NSInteger)index {
    CGFloat offsetX = index * self.view.frame.size.width;
    UIViewController *vc = self.childViewControllers[index];
    // 判断控制器的view有没有加载过,如果已经加载过,就不需要加载
    if (vc.isViewLoaded) return;
    vc.view.frame = CGRectMake(offsetX, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.scrollView addSubview:vc.view];
}



#pragma mark -创建scrollView视图,是负责水平滚动的
-(UIScrollView *)setupScrollView{
    if (!_scrollView) {
        _scrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        _scrollView.contentSize=CGSizeMake(self.view.frame.size.width * self.childViewControllers.count, 0);
        _scrollView.backgroundColor=[UIColor clearColor];
        _scrollView.pagingEnabled=YES;
        _scrollView.bounces=NO;
        _scrollView.delegate=self;
        _scrollView.showsHorizontalScrollIndicator=NO;
        _scrollView.showsVerticalScrollIndicator=NO;
        [self.view insertSubview:_scrollView atIndex:0];//将scrollView插入到self.view的最底层
        [self.view addSubview:_scrollView];
        [self showViewWithBtnTag:0];//加载ScrollView的时候，要顺便将第一个界面显示在上面
        [self.view insertSubview:_scrollView belowSubview:_topMenuView];
    }
    return _scrollView;
}



#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //获取当前ScrollView对应第几个界面
    NSUInteger index=scrollView.contentOffset.x /scrollView.bounds.size.width;
    //获取该界面对应的button
    UIButton *selButton=_topMenuView.allButtonArr[index];
    //执行点击该按钮，实现效果
    [self.topMenuView btnAction:selButton];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
