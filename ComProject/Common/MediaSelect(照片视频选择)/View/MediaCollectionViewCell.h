//
//  MediaCollectionViewCell.h
//  照片视频Demo
//
//  Created by 陈园 on 2017/7/11.
//  Copyright © 2017年 陈园. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MediaModel.h"

@interface MediaCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *imageView;//照片
@property (nonatomic, strong) UIButton *deleteBtn;//右上角删除按钮
@property (nonatomic, strong) UIButton *playBtn;//播放按钮

-(void)configMediaCellWithModel:(MediaModel *)photoModel;

@end
