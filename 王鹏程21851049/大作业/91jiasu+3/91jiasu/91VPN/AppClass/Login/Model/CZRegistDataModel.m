//
//  CZRegistDataModel.m
//  91VPN
//
//  Created by weichengzong on 2017/8/19.
//  Copyright © 2017年 weichengzong. All rights reserved.
//

#import "CZRegistDataModel.h"

@implementation CZRegistDataModel

//注册验证账号
- (void)postYanzhenPhone:(NSString *)account
                complete:(void (^)(CZRegistDataModel *result))complete
                   error:(void(^)(NSDictionary* err))errorHandle{
    CZRegistDataRequestModel *request=[[CZRegistDataRequestModel alloc]init];
    request.account = account;
    request.type = @"username";
    
    [AFNetInterFaceManager Post:CheckAccountAPI hostUrl:A_Address parameters:request success:^(NSDictionary *response, NSURLSessionDataTask *task) {
        NSDictionary *dict = (NSDictionary*)response;
        NSError *error;
        CZRegistDataModel *result = [[CZRegistDataModel alloc]initWithDictionary:dict error:&error];
        NSLog(@"Category Error: %@", [error localizedDescription]);
        if (result && complete) {
            complete(result);
        }
    } failure:^(NSError *error, NSURLSessionDataTask *task) {
        NSDictionary *dic;
        errorHandle(dic);
    }];
    
}
//注册获取验证码
- (void)huoquyanzhengma:(NSString *)account
               complete:(void (^)(CZRegistDataModel *result))complete
                  error:(void(^)(NSDictionary* err))errorHandle{
    CZRegistDataRequestModel *request=[[CZRegistDataRequestModel alloc]init];
    request.account = account;
    if ([Util isPhoneNumber:account]) {
       request.type = @"mobile";
    }else if ([Util isValidateEmail:account]){
        request.type = @"email";
    }
    request.action = @"member";
    request.kind = @"regist";
    
    [AFNetInterFaceManager Post:SendAppVerifyAPI hostUrl:A_Address parameters:request success:^(NSDictionary *response, NSURLSessionDataTask *task) {
        NSDictionary *dict = (NSDictionary*)response;
        NSError *error;
        CZRegistDataModel *result = [[CZRegistDataModel alloc]initWithDictionary:dict error:&error];
        NSLog(@"Category Error: %@", [error localizedDescription]);
        if (result && complete) {
            complete(result);
        }
    } failure:^(NSError *error, NSURLSessionDataTask *task) {
        NSDictionary *dic;
        errorHandle(dic);
    }];
}

//注册账号
- (void)zhucezhanghao:(NSString *)account
                  pwd:(NSString *)onepwd
           repassword:(NSString *)twopwd
           reg_verify:(NSString *)reg_verify
             complete:(void (^)(CZRegistDataModel *result))complete
                error:(void(^)(NSDictionary* err))errorHandle{
    CZRegistDataRequestModel *request=[[CZRegistDataRequestModel alloc]init];
    request.username = account;
    request.password = onepwd;
    request.repassword = twopwd;
    request.verify = @"";
    
    if ([Util isPhoneNumber:account]) {
        request.reg_type = @"mobile";
    }else if ([Util isValidateEmail:account]){
        request.reg_type = @"email";
    }
    request.role = @"1";
    request.reg_verify = reg_verify;
    
    [AFNetInterFaceManager Post:RegistAPI hostUrl:A_Address parameters:request success:^(NSDictionary *response, NSURLSessionDataTask *task) {
        NSDictionary *dict = (NSDictionary*)response;
        NSError *error;
        CZRegistDataModel *result = [[CZRegistDataModel alloc]initWithDictionary:dict error:&error];
        NSLog(@"Category Error: %@", [error localizedDescription]);
        if (result && complete) {
            complete(result);
        }
    } failure:^(NSError *error, NSURLSessionDataTask *task) {
        NSDictionary *dic;
        errorHandle(dic);
    }];

}
//修改密码获取验证码
- (void)xiugaimimacode:(NSString *)account
              complete:(void (^)(CZRegistDataModel *result))complete{
    CZRegistDataRequestModel *request=[[CZRegistDataRequestModel alloc]init];
    request.account = account;
    
    request.action = @"member";
    request.kind = @"change";
    if ([Util isPhoneNumber:account]) {
        request.type = @"mobile";
    }else if ([Util isValidateEmail:account]){
        request.type = @"email";
    }
    
    [AFNetInterFaceManager Post:SendAppChangeVerifyAPI hostUrl:A_Address parameters:request success:^(NSDictionary *response, NSURLSessionDataTask *task) {
        NSDictionary *dict = (NSDictionary*)response;
        NSError *error;
        CZRegistDataModel *result = [[CZRegistDataModel alloc]initWithDictionary:dict error:&error];
        NSLog(@"Category Error: %@", [error localizedDescription]);
        if (result && complete) {
            complete(result);
        }
    } failure:^(NSError *error, NSURLSessionDataTask *task) {
    }];
}
- (void)xiugaiyanzhengcode:(NSString *)account
                reg_verify:(NSString *)reg_verify
                  complete:(void (^)(CZRegistDataModel *result))complete{
    CZRegistDataRequestModel *request=[[CZRegistDataRequestModel alloc]init];
    request.username = account;
    
    if ([Util isPhoneNumber:account]) {
        request.reg_type = @"mobile";
    }else if ([Util isValidateEmail:account]){
        request.reg_type = @"email";
    }
    
    request.reg_verify = reg_verify;    
    [AFNetInterFaceManager Post:CheckAppVerifyAPI hostUrl:A_Address parameters:request success:^(NSDictionary *response, NSURLSessionDataTask *task) {
        NSDictionary *dict = (NSDictionary*)response;
        NSError *error;
        CZRegistDataModel *result = [[CZRegistDataModel alloc]initWithDictionary:dict error:&error];
        NSLog(@"Category Error: %@", [error localizedDescription]);
        if (result && complete) {
            complete(result);
        }
    } failure:^(NSError *error, NSURLSessionDataTask *task) {

    }];
}
- (void)xiugaimima:(NSString *)account
             pwd:(NSString *)pwd
             re_pwd:(NSString *)repwd
          complete:(void (^)(CZRegistDataModel *result))complete{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:account forKey:@"username"];
    [dic setObject:pwd forKey:@"new_password"];
    [dic setObject:repwd forKey:@"new_re_password"];
    [AFNetInterFaceManager Post:ChangepasswordAppAPI hostUrl:A_Address parameters:dic success:^(NSDictionary *response, NSURLSessionDataTask *task) {
        NSDictionary *dict = (NSDictionary*)response;
        NSError *error;
        CZRegistDataModel *result = [[CZRegistDataModel alloc]initWithDictionary:dict error:&error];
        NSLog(@"Category Error: %@", [error localizedDescription]);
        if (result && complete) {
            complete(result);
        }
    } failure:^(NSError *error, NSURLSessionDataTask *task) {
        
    }];
}
@end

@implementation CZRegistDataRequestModel


@end
