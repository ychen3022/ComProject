//
//  TopCircleView.m
//  CirCleView
//
//  Created by ychen on 17/1/21.
//  Copyright © 2017年 ychen. All rights reserved.
//

#import "TopCircleView.h"

@interface TopCircleView ()<UICollectionViewDelegate,UICollectionViewDataSource>

/** 控制图片轮播的计时器 */
@property (nonatomic,strong)NSTimer *timer;
/** collectionView*/
@property (nonatomic,strong)UICollectionView *collectionView;
/** 底部分页栏背景*/
@property (nonatomic,strong)UIView *bottomBGView;
/** 分页栏 */
@property (nonatomic,strong)UIPageControl *pageControl;

/** 子线程 */
@property(nonatomic, strong)NSOperationQueue *queue;
/** 子线程缓存 */
@property(nonatomic,strong)NSMutableDictionary *imageOperationDict;
/** 图片缓存 */
@property(nonatomic,strong)NSMutableDictionary *imageCacheDic;

/** 图片的来源(可以是URL或者本地文件名) */
@property (nonatomic, strong)  NSArray<NSString *> *dataSource;
/** 要展示的图片 */
@property(nonatomic, strong) NSMutableArray<UIImage *> *imagesArr;
/** 占位图片 */
@property(nonatomic, strong) UIImage *placeHolderImage;


/** 波浪view */
@property(nonatomic, strong) UIView *waveView;
/** 计时器 */
@property (nonatomic, strong)CADisplayLink *displayLink;
/** 波浪Layer */
@property (nonatomic, strong)CAShapeLayer *shapeLayer;
/** 波浪高度 */
@property (nonatomic, assign)CGFloat waveHeight;
/** 波浪偏移量 */
@property (nonatomic, assign)CGFloat waveOffset;
/** 波动出现时间(waveTime = 0时波浪不消失) */
@property (nonatomic, assign)NSTimeInterval waveTime;
/** 波浪移动速度 */
@property (nonatomic, assign)CGFloat waveSpeed;
/** 波浪颜色 */
@property (nonatomic, weak)UIColor *waveColor;


@end



@implementation TopCircleView

#pragma mark - Lazy load
-(NSMutableDictionary *)imageOperationDict{
    if (!_imageOperationDict) {
        _imageOperationDict=[NSMutableDictionary dictionary];
    }
    return _imageOperationDict;
}

-(NSMutableDictionary *)imageCacheDic{
    if (!_imageCacheDic) {
        _imageCacheDic=[NSMutableDictionary dictionary];
    }
    return _imageCacheDic;
}

- (NSOperationQueue *)queue{
    if (!_queue) {
        _queue = [[NSOperationQueue alloc] init];
        _queue.maxConcurrentOperationCount = 5;
    }
    return _queue;
}

-(UIView *)bottomBGView{
    if (!_bottomBGView) {
        _bottomBGView=[[UIView alloc] init];
        _bottomBGView.backgroundColor=self.bottomBGViewColor;
        _bottomBGView.alpha=self.alpha;
        [self addSubview:_bottomBGView];
        [self bringSubviewToFront:self.pageControl];
    }
    return _bottomBGView;
}

-(UIPageControl *)pageControl{
    if (!_pageControl) {
        _pageControl=[[UIPageControl alloc] init];
        _pageControl.currentPage=0;
        [self addSubview:_pageControl];
    }
    _pageControl.numberOfPages=self.dataSource.count;
    return _pageControl;
}


#pragma mark -Other methods
- (void)setHideBottomBGView:(BOOL)hideBottomBGView{
    _hideBottomBGView=hideBottomBGView;
    self.bottomBGView.hidden=_hideBottomBGView;
}

- (void)setHidePageControl:(BOOL)hidePageControl{
    _hidePageControl = hidePageControl;
    self.pageControl.hidden = _hidePageControl;
}

-(void)setAlpha:(CGFloat)alpha{
    _alpha=alpha;
    self.bottomBGView.alpha=_alpha;
}


#pragma mark -Init methods
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initialize];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self initialize];
    }
    return self;
}

- (void)initialize{
    //初始化一些topCircleView的基本属性
    _timeInterval = 5.f;
    _bottomBGViewColor = [UIColor blackColor];
    _pageIndicatorTintColor = [UIColor whiteColor];
    _currentPageIndicatorTintColor = [UIColor redColor];
    _bottomBGViewHeight = 30;
    _direction = KScrollFromRightToLeft;
    _alpha = 0.3;
}


-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat width=CGRectGetWidth(self.frame);
    CGFloat height=self.bottomBGViewHeight;
    CGFloat y=CGRectGetHeight(self.frame)-height;
    
    self.bottomBGView.frame=CGRectMake(0, y, width, height);
    self.pageControl.frame=CGRectMake(0, y, width, height);
    
    self.pageControl.pageIndicatorTintColor=self.pageIndicatorTintColor;
    self.pageControl.currentPageIndicatorTintColor=self.currentPageIndicatorTintColor;
}



#pragma mark -collectionView
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
        layout.itemSize=CGSizeMake(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
        layout.minimumLineSpacing=0;
        layout.minimumInteritemSpacing=0;
        layout.scrollDirection=UICollectionViewScrollDirectionHorizontal;
        
        _collectionView=[[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        _collectionView.delegate=self;
        _collectionView.dataSource=self;
        _collectionView.pagingEnabled=YES;
        _collectionView.showsVerticalScrollIndicator=NO;
        _collectionView.showsHorizontalScrollIndicator=NO;
        _collectionView.bounces=NO;
        [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
        [self addSubview:_collectionView];
    }
    return _collectionView;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.imagesArr.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    
    for (UIView *subView in cell.contentView.subviews) {
        [subView removeFromSuperview];
    }
    
    UIImageView *imageView=[[UIImageView alloc] initWithFrame:cell.contentView.bounds];
    imageView.image=self.imagesArr[indexPath.row];
    [cell.contentView addSubview:imageView];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.clickImageBlock) {
        NSInteger index = 0;
        if (indexPath.item == 0) {
            index = 1;
            self.clickImageBlock(index,[self.dataSource lastObject],self.imagesArr[indexPath.item]);
        }else if (indexPath.item == self.imagesArr.count - 1){
            index = self.dataSource.count;
            self.clickImageBlock(index, [self.dataSource firstObject], self.imagesArr[indexPath.item]);
        }else{
            index = indexPath.item;
            self.clickImageBlock(index, self.dataSource[indexPath.item - 1], self.imagesArr[indexPath.item]);
        }
    }
}


#pragma mark -设置本地照片
-(void)setUpLocalImageWithSource:(NSArray<NSString *> *)dataSource clickBlock:(ClickImageBlock)block{
    [self setDataSource:dataSource withSourceType:KSourceLocalType placeHolder:nil];
    self.clickImageBlock=block;
}

#pragma mark -设置网络照片
-(void)setUpOnlineImageWithSource:(NSArray<NSString *> *)dataSourece PlaceHolderImage:(UIImage *)placeHolderImage ClickBlock:(ClickImageBlock)block{
    [self setDataSource:dataSourece withSourceType:KSourceOnlineType placeHolder:placeHolderImage];
    self.clickImageBlock=block;
}

-(void)setDataSource:(NSArray *)dataSource withSourceType:(KSourceType)sourceType placeHolder:(UIImage *)image{
    _dataSource = dataSource;
    self.placeHolderImage = image;
    self.imagesArr = [NSMutableArray array];
    NSInteger count = dataSource.count + 2;
    switch (sourceType) {
        case KSourceOnlineType:
        {
            if (self.imageCacheDic.count != dataSource.count) {
                [self downloadImages:dataSource];
            }
            self.imagesArr = [self getDisplayImages:self.imageCacheDic DataSource:dataSource];
            break;
        }
            
        default:
            for (NSInteger i = 0; i < count; i++) {
                if (i == 0) {
                    image = [UIImage imageNamed:[dataSource lastObject]];
                }else if(i == count - 1){
                    image = [UIImage imageNamed:[dataSource firstObject]];
                }else{
                    image = [UIImage imageNamed:dataSource[i - 1]];
                }
                [self.imagesArr addObject:image];
            }
            break;
    }
    [self.collectionView reloadData];
}



-(void)downloadImages:(NSArray *)urlArr{
    for (int i=0; i<urlArr.count; i++) {
        NSString *imageUrlStr=urlArr[i];
        UIImage *image=[self.imageCacheDic objectForKey:imageUrlStr];//尝试从内存中取照片
        if (!image) {//如果没有内存缓存
            NSString *cachePath=[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
            NSString *filePath=[cachePath stringByAppendingString:[imageUrlStr lastPathComponent]];
            BOOL exit=[[NSFileManager defaultManager] fileExistsAtPath:filePath];
            if (!exit) {//如果沙盒里面没有数据
                [self.imageCacheDic setObject:self.placeHolderImage forKey:imageUrlStr];
                NSOperation *downloadOP=[self.imageOperationDict objectForKey:imageUrlStr];
                if (!downloadOP) {//没有子线程缓存
                    NSBlockOperation *download=[NSBlockOperation blockOperationWithBlock:^{
                        NSData *downImageData=[NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrlStr]];
                        UIImage *downImage=[UIImage imageWithData:downImageData];
                        NSLog(@"下载照片 %d",i);
                        if (!downImage) {//容错处理
                            [self.imageOperationDict removeObjectForKey:downImage];
                            return;
                        }
                        [self.imageCacheDic setObject:downImage forKey:imageUrlStr];
                        [downImageData writeToFile:filePath atomically:YES];
                        [self.imageOperationDict removeObjectForKey:imageUrlStr];
                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                           //如果线程缓存数==0 ，所有照片下载已经完毕，刷新视图
                            NSInteger operationCount=self.imageOperationDict.count;
                            if (operationCount==0) {
                                self.imagesArr=[self getDisplayImages:self.imageCacheDic DataSource:urlArr];
                                [self.collectionView reloadData];
                            }
                        }];
                    }];
                    [self.imageOperationDict setObject:download forKey:imageUrlStr];
                    [self.queue addOperation:download];
                }
            }else{
                //从沙盒中获取图片
                image=[UIImage imageWithData:[NSData dataWithContentsOfFile:filePath]];
                [self.imageCacheDic setObject:image forKey:imageUrlStr];
            }
        }else{
            //从内存中获取照片
            [self.imageCacheDic setObject:image forKey:imageUrlStr];
        }
    }
}


- (NSMutableArray *)getDisplayImages:(NSDictionary *)imageCacheDic DataSource:(NSArray *)dataSource{
    NSMutableArray *imageArr=[NSMutableArray array];
    NSInteger count=dataSource.count+2;
    UIImage *image=nil;
    for (int i=0; i<count; i++) {
        NSString *imageUrl;
        if (i==0) {
            imageUrl=[dataSource lastObject];
        }else if (i==count-1){
            imageUrl=[dataSource firstObject];
        }else{
            imageUrl=dataSource[i-1];
        }
        image=[self.imageCacheDic objectForKey:imageUrl];
        [imageArr addObject:image];
    }
    return imageArr;
}


#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSInteger currentPage = (scrollView.contentOffset.x / CGRectGetWidth(self.frame)) - 1;
    self.pageControl.currentPage = currentPage;
    if (currentPage < 0){
        self.pageControl.currentPage = self.dataSource.count - 1;
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.dataSource.count inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
        return;
    }else if (currentPage == self.dataSource.count){
        self.pageControl.currentPage = 0;
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:1 inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
        return;
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self stopTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self startTimer];
}



#pragma mark -计时器timer
- (NSTimer *)timer{
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
    return _timer;
}


- (void)timerAction{
    NSInteger curPage = self.collectionView.contentOffset.x / CGRectGetWidth(self.collectionView.frame);
    NSInteger nextPage = 0;
    
    if (self.direction == KScrollFromRightToLeft) {
        nextPage = curPage + 1;
        if (nextPage == self.imagesArr.count) {
            nextPage = 2;
        }
    }else{
        nextPage = curPage - 1;
        if (nextPage < 0) {
            nextPage = self.imagesArr.count - 2;
        }
    }
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:nextPage inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
}

-(void)startTimer{
    [self timer];
}

-(void)stopTimer{
    [self.timer invalidate];
    self.timer=nil;
}

-(void)invalidateTimer{
    [self stopTimer];
}



#pragma mark -waveView
-(UIView *)waveView{
    if (!_waveView) {
        _waveView=[[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.frame)-_waveHeight/2, CGRectGetWidth(self.frame), _waveHeight)];
        [self addSubview:_waveView];
    }
    return _waveView;
}

- (CAShapeLayer *)shapeLayer{
    if (!_shapeLayer) {
        _shapeLayer = [CAShapeLayer layer];
        _shapeLayer.fillColor = _waveColor.CGColor;
        [self.waveView.layer addSublayer:_shapeLayer];
    }
    return _shapeLayer;
}

- (CADisplayLink *)displayLink{
    if (!_displayLink) {
        _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(handleWave)];
        [_displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    }
    return _displayLink;
}



-(void)setUpWavingWithDuration:(NSTimeInterval)duration
                       WaveSpeed:(CGFloat)speed
                      WaveHeight:(CGFloat)height
                       WaveColor:(UIColor *)color{
    _waveTime = duration;
    _waveColor = color;
    _waveSpeed = speed;
    _waveHeight = height;
    _waveOffset = 0.f;
    
    [self shapeLayer];
}

#pragma mark -handleWave
- (void)handleWave{
    self.waveOffset += self.waveSpeed;
    
    CGFloat width = CGRectGetWidth(self.waveView.frame);
    CGFloat height = CGRectGetHeight(self.waveView.frame);
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, height / 2);
    
    CGFloat y = 0.f;
    for (CGFloat x = 0; x <= width; x++) {
        y = height * sin(0.01 * (x + self.waveOffset));
        CGPathAddLineToPoint(path, NULL, x, y);
    }
    
    CGPathAddLineToPoint(path, NULL, width, height);
    CGPathAddLineToPoint(path, NULL, 0, height);
    CGPathCloseSubpath(path);
    self.shapeLayer.path = path;
    
    CGPathRelease(path);
}

- (void)startWaving{
    [self displayLink];
    if (self.waveTime) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.waveTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self stopWaving];
        });
    }
}


- (void)stopWaving{
    [UIView animateWithDuration:1.5f animations:^{
        self.waveView.alpha = 0.f;
    }completion:^(BOOL finished) {
        [self.displayLink invalidate];
        self.displayLink = nil;
        self.shapeLayer.path = nil;
        self.waveView.alpha = 1.f;
    }];
}


@end
