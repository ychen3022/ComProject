//
//  ComNetWorkTool.m
//  项目模板
//
//  Created by ychen on 16/10/8.
//  Copyright © 2016年 ComProject. All rights reserved.
//

#import "ComNetWorkTool.h"
#import <UIKit/UIDevice.h>
#import <AFNetworking.h>
#import <AFNetworkActivityIndicatorManager.h>



/** 网络请求指示器*/
static ComLoadingIndicator *loadingIndicator = nil;
/** 网络状态*/
static AFNetworkReachabilityStatus networkStatus;
/** 默认的服务器地址*/
static NSString *Com_DefaultUrlStr = nil;
/** 客户端类型*/
static NSString *Com_ClientType = @"3";
/** 客户端版本号*/
static NSString *Com_ClientVersion = @"1.0.0";
/** 当前登录Session*/
static NSString *Com_SessionNum = @"";
/** 当前设备号*/
static NSString *Com_DeviceNum = @"";
/** 验证代码*/
static NSString *Com_CheckCode = @"aXNvaHVhbmdzaGl6eHl5";
/** 登录类名*/
static NSString *Com_LoginVCName = @"";


@implementation ComNetWorkTool

#pragma mark -单利
static ComNetWorkTool *_instance;
+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

- (id)copyWithZone:(NSZone *)zone{
    return _instance;
}

- (id)mutableCopyWithZone:(NSZone *)zone{
    return _instance;
}

+(instancetype)shareManager{
    return [[self alloc] init];
}



#pragma mark -设置客户端类型
- (void)setClientType:(NSString *)clientType{
    Com_ClientType=clientType;
}



#pragma mark -设置客户端版本
- (void)setClientVersion:(NSString *)clientVersion{
    Com_ClientVersion=clientVersion;
}



#pragma mark -设置当前登录的session
- (void)setSessionNum:(NSString *)sessionNum{
    Com_SessionNum=sessionNum;
}



#pragma mark -设置当前设备的设备号，如果不设置，会自动获取
- (void)setDeviceNum:(NSString *)deviceNum{
    Com_DeviceNum=deviceNum;
}



#pragma mark -设置验证代码（该参数放在http请求的header中），如果请求需要检验，请设置
- (void)setCheckCode:(NSString *)checkCode{
    Com_CheckCode=checkCode;
}



#pragma mark -设置请求默认的服务器地址
- (void)setDefaultUrlStr:(NSString *)defaultUrlStr{
    Com_DefaultUrlStr=defaultUrlStr;
}


#pragma mark -获取当前默认的服务器地址
- (NSString *)defaultUrlStr{
    return Com_DefaultUrlStr;
}



#pragma mark -设置登录页类名
- (void)setLoginViewControllerName:(NSString *)loginVCName{
    Com_LoginVCName=loginVCName;
}



#pragma mark -是否开启监测网络状态
- (void)startMonitoringNetWorkReachability:(BOOL)enabled{
    if (enabled) {
        AFNetworkReachabilityManager *reachabilityManager=[AFNetworkReachabilityManager sharedManager];
        [reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            networkStatus = status;
            NSString *noteStr = nil;
            BOOL netWorkConnect=YES;
            switch (status) {
                case AFNetworkReachabilityStatusNotReachable:
                {
                    noteStr = @"当前没有网络,请检查网络连接";
                    netWorkConnect=NO;
                }
                    break;
                case AFNetworkReachabilityStatusReachableViaWWAN:
                {
                    noteStr = @"当前使用手机数据网络";
                    netWorkConnect=YES;
                }
                    break;
                case AFNetworkReachabilityStatusReachableViaWiFi:
                {
                    noteStr = @"当前使用 WiFi 网络";
                    netWorkConnect=YES;
                }
                    break;
                case AFNetworkReachabilityStatusUnknown:
                default:
                {
                    noteStr = @"未知网络连接";
                    netWorkConnect=YES;
                }
                    break;
            }
            
            if (netWorkConnect==NO) {
                [ComMessageBox showMessageBoxWithStyle:comMessageBoxStyleHUD title:@"提示" message:noteStr];
            }
            
        }];
        
        [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    }else {
        [[AFNetworkReachabilityManager sharedManager] stopMonitoring];
    }
}



#pragma mark -是否显示手机状态栏的网络访问标示
- (void)showNetWorkActivityIndication:(BOOL)enabled{
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:enabled];
}



#pragma mark -请求网络数据方法
-(void)startRequestMethod:(RequestMethod)method
                   urlStr:(NSString *)urlStr
               parameters:(NSDictionary *)parameters
    loadingIndicatorStyle:(ComLoadingIndicatorStyle)indicatorStyle
             successBlock:(RequestSuccessBlock)successBlock
             failureBlock:(RequestFailBlock)failBlock{
    
//    拼接成完整的请求参数
//    static NSString *sDeviceUUIDStr = nil;
//    if (!sDeviceUUIDStr) {
//        sDeviceUUIDStr = [NSString stringWithFormat:@"%@",[[UIDevice currentDevice] identifierForVendor].UUIDString];
//    }
//    NSMutableDictionary *postDictionary = [[NSMutableDictionary alloc] initWithDictionary:parameters];
//    NSString *apiName=@"Z007002";
//    [postDictionary setObject:apiName forKey:@"TX"];  //API名字
//    [postDictionary setObject:Com_ClientType forKey:@"T"];    //客户端类型
//    [postDictionary setObject:Com_ClientType forKey:@"V"];    //版本号
//    [postDictionary setObject:Com_SessionNum forKey:@"S"];    //登录标示 session
//    [postDictionary setObject:Com_DeviceNum.length?Com_DeviceNum:(sDeviceUUIDStr?sDeviceUUIDStr:@"") forKey:@"D"];
    //设备号唯一标示
//    NSString *jsonString = [URGeneralClass changeToJSONWithDictionary:postDictionary];
//    NSDictionary *requestData = @{@"requestData":jsonString};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //验证代码
//   [manager.requestSerializer setValue:Com_CheckCode forHTTPHeaderField:@"K"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"application/json",@"text/json",@"text/javascript",@"text/html", nil];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    switch (method) {
        case POST:
        {
            DLog(@"+++POST请求+++");
            [manager POST:urlStr parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                DLog(@"请求地址：\n%@\n\n请求参数：\n%@\n\n返回数据：\n%@",urlStr,parameters,[NSString stringWithFormat:@"%@",responseObject]);
                
                if ([responseObject[@"R"] integerValue] == 200) {
                    //如果符合某种条件就返回网络请求的正确数据
                    successBlock(responseObject);
                } else {
                    //如果符合某种条件就返回网络请求的错误数据
                    failBlock(responseObject);
                    [_instance handleRequestFailWithReturnValue:responseObject messageBoxStyle:comMessageBoxStyleAlert];
                }
                
                if (indicatorStyle != comLoadingIndicatorStyleNone) {
                    [loadingIndicator stopLoading];
                }
                
                
            }failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                DLog(@"请求地址：\n%@\n\n请求参数：\n%@\n\n返回数据：\n%@",urlStr,parameters,(error.code==-1009)?@"网络连接失败，请检查您的网络设置":@"连接服务器失败，请稍后重试");
                if ((error.code != -1001) && (error.code != -1009)) {//如果不是服务器返回的错误原因，检查客户端的错误原因
                    NSError *tempError = error;
                    if (networkStatus == AFNetworkReachabilityStatusNotReachable) {
                        error = [[NSError alloc] initWithDomain:tempError.domain code:-1009 userInfo:tempError.userInfo];
                    } else {
                        error = [[NSError alloc] initWithDomain:tempError.domain code:-1001 userInfo:tempError.userInfo];
                    }
                }
                failBlock(error);
                [_instance handleFailRequestWithError:error messageBoxStyle:comMessageBoxStyleAlert];
                if (indicatorStyle != comLoadingIndicatorStyleNone) {
                    [loadingIndicator stopLoading];
                }
            }];
       
        }
            break;
        case GET:
        {
            DLog(@"+++GET请求+++");
            [manager GET:urlStr parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                DLog(@"请求地址：\n%@\n\n请求参数：\n%@\n\n返回数据：\n%@",urlStr,parameters,[NSString stringWithFormat:@"%@",responseObject]);
                
//                if ([responseObject[@"R"] integerValue] == 200) {
                if (responseObject) {

                    //如果符合某种条件就返回网络请求的正确数据
                    successBlock(responseObject);
                } else {
                    //如果符合某种条件就返回网络请求的错误数据
                    failBlock(responseObject);
                    [_instance handleRequestFailWithReturnValue:responseObject messageBoxStyle:comMessageBoxStyleAlert];
                }
                
                if (indicatorStyle != comLoadingIndicatorStyleNone) {
                    [loadingIndicator stopLoading];
                }
                
                
            }failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                DLog(@"请求地址：\n%@\n\n请求参数：\n%@\n\n返回数据：\n%@",urlStr,parameters,(error.code==-1009)?@"网络连接失败，请检查您的网络设置":@"连接服务器失败，请稍后重试");
                if ((error.code != -1001) && (error.code != -1009)) {//如果不是服务器返回的错误原因，检查客户端的错误原因
                    NSError *tempError = error;
                    if (networkStatus == AFNetworkReachabilityStatusNotReachable) {
                        error = [[NSError alloc] initWithDomain:tempError.domain code:-1009 userInfo:tempError.userInfo];
                    } else {
                        error = [[NSError alloc] initWithDomain:tempError.domain code:-1001 userInfo:tempError.userInfo];
                    }
                }
                failBlock(error);
                [_instance handleFailRequestWithError:error messageBoxStyle:comMessageBoxStyleAlert];
                if (indicatorStyle != comLoadingIndicatorStyleNone) {
                    [loadingIndicator stopLoading];
                }
            }];
            
        }
            break;
        case PUT:
        {
            DLog(@"+++PUT请求+++");
        }
            break;
        case PATCH:
        {
            DLog(@"+++PATCH请求+++");
        }
            break;
        case DELETE:
        {
            DLog(@"+++DELETE请求+++");
        }
            break;
        default:
            break;
    }
    
    //开启网络请求指示器
    if (indicatorStyle != comLoadingIndicatorStyleNone) {
        loadingIndicator = [[ComLoadingIndicator alloc] init];
        [loadingIndicator startLoadingWithCancel:^(id returnValue) {
            //取消网络请求,不知道这句代码有没有用，没有用的话，后期再改
            [manager.operationQueue cancelAllOperations];
            DLog(@"停止网络请求");
        }];
    }
}



#pragma mark -展示服务器返回错误
- (void)handleRequestFailWithReturnValue:(id _Nullable)responseObject
                         messageBoxStyle:(ComMessageBoxStyle)messageBoxStyle{
    //返回登录界面，是因为未登录造成的原因
    if ([responseObject[@"R"] integerValue] == 401) {
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:[NSClassFromString(Com_LoginVCName) new] animated:YES completion:^{
        }];
    }
    [ComMessageBox showMessageBoxWithStyle:messageBoxStyle title:@"提示" message:[responseObject[@"I"] length]?responseObject[@"I"]:responseObject[@"M"]];
}



#pragma mark -展示连接服务器失败返回错误
- (void)handleFailRequestWithError:(NSError *)error  messageBoxStyle:(ComMessageBoxStyle)messageBoxStyle{
    NSString *noteStr = nil;
    switch (error.code) {
        case -1009:
        {
            noteStr = @"当前网络不可用，请检查您的网络设置";
        }
            break;
        case -1001:
        default:
        {
            noteStr = @"连接服务器失败，请稍后重试";
        }
            break;
    }
    [ComMessageBox showMessageBoxWithStyle:messageBoxStyle title:@"提示" message:noteStr];
}
@end
