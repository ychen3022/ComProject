//
//  MediaManageView.h
//  照片视频Demo
//
//  Created by 陈园 on 2017/7/11.
//  Copyright © 2017年 陈园. All rights reserved.
//


/**
 MediaManageView展示样式
 */
typedef NS_ENUM(NSInteger, MediaManageType) {
    MediaManageType_Edit=0,//编辑样式
    MediaManageType_Show=1,//展示样式
};


#import <UIKit/UIKit.h>
#import "MediaModel.h"
#import "MediaCollectionViewCell.h"
@class MediaManageView;


@protocol MediaManageViewDelegate <NSObject>

@optional
//代理:设置cellItem的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;
//代理:设置cellItem的上下左右边距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section;
//代理:设置不同的行之间的行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section;
//代理:设置每个item之间的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section;
//代理:设置头部headerView的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section;

//点击+号cell的事件
- (void)mediaManageView:(MediaManageView *)mediaManageView didAddCell:(MediaCollectionViewCell *)cell;

@end

@interface MediaManageView : UIView
@property (nonatomic, weak) id<MediaManageViewDelegate> delegate;
@property (nonatomic, assign)MediaManageType mediaManageType;//页面管理类型

@property (nonatomic, strong)NSMutableArray<MediaModel *> *dataArr;
@property (nonatomic, assign) NSInteger maxCount;//可加载的最大数量
- (void)reloadData;

//- (void)reloadSpecialDataWithModel:(MediaModel *)model;


//@property (nonatomic, assign) CameraType cameraType;
//@property (nonatomic, assign) BOOL isUpLoading;

//@property (nonatomic, strong) NSMutableArray<UpLoadModel *> *dataSource;
//@property (nonatomic, assign) NSInteger maxCount;//默认为1
//@property (nonatomic, strong) UIImage *lastImage;   //default [UIImage imageNamed:@"Id-photo-upload"]
//@property (nonatomic, strong) UIImage *defaultImage;//default [UIImage imageNamed:@"lastImage"]
//@property (nonatomic, assign) BOOL isStore;//选择出的照片被存入指定路径
//- (void)addHeaderWithTitle:(NSString *)title subtitle:(NSString *)subtitle;
//- (void)reloadData;
//- (void)reloadSpecialDataWithModel:(UpLoadModel *)model;

@end
