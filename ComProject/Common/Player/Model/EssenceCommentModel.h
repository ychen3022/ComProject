//
//  EssenceCommentModel.h
//  项目模板
//
//  Created by ychen on 16/10/8.
//  Copyright © 2016年 ComProject. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ComUesr.h"

@interface EssenceCommentModel : NSObject

/** 评论id */
@property (nonatomic, copy) NSString *id;
/** 用户*/
@property(nonatomic,strong)ComUesr *user;
/** 点赞数*/
@property(nonatomic,assign)NSInteger like_count;
/** 评论时间*/
@property(nonatomic,copy)NSString *ctime;
/** 评论内容*/
@property(nonatomic,copy)NSString *content;
/** 评论音频文件的路径 */
@property (nonatomic, copy) NSString *voiceuri;
/** 评论音频文件的时长 */
@property (nonatomic, assign) NSInteger voicetime;



/** 评论cell中评论内容的高度*/
@property(nonatomic,assign)CGFloat contentLabelH;
/** 评论cell的高度*/
@property(nonatomic,assign)CGFloat commentCellH;

@end


//"top_cmt" =             (
//                         {
//                             content = "\U5c0f\U5b66\U751f\U7ec8\U4e8e\U4e0d\U5751\U4e86";
//                             ctime = "2016-07-29 10:38:27";
//                             "data_id" = 19584430;
//                             id = 59345863;
//                             "like_count" = 609;
//                             precid = 0;
//                             precmt =                     (
//                             );
//                             preuid = 0;
//                             status = 0;
//                             user =                     {
//                                 id = 18939061;
//                                 "is_vip" = 0;
//                                 "personal_page" = "http://user.qzone.qq.com/2F9C6F617C53D12E1D77049313A77281";
//                                 "profile_image" = "http://qzapp.qlogo.cn/qzapp/100336987/2F9C6F617C53D12E1D77049313A77281/100";
//                                 "qq_uid" = "";
//                                 "qzone_uid" = 2F9C6F617C53D12E1D77049313A77281;
//                                 sex = m;
//                                 "total_cmt_like_count" = 854;
//                                 username = asjshjs;
//                                 "weibo_uid" = "";
//                             };
//                             voicetime = 0;
//                             voiceuri = "";
//                         }
//                         );

//image1	string	显示在页面中的视频图片的url
//image0	string	显示在页面中的视频图片的url
//image_small	string	显示在页面中的视频图片的url