//
//  CZRegistDataModel.h
//  91VPN
//
//  Created by weichengzong on 2017/8/19.
//  Copyright © 2017年 weichengzong. All rights reserved.
//

#import <JSONModel/JSONModel.h>


@interface CZRegistDataModel : JSONModel

@property (nonatomic, strong) NSString<Optional> *msg;
@property (nonatomic, strong) NSString<Optional> *status;

- (void)postYanzhenPhone:(NSString *)account
                complete:(void (^)(CZRegistDataModel *result))complete
                error:(void(^)(NSDictionary* err))errorHandle;


- (void)huoquyanzhengma:(NSString *)account
               complete:(void (^)(CZRegistDataModel *result))complete
                  error:(void(^)(NSDictionary* err))errorHandle;

- (void)zhucezhanghao:(NSString *)account
                  pwd:(NSString *)onepwd
           repassword:(NSString *)twopwd
           reg_verify:(NSString *)reg_verify
             complete:(void (^)(CZRegistDataModel *result))complete
                error:(void(^)(NSDictionary* err))errorHandle;

- (void)xiugaimimacode:(NSString *)account
              complete:(void (^)(CZRegistDataModel *result))complete;
- (void)xiugaiyanzhengcode:(NSString *)account
                reg_verify:(NSString *)reg_verify
                  complete:(void (^)(CZRegistDataModel *result))complete;
- (void)xiugaimima:(NSString *)account
                pwd:(NSString *)pwd
            re_pwd:(NSString *)repwd
                  complete:(void (^)(CZRegistDataModel *result))complete;
@end


@interface CZRegistDataRequestModel : JSONModel
@property (nonatomic, strong) NSString *account;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *action;
@property (nonatomic, strong) NSString *kind;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *repassword;
@property (nonatomic, strong) NSString *verify;
@property (nonatomic, strong) NSString *reg_type;
@property (nonatomic, strong) NSString *role;
@property (nonatomic, strong) NSString *reg_verify;
@property (nonatomic, strong) NSString *ew_password1;
@property (nonatomic, strong) NSString *ew_re_password1;
@end

