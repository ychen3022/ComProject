//
//  UserInfoModel.h
//  ComProject
//
//  Created by 陈园 on 2017/11/14.
//  Copyright © 2017年 陈园. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfoModel : JSONModel

@property (nonatomic, strong) NSString *userId;    //用户Id
@property (nonatomic, strong) NSString *userName;  //用户姓名
@property (nonatomic, strong) NSString *userPhone; //手机号码
@property (nonatomic, strong) NSString *userToken; //用户唯一标志

@end
