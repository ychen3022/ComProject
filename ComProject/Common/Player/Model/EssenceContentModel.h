//
//  EssenceContentModel.h
//  项目模板
//
//  Created by ychen on 16/10/8.
//  Copyright © 2016年 ComProject. All rights reserved.
//

/** 精华页cell中的帖子类型*/
typedef enum{
    EssenceTypeAll=1,
    EssenceTypePicture=10,
    EssenceTypeWord=29,
    EssenceTypeVoice=31,
    EssenceTypeVideo=41
}EssenceType;

#import <Foundation/Foundation.h>
@class EssenceCommentModel;

@interface EssenceContentModel : NSObject

/** 帖子id*/
@property(nonatomic,copy)NSString *id;
/** 名称*/
@property (nonatomic, copy) NSString *name;
/** 是否为加V用户*/
@property (nonatomic, assign, getter=isSina_v) BOOL sina_v;
/** 头像 */
@property (nonatomic, copy) NSString *profile_image;
/** 发帖时间 */
@property (nonatomic, copy) NSString *create_time;
/** 文字内容 */
@property (nonatomic, copy) NSString *text;
/** 顶的数量 */
@property (nonatomic, assign) NSInteger ding;
/** 踩的数量 */
@property (nonatomic, assign) NSInteger cai;
/** 转发的数量 */
@property (nonatomic, assign) NSInteger repost;
/** 评论的数量 */
@property (nonatomic, assign) NSInteger comment;
/** 评论数组 (这个数组里面存放着模型EssenceCommentModel) */
@property(nonatomic,strong)NSMutableArray *top_cmt;


/** 视频或图片类型帖子的宽度 */
@property (nonatomic, assign) CGFloat width;
/** 图片或者视频等其他类型cell的内容的高度 */
@property (nonatomic, assign) CGFloat height;
/** 小图片的URL */
@property (nonatomic, copy) NSString *small_image;
/** 中图片的URL */
@property (nonatomic, copy) NSString *middle_image;
/** 大图片的URL */
@property (nonatomic, copy) NSString *large_image;
/** 播放次数*/
@property(nonatomic,assign)NSInteger playcount;
/** 音频时长*/
@property(nonatomic,assign)NSInteger voicetime;
/** 音频URL*/
@property(nonatomic,copy)NSString *voiceuri;
/** 视频时长*/
@property(nonatomic,assign)NSInteger videotime;
/** 视频加载时候的静态显示的图片地址*/
@property(nonatomic,strong)NSString *cdn_img;
/** 视频播放的url地址*/
@property(nonatomic,strong)NSString *videouri;




/** cell的类型*/
@property(nonatomic,assign)EssenceType type;
/** cell的高度*/
@property(nonatomic,assign)CGFloat cellHeight;
/** cell中的图片的frame*/
@property(nonatomic,assign)CGRect pictureF;
/** cell中音频的Frame*/
@property(nonatomic,assign)CGRect voiceF;
/** cell中视频的frame*/
@property(nonatomic,assign)CGRect videoF;
/** cell中显示图片是否是大图，大图需要只显示一半*/
@property(nonatomic,assign,getter=isBigPicture)BOOL bigPictureFlag;
/** cell中的最热评论的frame*/
@property(nonatomic,assign)CGRect hotCommentViewF;
/** cell中的最热评论的commentContentLabel的高度*/
@property(nonatomic,assign)CGFloat commentContentLabelH;
/** cell中的图片下载进度 */
@property (nonatomic, assign) CGFloat pictureLoadProgress;

@end
