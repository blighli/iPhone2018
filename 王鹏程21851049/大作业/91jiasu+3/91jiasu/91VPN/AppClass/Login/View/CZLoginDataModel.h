//
//  CZLoginDataModel.h
//  91加速
//
//  Created by weichengzong on 2017/8/18.
//  Copyright © 2017年 weichengzong. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface CZLoginDataModel : JSONModel
@property (nonatomic, strong) NSString<Optional> *has;
@property (nonatomic, strong) NSString<Optional> *msg;
@property (nonatomic, strong) NSString<Optional> *token;
@property (nonatomic, strong) NSString<Optional> *status;
@property (nonatomic, strong) NSString<Optional> *data;
- (void)denglu:(NSString *)name
             password:(NSString *)password
             complete:(void (^)(CZLoginDataModel *result))complete
                error:(void(^)(NSDictionary* err))errorHandle;
///游客登录
+ (RACSignal *)singalForYoukeLogin;
///发送验证码
+ (RACSignal *)singalForVerifyCodeWith:(NSString *)phoneNummber;


@end


@interface CZLoginDataRequestModel : JSONModel
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *password;
@property (nonatomic ,strong) NSString *device_id;

@end
