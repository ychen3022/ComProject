//
//  MediaManageView.m
//  照片视频Demo
//
//  Created by 陈园 on 2017/7/11.
//  Copyright © 2017年 陈园. All rights reserved.
//


#define kCell_Width    (KScreenW-5*6)/4
#define kCell_Height   kCell_Width



#import "MediaManageView.h"

@interface MediaManageView ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *subtitle;
@property (nonatomic, assign) CGFloat contentHeight;
@end

static NSString * const cellID = @"MediaCollectionViewCell";

@implementation MediaManageView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.maxCount = 9;
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:flowLayout];
        collectionView.backgroundColor = [UIColor whiteColor];
        collectionView.showsHorizontalScrollIndicator = NO;
        collectionView.showsVerticalScrollIndicator = NO;
        collectionView.scrollEnabled = NO;
        collectionView.dataSource = self;
        collectionView.delegate = self;
        [collectionView registerClass:[MediaCollectionViewCell class] forCellWithReuseIdentifier:cellID];
        [self addSubview:collectionView];
        self.collectionView = collectionView;
        self.collectionView.backgroundColor=[UIColor orangeColor];
    }
    return self;
}


#pragma mark UICollectionDataSource and UICollectionDelegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.mediaManageType == MediaManageType_Show) {
        return self.dataArr.count > self.maxCount ? self.maxCount:self.dataArr.count;
    }else{
        return self.dataArr.count >= self.maxCount ? self.maxCount:self.dataArr.count+1;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MediaCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    if (self.mediaManageType == MediaManageType_Show) {
        MediaModel *mediaShowModel=(MediaModel *)self.dataArr[indexPath.row];
        [cell configMediaCellWithModel:mediaShowModel];
        
    }else{
        if (indexPath.row==self.dataArr.count) {
            MediaModel *mediaAddModel=[[MediaModel alloc] init];
            mediaAddModel.mediaCellState=MediaCellState_Add;
            [cell configMediaCellWithModel:mediaAddModel];
        }else{
            MediaModel *mediaNormalModel=(MediaModel *)self.dataArr[indexPath.row];
            mediaNormalModel.mediaCellState=MediaCellState_Normal;
            [cell configMediaCellWithModel:mediaNormalModel];
        }
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.mediaManageType == MediaManageType_Show) {
        
        
        
    }else if(self.mediaManageType == MediaManageType_Edit){
        if(self.dataArr.count < self.maxCount && indexPath.row==self.dataArr.count){
            MediaCollectionViewCell *selectCell=(MediaCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
            if ([self.delegate respondsToSelector:@selector(mediaManageView:didAddCell:)]) {
                [self.delegate mediaManageView:self didAddCell:selectCell];
            }
        }else{//播放视频
//            [self openmoviewithPath:path];
            
        
        }
    }
}








#pragma mark UICollectionViewFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(collectionView:layout:sizeForItemAtIndexPath:)]) {
        return [self.delegate collectionView:collectionView layout:collectionViewLayout sizeForItemAtIndexPath:indexPath];
    }
    return CGSizeMake(kCell_Width, kCell_Height);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if ([self.delegate respondsToSelector:@selector(collectionView:layout:insetForSectionAtIndex:)]) {
        return [self.delegate collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section];
    }
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

//横向(左右)间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    if ([self.delegate respondsToSelector:@selector(collectionView:layout:minimumInteritemSpacingForSectionAtIndex:)]) {
        return [self.delegate collectionView:collectionView layout:collectionViewLayout minimumInteritemSpacingForSectionAtIndex:section];
    }
    return 0;
}

//竖向(上下)间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    if ([self.delegate respondsToSelector:@selector(collectionView:layout:minimumLineSpacingForSectionAtIndex:)]) {
        return [self.delegate collectionView:collectionView layout:collectionViewLayout minimumLineSpacingForSectionAtIndex:section];
    }
    return 0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if ([self.delegate respondsToSelector:@selector(collectionView:layout:referenceSizeForHeaderInSection:)]) {
        return [self.delegate collectionView:collectionView layout:collectionViewLayout referenceSizeForHeaderInSection:section];
    }
    return CGSizeZero;
}





//
//
//#pragma mark  UIImagePickerDelegate
//-(UIImage*) thumbnailImageForVideo:(NSURL *)videoURL atTime:(NSTimeInterval)time {
//    
//    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:videoURL options:nil];
//    NSParameterAssert(asset);
//    AVAssetImageGenerator *assetImageGenerator =[[AVAssetImageGenerator alloc] initWithAsset:asset];
//    assetImageGenerator.appliesPreferredTrackTransform = YES;
//    assetImageGenerator.apertureMode = AVAssetImageGeneratorApertureModeEncodedPixels;
//    
//    CGImageRef thumbnailImageRef = NULL;
//    CFTimeInterval thumbnailImageTime = time;
//    NSError *thumbnailImageGenerationError = nil;
//    thumbnailImageRef = [assetImageGenerator copyCGImageAtTime:CMTimeMake(thumbnailImageTime, 60)actualTime:NULL error:&thumbnailImageGenerationError];
//    
//    if(!thumbnailImageRef)
//    NSLog(@"thumbnailImageGenerationError %@",thumbnailImageGenerationError);
//    
//    UIImage*thumbnailImage = thumbnailImageRef ? [[UIImage alloc]initWithCGImage: thumbnailImageRef] : nil;
//    
//    return thumbnailImage;
//}
//
//- (void)addHeaderWithTitle:(NSString *)title subtitle:(NSString *)subtitle {
//    self.title = title;
//    self.subtitle = subtitle;
//    [self reloadData];
//}

- (void)reloadData {
    [self.collectionView reloadData];
}
//- (void)reloadSpecialDataWithModel:(UpLoadModel *)model {
//    if ([self.dataSource containsObject:model]) {
//        NSInteger index =  [self.dataSource indexOfObject:model];
//        [self.collectionView reloadItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:index inSection:0]]];
//    }
//}
//
//#pragma mark - 7 getters and setters
//- (void)setContentHeight:(CGFloat)contentHeight {
//    if (fabs(_contentHeight-contentHeight) > 1) {
//        _contentHeight = contentHeight;
//        self.height = _contentHeight;
//        if ([self.delegate respondsToSelector:@selector(btMultiUpLoadView:heightChange:)]) {
//            [self.delegate btMultiUpLoadView:self heightChange:self.height];
//        }
//    }
//}
//- (NSMutableArray<UpLoadModel *> *)dataSource {
//    if (!_dataSource) {
//        _dataSource = [NSMutableArray array];
//    }
//    return _dataSource;
//}
//- (void)setIsUpLoading:(BOOL)isUpLoading {
//    _isUpLoading = isUpLoading;
//    self.type = _isUpLoading ? MultiUploadViewType_Show : MultiUploadViewType_Add;
//    [self reloadData];
//}

//播放电影
//-(void)openmoviewithPath:(NSString *)path{
//    NSURL *url = [NSURL URLWithString:path];
//    if ([CommonTools isBlankString:url.scheme]) {
//        url = [NSURL fileURLWithPath:path];
//    }
//    MPMoviePlayerViewController *movieVC = [[MPMoviePlayerViewController alloc]initWithContentURL:url];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(movieFinishedCallback:) name:MPMoviePlayerPlaybackDidFinishNotification object:movieVC.moviePlayer];
//    movieVC.moviePlayer.fullscreen = YES;
//    [[[UIApplication sharedApplication] delegate].window addSubview:movieVC.view];
//    MPMoviePlayerController *player = movieVC.moviePlayer;
//    [player play];
//}
//
//
//- (void) movieFinishedCallback:(NSNotification*) notification {
//    MPMoviePlayerController *player = [notification object];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:player];
//    [player stop];
//    [player.view removeFromSuperview];
//}

@end

