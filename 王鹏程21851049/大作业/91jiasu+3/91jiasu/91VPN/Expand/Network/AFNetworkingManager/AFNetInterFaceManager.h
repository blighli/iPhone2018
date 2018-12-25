//
//  AFNetInterFaceManager.h
//
//  Created by weichengzong on 17/7/14.
//  Copyright © 2017年 weichengzong. All rights reserved.
//

#import <Foundation/Foundation.h>

// 网络提示框的出现时机，若干秒后网络数据还未返回则出现提示框
typedef NS_ENUM(NSUInteger, NetworkRequestGraceTimeType){
    NetworkRequestGraceTimeTypeNormal,  // 0.5s  延时普通的，0.5s内网络数据未返回才出现提示框
    NetworkRequestGraceTimeTypeLong,    // 1s    延时长的，1s内网络数据未返回才出现提示框
    NetworkRequestGraceTimeTypeShort,   // 0.1s  延时短的，0.1s内网络数据未返回才出现提示框
    NetworkRequestGraceTimeTypeNone,    // 没有提示框
    NetworkRequestGraceTimeTypeAlways   // 总是有提示框
};


typedef void(^successBlock)(NSDictionary * response, NSURLSessionDataTask *task);
typedef void(^failureBlock)(NSError *error,NSURLSessionDataTask *task);

@interface AFNetInterFaceManager : NSObject


//+(AFNetInterFaceManager *)sharedManager;

// 是否有网络
+ (BOOL)hasNetworkReachability;


/**
 *  GET请求一般常用方法
 *
 *  @param urlStr                  网络请求的url
 *  @param parameters              请求体参数
 *
 *  @return                        状态为isReady的当前操作AFHTTPRequestOperation
 */
+ (NSURLSessionDataTask *)Get:(NSString *)urlStr
                     parameters:(id)parameters
                        success:(successBlock)success
                        failure:(failureBlock)failure;
/**
 *  GET请求一般常用方法
 *
 *  @param urlStr                  网络请求的url
 *  @param parameters              请求体参数
 **  @param graceTime              网络提示框是否出现\什么时候出现枚举
 *
 *  @return                        状态为isReady的当前操作AFHTTPRequestOperation
 */
+ (NSURLSessionDataTask *)Get:(NSString *)urlStr
                   parameters:(id)parameters
                    graceTime:(NetworkRequestGraceTimeType)graceTime
                      success:(successBlock)success
                      failure:(failureBlock)failure;
/**
 *  GET请求目标方法
 *
 *  @param urlStr                   网络请求的url
 *  @param parameters               请求体参数
 *  @param graceTime                网络提示框是否出现\什么时候出现枚举
 *  @param isHTTPRequestSerializer  YES代表是HTTP请求序列化器，NO代表是JSON请求序列化器
 *  @param isHTTPResponseSerializer YES代表是HTTP响应序列化器，NO代表是JSON响应序列化器
 *  @param success                  请求成功回调
 *  @param failure                  请求失败回调
 *
 *  @return 状态为isReady的当前操作AFHTTPRequestOperation
 */
+ (NSURLSessionDataTask *)Get:(NSString *)urlStr
                     parameters:(id)parameters
                      graceTime:(NetworkRequestGraceTimeType)graceTime
        isHTTPRequestSerializer:(BOOL)isHTTPRequestSerializer
       isHTTPResponseSerializer:(BOOL)isHTTPResponseSerializer
                        success:(successBlock)success
                        failure:(failureBlock)failure;

+ (NSURLSessionDataTask *)Post:(NSString *)urlStr
                       hostUrl:(NSString *)hostUrl
                    parameters:(id)parameters
                       success:(successBlock)success
                       failure:(failureBlock)failure;
/**
 *  POST请求一般常用方法 提示框默认延迟0.5s
 *
 *  @param urlStr                   网络请求的url
 *  @param parameters               请求体参数
 *  @param success                  请求成功回调
 *  @param failure                  请求失败回调
 */
+ (NSURLSessionDataTask *)Post:(NSString *)urlStr
                    parameters:(id)parameters
                       success:(successBlock)success
                       failure:(failureBlock)failure;

/**
 *  POST请求常用方法 提示框设置
 *
 *  @param urlStr                   网络请求的url
 *  @param parameters               请求体参数
 *  graceTime                       网络提示框是否出现\什么时候出现枚举
 *  @param success                  请求成功回调
 *  @param failure                  请求失败回调
 */
+ (NSURLSessionDataTask *)Post:(NSString *)urlStr
                    parameters:(id)parameters
                     graceTime:(NetworkRequestGraceTimeType)graceTime
                       success:(successBlock)success
                       failure:(failureBlock)failure;

/**
 *  POST请求目标方法
 *
 *  urlStr                          网络请求的url
 *  parameters                      请求体参数
 *  isHTTPRequestSerializer         YES代表是HTTP请求序列化器，NO代表是JSON请求序列化器
 *  isHTTPResponseSerializer        YES代表是HTTP响应序列化器，NO代表是JSON响应序列化器
 *  graceTime                       网络提示框是否出现\什么时候出现枚举
 *  success                         请求成功回调
 *  failure                         请求失败回调
 *
 *  return                          状态为isReady的当前操作AFHTTPRequestOperation
 */
+ (NSURLSessionDataTask *)Post:(NSString *)urlStr
                    parameters:(id)parameters
                     graceTime:(NetworkRequestGraceTimeType)graceTime
       isHTTPRequestSerializer:(BOOL)isHTTPRequestSerializer
      isHTTPResponseSerializer:(BOOL)isHTTPResponseSerializer
                       success:(successBlock)success
                       failure:(failureBlock)failure;
+ (NSURLSessionDataTask *)Postip:(NSString *)urlStr
                         hostUrl:(NSString *)hostUrl
                      parameters:(id)parameters
                         success:(successBlock)success
                         failure:(failureBlock)failure;

@end
