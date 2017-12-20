//
//  ComTopMenuView.m
//  RKTopTagsMenu
//
//  Created by ychen on 16/10/25.
//  Copyright © 2016年 Snail. All rights reserved.
//

#import "ComTopMenuView.h"

@interface ComTopMenuView () <UIScrollViewDelegate>

/** 加载topMenuView的scrollView*/
@property(nonatomic,strong)UIScrollView *menuScrollView;
/** topMenuView底部的滑动线条*/
@property(nonatomic,strong)UIView *lineView;
/** 判断标签是否超出父视图的长度*/
@property(nonatomic,assign)BOOL isOverFlag;
/** 用于存储处理过的数组，其中主要包括btn的btnTitle、btnTag、btnOrginX、btnWidth*/
@property(nonatomic,strong)NSArray *processedArray;

@end



@implementation ComTopMenuView

#pragma mark -懒加载 保存菜单视图上的所有button
-(NSMutableArray *)allButtonArr{
    if (_allButtonArr ==nil) {
        _allButtonArr=[NSMutableArray array];
    }
    return _allButtonArr;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        _firstBtnOriginX=10.0;//第一个按钮的起点X坐标
        _btnSpace=10.0;//两个按钮之间的横向间距
        _titleSpace=10.0;//按钮中标题文字与按钮边框的左右间距之和   (标题距离边框两边的距离和)
        _titleNormalSize=17.0;//按钮平常字体的大小
        _titleSelectedSize=20.0;//按钮选中字体的大小
        _titleNormalColor=[UIColor blackColor];//按钮平常字体颜色
        _titleSelectedColor=[UIColor redColor];//按钮选中字体颜色
     
        //设置加载topMenuView的scrollView
        _menuScrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _menuScrollView.showsVerticalScrollIndicator=NO;
        _menuScrollView.showsHorizontalScrollIndicator=NO;
        _menuScrollView.bounces=NO;
        _menuScrollView.backgroundColor=[UIColor colorWithWhite:0.9 alpha:1.0];
        _menuScrollView.delegate=self;
        [self addSubview:_menuScrollView];
    }
    return self;
}



#pragma mark -设置TopMenuView的btn的显示文字和tag值
-(void)creatTopMenuViewWithTitlesArray:(NSArray *)titlesArray andTagsArr:(NSArray *)tagsArr{
    //先计算一下每个btn标签的宽度，预计能不能显示直接显示在屏幕上
    [self calculateWithTitlesArray:titlesArray andTagsArr:(NSArray *)tagsArr] ;
    if (!_isOverFlag) {  //加载不可滑动的顶部标签视图
        [self loadNormalTopBtnsMenuView];
    }else {//加载可滑动的顶部标签菜单
        [self loadBtnsMenuViewWithScrollView];
    }
}



#pragma mark -预先计算btn们的总宽度会不会超过屏幕宽度
-(void)calculateWithTitlesArray:(NSArray *)titlesArray andTagsArr:(NSArray *)tagsArr{
    NSMutableArray *tempArr = [NSMutableArray array];//暂存处理后的btn信息字典
    CGFloat originX = _firstBtnOriginX;//暂存每个btn的X值
    
    for (int index=0; index<titlesArray.count;index++) {
        //计算每个btn的宽度
        CGSize titleSize=[self sizeWithText:titlesArray[index] font:[UIFont systemFontOfSize:_titleSelectedSize] maxSize:CGSizeMake(MAXFLOAT, self.frame.size.height)];
        NSMutableDictionary *tempDict=[NSMutableDictionary dictionary];
        tempDict[@"btnTitle"]=titlesArray[index];
        tempDict[@"btnTag"]=tagsArr[index];
        tempDict[@"btnOrginX"]=[NSString stringWithFormat:@"%f",originX];;
        tempDict[@"btnWidth"]=[NSString stringWithFormat:@"%f",titleSize.width+_titleSpace];
        [tempArr addObject:tempDict];
        originX+= titleSize.width+_titleSpace+_btnSpace;//按钮的X坐标每次都是前一个按钮的宽度+按钮左右空隙+按钮距下个标签的距离
    }
    _processedArray=tempArr;
    _isOverFlag = (originX > self.frame.size.width);//记录标签是否超出父视图的长度
}



#pragma mark -加载不可滑动的顶部标签视图
- (void)loadNormalTopBtnsMenuView {
   //平分宽度
    CGFloat avgBtnW=self.frame.size.width / _processedArray.count;
    for (NSDictionary *btnDict in _processedArray) {
        NSUInteger index=[_processedArray indexOfObject:btnDict];
        NSString *btnTitle=btnDict[@"btnTitle"];
        NSInteger btnTag=[btnDict[@"btnTag"] integerValue];
        
        UIButton *btn=[[UIButton alloc] initWithFrame:CGRectMake(index * avgBtnW, 0, avgBtnW, self.frame.size.height-2)];
        [btn setTitle:btnTitle forState:UIControlStateNormal];
        btn.tag=btnTag;
        [btn.titleLabel setFont:[UIFont systemFontOfSize:_titleNormalSize]];
        [btn setTitleColor:_titleSelectedColor forState:UIControlStateSelected];
        [btn setTitleColor:_titleNormalColor forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [_menuScrollView addSubview:btn];
        [self.allButtonArr addObject:btn];
        
        if (0 == index) {//第一个按钮呈现被选中样式
            btn.selected=YES;
            [btn.titleLabel setFont:[UIFont systemFontOfSize:_titleSelectedSize]];
            _lineView = [[UIView alloc] initWithFrame:CGRectMake(index * avgBtnW, self.frame.size.height-2, btn.frame.size.width, 2)];
            _lineView.backgroundColor = _titleSelectedColor;
            [_menuScrollView addSubview:_lineView];
        }
    }
}



#pragma mark -加载可滑动的顶部标签菜单
- (void)loadBtnsMenuViewWithScrollView {
    //遍历标签数组,将标签显示在界面上,并给每个按钮打上tag加以区分
    for (NSDictionary *btnDic in _processedArray) {
        NSUInteger index = [_processedArray indexOfObject:btnDic];
        NSString *btnTitle = btnDic[@"btnTitle"];
        NSInteger btnTag=[btnDic[@"btnTag"] integerValue];
        CGFloat btnOrginX = [btnDic[@"btnOrginX"] floatValue];
        CGFloat btnWidth = [btnDic[@"btnWidth"] floatValue];

        UIButton *btn = [[UIButton alloc] initWithFrame: CGRectMake(btnOrginX, 0, btnWidth, self.frame.size.height-2)];
        [btn setTitle:btnTitle forState:UIControlStateNormal];
        btn.tag = btnTag;
        [btn.titleLabel setFont:[UIFont systemFontOfSize:_titleNormalSize]];
        [btn setTitleColor:_titleSelectedColor forState:UIControlStateSelected];
        [btn setTitleColor:_titleNormalColor forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [_menuScrollView addSubview:btn];
        [self.allButtonArr addObject:btn];
        
        if (index==0) {//第一个按钮呈现被选中样式
            btn.selected=YES;
            [btn.titleLabel setFont:[UIFont systemFontOfSize:_titleSelectedSize]];
            _lineView = [[UIView alloc] initWithFrame:CGRectMake(btnOrginX, self.frame.size.height-2, btn.frame.size.width, 2)];
            _lineView.backgroundColor = _titleSelectedColor;
            [_menuScrollView addSubview:_lineView];
        }
    }
    if (_processedArray.count > 0) { //根据最后一个标签的位置设置scrollview的contentSize
        NSDictionary *btnDic = [_processedArray lastObject];
        float lastBtnOrginX = [btnDic[@"btnOrginX"] floatValue];
        float lastBtnWidth = [btnDic[@"btnWidth"] floatValue];
        _menuScrollView.contentSize = CGSizeMake(_firstBtnOriginX+lastBtnOrginX+lastBtnWidth,self.frame.size.height);
    }
}



#pragma mark -MenuView上btn的点击事件
-(void)btnAction:(UIButton *)sender{
    if (_isOverFlag) {
        [self adjustScrollViewContentX:sender]; //将点击的标签显示到视图中间（边上的除外）
    }
    [self resetButtonSelectStatus];//重置所有标签按钮的选中状态
    sender.selected = YES;//将当前选中的按钮设置为选中状态
    [sender.titleLabel setFont:[UIFont systemFontOfSize:_titleSelectedSize]];
    [self moveSelectStatusLineAtBtn:sender];
    if (self.myBlock) {
        self.myBlock(sender.tag);
    }
}



#pragma mark - 将点击的标签显示到视图中间
- (void)adjustScrollViewContentX:(UIButton *)sender {
    // 计算偏移量
    CGFloat offsetX = sender.center.x - [UIScreen mainScreen].bounds.size.width * 0.5;
    if (offsetX < 0){
        offsetX = 0;
    }
    // 获取最大滚动范围
    CGFloat maxOffsetX = _menuScrollView.contentSize.width - [UIScreen mainScreen].bounds.size.width;
    if (offsetX > maxOffsetX){
        offsetX = maxOffsetX;
    }
    // 滚动标题滚动条
    [_menuScrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
}



#pragma mark -重置所有按钮
- (void)resetButtonSelectStatus {
    for(UIView*view in _menuScrollView.subviews){
        if([view isKindOfClass:[UIButton class]]){
            UIButton*tempBtn = (UIButton*)view;
            [tempBtn setSelected:NO];
            [tempBtn.titleLabel setFont:[UIFont systemFontOfSize:_titleNormalSize]];
            [tempBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
    }
}



#pragma mark -设置标签按钮的选中状态
- (void)moveSelectStatusLineAtBtn:(UIButton *)sender {
    //滑动选中按钮
    [UIView animateWithDuration:0.1 animations:^{
        [_lineView setFrame:CGRectMake(sender.frame.origin.x, self.frame.size.height-2, sender.frame.size.width, 2)];
    } completion:^(BOOL finished) {
    
    }];
}



#pragma mark -计算文字尺寸
- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize {
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}
@end



