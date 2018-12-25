//
//  AFNetInterFaceManager.m
//
//  Created by weichengzong on 17/7/14.
//  Copyright © 2016年 wangpengfei. All rights reserved.
//

#import "AFNetInterFaceManager.h"
#import <objc/runtime.h>
#import "CRBaseRequestModel.h"
#import <netinet6/in6.h>
#import <netinet/in.h>
#import "AFNetworkActivityIndicatorManager.h"


#define kLastWindow [UIApplication sharedApplication].keyWindow

@implementation AFNetInterFaceManager

//+(AFNetInterFaceManager *)sharedManager{
//    static AFNetInterFaceManager *intefaceManage;
//    static dispatch_once_t onceTonken;
//    dispatch_once(&onceTonken,^{
//        intefaceManage =[[self alloc]init];
//    }
//                  );
//    return intefaceManage;
//}


#pragma mark - API方法

+ (BOOL)hasNetworkReachability{
    return _networkReachability;
}

+ (NSURLSessionDataTask *)Get:(NSString *)urlStr
                     parameters:(id)parameters
                        success:(successBlock)success
                        failure:(failureBlock)failure{
    
    return [self Get:urlStr parameters:parameters  graceTime:NetworkRequestGraceTimeTypeNormal isHTTPRequestSerializer:YES isHTTPResponseSerializer:NO success:success failure:failure];
}
+ (NSURLSessionDataTask *)Get:(NSString *)urlStr
                   parameters:(id)parameters
                    graceTime:(NetworkRequestGraceTimeType)graceTime
                      success:(successBlock)success
                      failure:(failureBlock)failure{
        return [self Get:urlStr parameters:parameters  graceTime:graceTime isHTTPRequestSerializer:YES isHTTPResponseSerializer:NO success:success failure:failure];
}

+ (NSURLSessionDataTask *)Get:(NSString *)urlStr
                     parameters:(id)parameters
                      graceTime:(NetworkRequestGraceTimeType)graceTime
        isHTTPRequestSerializer:(BOOL)isHTTPRequestSerializer
       isHTTPResponseSerializer:(BOOL)isHTTPResponseSerializer
                        success:(successBlock)success
                        failure:(failureBlock)failure{
    CFAbsoluteTime startTime =CFAbsoluteTimeGetCurrent();
    NSString *fullUrl = [NSString stringWithFormat:@"%@", urlStr];
    //传入数据对象或者字典
//    NSMutableDictionary *requestParam = [NSMutableDictionary dictionaryWithDictionary:[parameters toDictionary]];
    NSMutableDictionary *requestParam = (NSMutableDictionary *)parameters;
    NSLog(@"request parameter:%@----%@",fullUrl, requestParam);

//    AFHTTPSessionManager *manager = [self manager:isHTTPRequestSerializer isHTTPResponseSerializer:isHTTPResponseSerializer];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",@"text/plain", @"text/json", @"text/javascript",@"text/html", @"text/plain",@"application/atom+xml",@"application/xml",@"text/xml", @"image/*"]];
//    MBProgressHUD *hud = [self hud:graceTime];
    
    // oper和operation指向同一个操作，但是状态不同，oper为isReady状态，operation是isFinished状态
    NSURLSessionDataTask *oper = [manager GET:fullUrl parameters:requestParam progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSError *error = nil;
        NSDictionary *responseData = [NSJSONSerialization JSONObjectWithData:responseObject
                                                                     options:NSJSONReadingMutableContainers
                                                                       error:nil];
        NSLog(@"\nabsoluteUrl: %@\n errorInfos:%@\n\n",task.response.URL.absoluteString,error);
        NSLog(@"respose>>>>>>>%@",responseData);

        CFAbsoluteTime linkTime = (CFAbsoluteTimeGetCurrent() - startTime);
        
        NSLog(@"Linked in %f ms", linkTime *1000.0);
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;// 关闭网络指示器
        if (success) {
            NSDictionary *dict = (NSDictionary*)responseData;
            success(dict,responseObject);
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

//        [hud hideAnimated:YES];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;// 关闭网络指示器
        NSLog(@"\nabsoluteUrl: %@\n params:%@\n errorInfos:%@\n\n",task.response.URL.absoluteString,parameters,error);
        CFAbsoluteTime linkTime = (CFAbsoluteTimeGetCurrent() - startTime);
        
        NSLog(@"Linked in %f ms", linkTime *1000.0);
        if (failure) {
            failure(error,task);
        }

    }];
    
    return oper;
}
+ (NSURLSessionDataTask *)Post:(NSString *)urlStr
                       hostUrl:(NSString *)hostUrl
                    parameters:(id)parameters
                       success:(successBlock)success
                       failure:(failureBlock)failure{
    
    return [self Post:urlStr hostUrl:hostUrl parameters:parameters graceTime:NetworkRequestGraceTimeTypeNormal isHTTPRequestSerializer:YES isHTTPResponseSerializer:YES success:success failure:failure];
}
+ (NSURLSessionDataTask *)Postip:(NSString *)urlStr
                       hostUrl:(NSString *)hostUrl
                    parameters:(id)parameters
                       success:(successBlock)success
                       failure:(failureBlock)failure{
    
    return [self Post:urlStr hostUrl:hostUrl parameters:parameters graceTime:NetworkRequestGraceTimeTypeNone isHTTPRequestSerializer:YES isHTTPResponseSerializer:YES success:success failure:failure];
}

+ (NSURLSessionDataTask *)Post:(NSString *)urlStr
                    parameters:(id)parameters
                       success:(successBlock)success
                       failure:(failureBlock)failure{
    return [self Post:urlStr hostUrl:nil parameters:parameters graceTime:NetworkRequestGraceTimeTypeNormal isHTTPRequestSerializer:YES isHTTPResponseSerializer:YES success:success failure:failure];
}

+ (NSURLSessionDataTask *)Post:(NSString *)urlStr
                    parameters:(id)parameters
                     graceTime:(NetworkRequestGraceTimeType)graceTime
                       success:(successBlock)success
                       failure:(failureBlock)failure{
    return [self Post:urlStr hostUrl:nil parameters:parameters graceTime:graceTime isHTTPRequestSerializer:YES isHTTPResponseSerializer:YES success:success failure:failure];
}

+ (NSURLSessionDataTask *)Post:(NSString *)urlStr
                       hostUrl:(NSString *)hostUrl
                    parameters:(id)parameters
                     graceTime:(NetworkRequestGraceTimeType)graceTime
       isHTTPRequestSerializer:(BOOL)isHTTPRequestSerializer
      isHTTPResponseSerializer:(BOOL)isHTTPResponseSerializer
                       success:(successBlock)success
                       failure:(failureBlock)failure{
    NSString *fullUrl = nil;
    if (hostUrl) {
        if (kAppDelegate.isGUONEI) {
            fullUrl = [NSString stringWithFormat:@"%@%@", B_Address, urlStr];
        }else{
            fullUrl = [NSString stringWithFormat:@"%@%@", A_Address, urlStr];
        }
    }else{
        if ([[MyUserInfo getInfoForkey:[[MyUserInfo getUserInfo] objectForKey:SHInvokerUserInfouser_name]] isEqualToString:@"guowai"]) {
           fullUrl = [NSString stringWithFormat:@"%@%@", Y_Address, urlStr];
        }else
        {
            if (kAppDelegate.isGUONEI) {
                fullUrl = [NSString stringWithFormat:@"%@%@", B_Address, urlStr];
            }else{
                fullUrl = [NSString stringWithFormat:@"%@%@", A_Address, urlStr];
            }
        }
    }
    NSDictionary *request = nil;
    NSLog(@"请求的网络地址-------%@",fullUrl);
    if ([parameters isKindOfClass:[NSMutableDictionary class]]) {
        request = (NSDictionary *)parameters;
    }else{
        request = [parameters toDictionary];
    }
    
    NSLog(@"request parameter:------%@", request);
    
    
    AFHTTPSessionManager *manager = [self manager:isHTTPRequestSerializer isHTTPResponseSerializer:isHTTPResponseSerializer];
    
    MBProgressHUD *hud = [self hud:graceTime];
    
    NSURLSessionDataTask *requst = [manager POST:fullUrl parameters:request progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSError *error = nil;

//        NSDictionary *respose = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&error];
        NSLog(@"\nabsoluteUrl: %@\n errorInfos:%@\n",task.response.URL.absoluteString,error);
        NSLog(@"respose>>>>>>>%@",responseObject);
        [hud hideAnimated:YES];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;// 关闭网络指示器
        if ([[responseObject objectForKey:@"msg"] isEqualToString:@"签名验证失败"]) {
             [MyUserInfo saveInfoForkey:@"youke" value:nil];
             [MyUserInfo clearUserInfo];
             [MyUserInfo saveInfoForkey:@"vpnxianlu" value:@"guonei"];
             [kAppDelegate setupLoginViewController];
            return ;
        }
        
        success(responseObject,task);

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        

        [hud hideAnimated:YES];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;// 关闭网络指示器
        if (failure) {
            kAppDelegate.isGUONEI = !kAppDelegate.isGUONEI;
            failure(error,task);
        }
        NSLog(@"\nabsoluteUrl: %@\n params:%@\n errorInfos:%@\n\n",task.response.URL.absoluteString,parameters,error);
    }];
    
    return requst;
}


#pragma mark - 私有方法


+(AFHTTPSessionManager *)sharedHTTPSession{
    static AFHTTPSessionManager *manager ;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [AFHTTPSessionManager manager];
    });
    return manager;
}


+ (AFHTTPSessionManager *)manager:(BOOL)isHTTPRequestSerializer
                  isHTTPResponseSerializer:(BOOL)isHTTPResponseSerializer{
    
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    AFHTTPSessionManager *manager = [self sharedHTTPSession];
    [AFNetworkActivityIndicatorManager sharedManager].enabled =[self isNetworkConnect];

     //默认的解析格式（[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", nil]）
     //如果解析格式不足自行添加
     manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json", @"text/json", @"text/javascript",@"text/html", @"text/plain",@"application/atom+xml",@"application/xml",@"text/xml", @"image/*"]];

      //网络安全证书验证Https
//    manager.securityPolicy=[AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
      // 是否允许,NO-- 不允许无效的证书
//    [securityPolicy setAllowInvalidCertificates:YES];
      // 设置证书
//    NSString *urlString = @"https://www.example.com/app/publicRequest";
//    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"https" ofType:@"cer"];
//    NSData * certData =[NSData dataWithContentsOfFile:cerPath];
//    NSSet * certSet = [[NSSet alloc] initWithObjects:certData, nil];
//    [securityPolicy setPinnedCertificates:certSet];

//    //AFN默认请求序列化器为HTTP类型
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
//
//    //AFN默认响应序列化器为JSON类型
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];//TypeData
//    manager.responseSerializer = [AFXMLParserResponseSerializer serializer];//TypeXML
//    manager.responseSerializer = [AFJSONResponseSerializer serializer];//TypeJSON
//    manager.responseSerializer.stringEncoding = NSUTF8StringEncoding;

/*  //用于设置一些公有的请求头信息
    // 获取UUID
    CFUUIDRef puuid = CFUUIDCreate( nil );
    CFStringRef uuidString = CFUUIDCreateString( nil, puuid );
    NSString * result = (NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, uuidString));
    CFRelease(puuid);
    CFRelease(uuidString);
    // 将cookie放入请求头
    NSLog(@"Cookie=%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"mUserDefaultsCookie"]);
     需要设置的请求头写在此处,如设置token

    [manager.requestSerializer setValue:[[NSUserDefaults standardUserDefaults]objectForKey:@"mUserDefaultsCookie"] forHTTPHeaderField:@"Cookie"];
    [manager.requestSerializer setValue:[[NSUserDefaults standardUserDefaults]objectForKey:@"oper_id"] forHTTPHeaderField:@"oper_id"];
*/
    //默认属性
    //manager.responseSerializer.stringEncoding = NSUTF8StringEncoding;
    //设置允许同时最大并发数量，过大容易出问题
//    manager.operationQueue.maxConcurrentOperationCount = 4;
    //统一设置请求超时
    manager.requestSerializer.timeoutInterval = 15;
    
    return manager;
}


+ (MBProgressHUD *)hud:(NetworkRequestGraceTimeType)graceTimeType{
    NSTimeInterval graceTime = 0;
    switch (graceTimeType) {
        case NetworkRequestGraceTimeTypeNone:
            return nil;
            break;
        case NetworkRequestGraceTimeTypeNormal:
            graceTime = 0.5;
            break;
        case NetworkRequestGraceTimeTypeLong:
            graceTime = 1.0;
            break;
        case NetworkRequestGraceTimeTypeShort:
            graceTime = 0.1;
            break;
        case NetworkRequestGraceTimeTypeAlways:
            graceTime = 0;
            break;
    }
    
    MBProgressHUD *hud = [self hud];
    [kLastWindow addSubview:hud];
    hud.graceTime = graceTime;
    [hud showAnimated:YES];
    
    return hud;
}

// 网络请求频率很高，不必每次都创建\销毁一个hud，只需创建一个反复使用即可
+ (MBProgressHUD *)hud{
    MBProgressHUD *hud = objc_getAssociatedObject(self, _cmd);
    
    if (!hud) {
        // 参数kLastWindow仅仅是用到了其CGFrame，并没有将hud添加到上面
        hud = [[MBProgressHUD alloc] initWithView:kLastWindow];
        hud.label.text = @"加载中...";
        objc_setAssociatedObject(self, _cmd, hud, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return hud;
}

static BOOL _networkReachability;
// 开启网络检测
+ (void)openNetworkCheckReachability{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager startMonitoring];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWiFi:
            case AFNetworkReachabilityStatusReachableViaWWAN:
                _networkReachability = YES;
                break;
            default:
                _networkReachability = NO;
                break;
        }
    }];
}

+ (void)load{
    [self openNetworkCheckReachability];
}


- (NSString*)getActionNameFromUrl:(NSString*)url{
    NSArray *arr = [url componentsSeparatedByString:@"/"];
    if (!arr || arr.count == 0) {
        return nil;
    }
    return [arr lastObject];
}


/**
 *  获取网络连接
 *
 *  @return <#return value description#>
 */
+(BOOL)isNetworkConnect
{
#if (defined(__IPHONE_OS_VERSION_MIN_REQUIRED) && __IPHONE_OS_VERSION_MIN_REQUIRED >= 90000) || (defined(__MAC_OS_X_VERSION_MIN_REQUIRED) && __MAC_OS_X_VERSION_MIN_REQUIRED >= 101100)
    struct sockaddr_in6 address;
    bzero(&address, sizeof(address));
    address.sin6_len = sizeof(address);
    address.sin6_family = AF_INET6;
#else
    struct sockaddr_in address;
    bzero(&address, sizeof(address));
    address.sin_len = sizeof(address);
    address.sin_family = AF_INET;
#endif
    //    struct sockaddr zeroAddress;
    //    bzero(&zeroAddress, sizeof(zeroAddress));
    //    zeroAddress.sa_len = sizeof(zeroAddress);
    //    zeroAddress.sa_family = AF_INET;
    SCNetworkReachabilityRef defaultRouteReachability =
    SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&address);
    SCNetworkReachabilityFlags flags;
    BOOL didRetrieveFlags =
    SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    if (!didRetrieveFlags) {
        printf("Error. Count not recover network reachability flags\n");
        return NO;
    }
    BOOL isReachable = flags & kSCNetworkFlagsReachable;
    BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
    BOOL isNetworkEnable  =(isReachable && !needsConnection) ? YES : NO;
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIApplication sharedApplication].networkActivityIndicatorVisible =isNetworkEnable;/*  网络指示器的状态： 有网络 ： 开  没有网络： 关  */
    });
    return isNetworkEnable;
}


@end
