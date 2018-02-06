//
//  ComNetWorkTool.h
//  项目模板
//
//  Created by ychen on 16/10/8.
//  Copyright © 2016年 ComProject. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ComMessageBox.h"
#import "ComLoadingIndicator.h"



/** 数据请求方法*/
typedef enum{
    POST=0,
    GET,
    PUT,
    PATCH,
    DELETE
}RequestMethod;



@interface ComNetWorkTool : NSObject

/** 单例*/
+(instancetype)shareManager;



/** 设置客户端类型*/
- (void)setClientType:(NSString *)clientType;

/** 设置客户端版本*/
- (void)setClientVersion:(NSString *)clientVersion;

/** 设置当前登录的 session*/
- (void)setSessionNum:(NSString *)sessionNum;

/** 设置当前设备的设备号，如果不设置，会自动获取*/
- (void)setDeviceNum:(NSString *)deviceNum;

/** 设置验证代码（该参数放在http请求的header中），如果请求需要检验，请设置*/
- (void)setCheckCode:(NSString *)checkCode;

/** 设置请求默认的服务器地址*/
- (void)setDefaultUrlStr:(NSString *)defaultUrlStr;

/** 获取当前默认的服务器地址*/
- (NSString *)defaultUrlStr;

/** 设置登录页类名*/
- (void)setLoginViewControllerName:(NSString *)loginVCName;



/** 开启监测网络状态*/
- (void)startMonitoringNetWorkReachability:(BOOL)enabled;



/** 是否显示手机状态栏的网络访问标示*/
- (void)showNetWorkActivityIndication:(BOOL)enabled;



/** 请求成功时返回的block*/
typedef void(^RequestSuccessBlock)(id responseObject);

/** 请求失败时返回的block*/
typedef void(^RequestFailBlock)(NSError *error);

/** 请求网络数据方法*/
-(void)startRequestMethod:(RequestMethod)method
                   urlStr:(NSString *)urlStr
               parameters:(NSDictionary *)parameters
    loadingIndicatorStyle:(ComLoadingIndicatorStyle)indicatorStyle
             successBlock:(void (^)(id responseObject))successBlock
             failureBlock:(void(^)(NSError *error))failBlock;

@end
