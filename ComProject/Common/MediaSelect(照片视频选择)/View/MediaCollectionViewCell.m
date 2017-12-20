//
//  MediaCollectionViewCell.m
//  照片视频Demo
//
//  Created by 陈园 on 2017/7/11.
//  Copyright © 2017年 陈园. All rights reserved.
//

#import "MediaCollectionViewCell.h"
#import "UIView+Ext.h"

@implementation MediaCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        self.imageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        [self.contentView addSubview:self.imageView];
        
        self.deleteBtn=[[UIButton alloc] initWithFrame:CGRectMake(self.width-10,0 , 20, 20)];
        [self.deleteBtn setImage:[UIImage imageNamed:@"photos-delete"] forState:UIControlStateNormal];
        [self.contentView addSubview:self.deleteBtn];
        
        self.playBtn=[[UIButton alloc] initWithFrame:CGRectMake((self.width-60)/2,(self.width-60)/2 , 60, 60)];
        [self.playBtn setImage:[UIImage imageNamed:@"player-play"] forState:UIControlStateNormal];
        [self.contentView addSubview:self.playBtn];
    }
    return self;
}


-(void)configMediaCellWithModel:(MediaModel *)mediaModel{
    self.playBtn.hidden=YES;
    self.deleteBtn.hidden=YES;
    if (mediaModel.mediaType == MediaType_Photo) {
        switch (mediaModel.mediaCellState) {
            case MediaCellState_Normal:
                self.imageView.image=mediaModel.coverPhoto;
                self.deleteBtn.hidden=NO;
                break;
                
            case MediaCellState_Add:
                self.imageView.image=[UIImage imageNamed:@"add-photo"];
                
                break;
            default:
                break;
        }
        
    }else if(mediaModel.mediaType == MediaType_Video){
        switch (mediaModel.mediaCellState) {
            case MediaCellState_Normal:
                self.imageView.image=mediaModel.coverPhoto;
                self.deleteBtn.hidden=NO;
                self.playBtn.hidden=NO;
                
                break;
                
            case MediaCellState_Add:
                self.imageView.image=[UIImage imageNamed:@"add-photo"];
                
                break;
            default:
                break;
        }
    }
    
}

@end
