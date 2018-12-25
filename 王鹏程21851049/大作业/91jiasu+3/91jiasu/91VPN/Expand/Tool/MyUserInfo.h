//
//  MyUserInfo.h
//  GoPanda
//
//  Created by wangpengfei on 15/12/31.
//  Copyright © 2015年 wangpengfei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyUserInfo : NSObject



#define SHInvokerUserInfouser_name @"user_name" //电话
#define SHInvokerUserInfouser_pwd @"user_pwd" //
#define SHInvokerUserInforuser_token @"token"

#define SHInvokerUserInforuser_nickname @"nickname"
#define SHInvokerUserInforuser_exdate @"exdate"
#define SHInvokerUserInforuser_mobile @"mobile"
#define SHInvokerUserInforuser_message @"message"

+(void)saveUserInfo:(NSDictionary *)userinfo;
+ (NSDictionary*)getUserInfo ;
+ (void)clearUserInfo;

+ (BOOL)isLogined;

+ (NSString *)currentVersionString;

+ (void)denglu;

+ (void)saveInfoForkey:(NSString *)key value:(NSString *)value;

+ (NSString*)getInfoForkey:(NSString *)key;
@end
