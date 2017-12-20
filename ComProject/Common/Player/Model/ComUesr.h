//
//  ComUesr.h
//  项目模板
//
//  Created by ychen on 16/10/8.
//  Copyright © 2016年 ComProject. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ComUesr : NSObject
/** 用户id*/
@property(nonatomic,assign)NSInteger id;
/** 用户名*/
@property(nonatomic,copy)NSString *username;
/** 用户头像*/
@property(nonatomic,strong)NSString *profile_image;
/** 用户性别*/
@property(nonatomic,copy)NSString *sex;
@end

//id = 18939061;
////                                 "is_vip" = 0;
////                                 "personal_page" = "http://user.qzone.qq.com/2F9C6F617C53D12E1D77049313A77281";
////                                 "profile_image" = "http://qzapp.qlogo.cn/qzapp/100336987/2F9C6F617C53D12E1D77049313A77281/100";
////                                 "qq_uid" = "";
////                                 "qzone_uid" = 2F9C6F617C53D12E1D77049313A77281;
////                                 sex = m;
////                                 "total_cmt_like_count" = 854;
////                                 username = asjshjs;
//                                 "weibo_uid" = "";