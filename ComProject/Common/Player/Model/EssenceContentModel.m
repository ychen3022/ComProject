//
//  EssenceWorkModel.m
//  项目模板
//
//  Created by ychen on 16/10/8.
//  Copyright © 2016年 ComProject. All rights reserved.
//

#import "EssenceContentModel.h"
#import "NSDate+Ext.h"
#import "NSString+Ext.h"
#import <MJExtension.h>
#import "EssenceCommentModel.h"

@implementation EssenceContentModel

#pragma mark -帖子的创建时间
-(NSString *)create_time{
    //日期格式化类
    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
    //设置日期格式（y:年  M:月  d:日  H:时  m:分  s:秒）
    formatter.dateFormat=@"yyyy-MM-dd HH:mm:ss";
    //帖子的创建时间
    NSDate *create=[formatter dateFromString:_create_time];
    
    if ([create isThisYear]) {//是今年
        if ([create isToday]) {//今天
            NSDateComponents *cmps=[[NSDate date] compareFrom:create];
            if (cmps.hour>=1) {//时间差距>=1小时
                return [NSString stringWithFormat:@"%zd小时前",cmps.hour];
            }else if(cmps.minute>=1){//时间差距>=1分钟
                return [NSString stringWithFormat:@"%zd分钟",cmps.minute];
            }else{//时间差距<1小时
                return @"刚刚";
            }
        }else if ( [create isYestorday]){//昨天
            formatter.dateFormat=@"昨天 HH:mm:ss";
            return [formatter stringFromDate:create];
        }else{//其他情况
            formatter.dateFormat=@"MM-dd HH:mm:ss";
            return [formatter stringFromDate:create];
        }
    }else{//不是今年
        return _create_time;
    }
}

#pragma mark -替代模型中的名称
+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{
             @"small_image" : @"image0",
             @"large_image" : @"image1",
             @"middle_image" : @"image2"
             };
}

#pragma mark -top_cmt数组
+(NSDictionary *)mj_objectClassInArray{
    return @{@"top_cmt":@"EssenceCommentModel"};
}


#pragma mark -计算cell的高度
-(CGFloat)cellHeight{
    //计算cell中文字的高度,以及只有文字的高度
    CGFloat cellTextH=[_text calculateTextHeightWithFont:[UIFont systemFontOfSize:15] maxW:KScreenW-2*10-2*8].height;
    _cellHeight=55+cellTextH+2*10;

    if(_type==EssenceTypePicture){//cell是照片类型
        CGFloat pictureX=10;
        CGFloat pictureY=55+cellTextH+10;
        CGFloat pictureW=KScreenW-2*10-2*8;
        CGFloat pictureH=_height*pictureW/_width;
        if(pictureH>=400){
            pictureH=250;
            self.bigPictureFlag=YES;
        }else{
            self.bigPictureFlag=NO;
        }
        _pictureF=CGRectMake(pictureX,pictureY,pictureW, pictureH);
        _cellHeight=_cellHeight+_pictureF.size.height;
        
    }else if(_type==EssenceTypeVoice){//cell是声音类型
        CGFloat voiceX=10;
        CGFloat voiceY=55+cellTextH+10;
        CGFloat voiceW=KScreenW-2*10-2*8;
        CGFloat voiceH=voiceW *_height/_width;
        _voiceF=CGRectMake(voiceX, voiceY, voiceW, voiceH);
        _cellHeight=_cellHeight+_voiceF.size.height;
    }else if(_type==EssenceTypeVideo){//cell是视频类型
        CGFloat videoX=10;
        CGFloat videoY=55+cellTextH+10;
        CGFloat videoW=10;
        CGFloat videoH=videoW * _height/_width;
        _videoF=CGRectMake(videoX, videoY, videoW, videoH);
        _cellHeight=_cellHeight+_videoF.size.height;
    }
    
    //是否有最热评论
    EssenceCommentModel *commentModel=[self.top_cmt firstObject];
    if (commentModel) {
        NSString *commentStr=[NSString stringWithFormat:@"%@ : %@",commentModel.user.username,commentModel.content];
        CGFloat commentH=[commentStr calculateTextHeightWithFont:[UIFont systemFontOfSize:12] maxW:KScreenW-2*10-2*8].height;
        _commentContentLabelH=commentH;
        
        CGFloat hotCommentViewX=10;
        CGFloat hotCommentViewY=_cellHeight;
        CGFloat hotCommengViewW=KScreenW-2*10-2*8;
        CGFloat hotCommentViewH=commentH+3*10;
        _hotCommentViewF=CGRectMake(hotCommentViewX, hotCommentViewY,hotCommengViewW ,hotCommentViewH );
        _cellHeight=_cellHeight+hotCommentViewH;
    }
    //加上cell底部的toolView的高度
    return _cellHeight+40;
}
@end
