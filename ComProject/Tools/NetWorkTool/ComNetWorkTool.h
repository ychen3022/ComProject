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

@interface ComNetWorkTool : NSObject


/**
 *  单例
 *
 *  @return 返回ComNetWorkTool
 */
+(instancetype)shareManager;



/**
 * 设置客户端类型
 *
 * @param clientType - 客户端类型标示
 */
- (void)setClientType:(NSString *)clientType;



/**
 * 设置客户端版本
 *
 * @param clientVersion - app当前版本号
 */
- (void)setClientVersion:(NSString *)clientVersion;



/**
 * 设置当前登录的 session
 *
 * @param sessionNum - 当前登录的 session
 */
- (void)setSessionNum:(NSString *)sessionNum;



/**
 * 设置当前设备的设备号，如果不设置，会自动获取
 *
 * @param deviceNum - 当前设备的设备号
 */
- (void)setDeviceNum:(NSString *)deviceNum;



/**
 * 设置验证代码（该参数放在http请求的header中），如果请求需要检验，请设置
 *
 * @param checkCode -  校验码
 */
- (void)setCheckCode:(NSString *)checkCode;



/**
 * 设置请求默认的服务器地址
 *
 * @param defaultUrlStr - 默认的服务器地址
 */
- (void)setDefaultUrlStr:(NSString *)defaultUrlStr;



/**
 *  获取当前默认的服务器地址
 *
 *  @return 当前服务器地址
 */
- (NSString *)defaultUrlStr;



/**
 * 设置登录页类名
 *
 * @param loginVCName - 登录类名
 */
- (void)setLoginViewControllerName:(NSString *)loginVCName;



/**
 * 开启监测网络状态
 *
 * @param enabled - YES：开启监测；NO：关闭
 */
- (void)startMonitoringNetWorkReachability:(BOOL)enabled;



/**
 * 是否显示手机状态栏的网络访问标示
 *
 * @param enabled - YES：显示；NO：不显示
 */
- (void)showNetWorkActivityIndication:(BOOL)enabled;



/**
 *  请求成功时返回的block
 *
 *  @param responseObject 成功Block
 */
typedef void(^RequestSuccessBlock)(id responseObject);



/**
 *  请求失败时返回的block
 *
 *  @param error 失败Block
 */
typedef void(^RequestFailBlock)(NSError *error);



/**
 *  数据请求方法
 */
typedef enum{
    POST=0,
    GET,
    PUT,
    PATCH,
    DELETE
}RequestMethod;



/**
 *  请求网络数据方法
 *
 *  @param method         请求网络方法 GET POST
 *  @param urlStr         请求地址
 *  @param parameters     请求参数
 *  @param indicatorStyle 请求网络指示器
 *  @param successBlock   成功返回Block
 *  @param failBlock      失败返回Block
 */
-(void)startRequestMethod:(RequestMethod)method
                   urlStr:(NSString *)urlStr
               parameters:(NSDictionary *)parameters
    loadingIndicatorStyle:(ComLoadingIndicatorStyle)indicatorStyle
             successBlock:(void (^)(id responseObject))successBlock
             failureBlock:(void(^)(NSError *error))failBlock;

@end
