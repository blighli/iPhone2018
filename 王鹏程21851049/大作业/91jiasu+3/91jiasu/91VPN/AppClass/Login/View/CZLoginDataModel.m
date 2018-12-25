//
//  CZLoginDataModel.m
//  91加速
//
//  Created by weichengzong on 2017/8/18.
//  Copyright © 2017年 weichengzong. All rights reserved.
//

#import "CZLoginDataModel.h"

@implementation CZLoginDataModel


- (void)denglu:(NSString *)name
             password:(NSString *)password
             complete:(void (^)(CZLoginDataModel *result))complete
                error:(void(^)(NSDictionary* err))errorHandle{
    
    CZLoginDataRequestModel *request=[[CZLoginDataRequestModel alloc]init];
    request.username = name;
    request.password = password;
    NSString *uuid = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    NSString *uuidStr = [uuid stringByReplacingOccurrencesOfString:@"-" withString:@""];
    request.device_id = uuidStr;
    [AFNetInterFaceManager Post:LoginAPI hostUrl:A_Address parameters:request success:^(NSDictionary *response, NSURLSessionDataTask *task) {
        NSDictionary *dict = (NSDictionary*)response;
        NSError *error;
        CZLoginDataModel *result = [[CZLoginDataModel alloc]initWithDictionary:dict error:&error];
        NSLog(@"Category Error: %@", [error localizedDescription]);
        if (result && complete) {
            complete(result);
        }
    } failure:^(NSError *error, NSURLSessionDataTask *task) {
        NSDictionary *dic;
        errorHandle(dic);
    }];
}
//+ (RACSignal *)singalForVerifyCodeWith:(NSString *)phoneNummber{
//    RACReplaySubject *subject = [RACReplaySubject subject];
//    
//    
//    
//}



+ (RACSignal *)singalForLogin:(NSString *)name
                     password:(NSString *)password{
    RACReplaySubject *subject = [RACReplaySubject subject];
    CZLoginDataRequestModel *request=[[CZLoginDataRequestModel alloc]init];
    request.username = name;
    request.password = password;
    NSString *uuid = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    NSString *uuidStr = [uuid stringByReplacingOccurrencesOfString:@"-" withString:@""];
    request.device_id = uuidStr;
    [AFNetInterFaceManager Post:LoginAPI hostUrl:A_Address parameters:request success:^(NSDictionary *response, NSURLSessionDataTask *task) {
        NSDictionary *dict = (NSDictionary*)response;
        NSError *error;
        CZLoginDataModel *result = [[CZLoginDataModel alloc]initWithDictionary:dict error:&error];
        NSLog(@"Category Error: %@", [error localizedDescription]);
        if (result.status.integerValue==0000) {
        }else{
            [MyUserInfo clearUserInfo];
        }
        [subject sendNext:result];
        [subject sendCompleted];
    } failure:^(NSError *error, NSURLSessionDataTask *task) {
        [subject sendError:error];
    }];
    return subject;
}
///游客登录
+ (RACSignal *)singalForYoukeLogin{
    RACReplaySubject *subject = [RACReplaySubject subject];
    [AFNetInterFaceManager Post:visitorAPI hostUrl:A_Address parameters:nil success:^(NSDictionary *response, NSURLSessionDataTask *task) {
        [MyUserInfo saveInfoForkey:@"youke" value:[response objectForKey:@""]];
        [[self singalForLogin:[response objectForKey:@"username"] password:[response objectForKey:@"password"]] subscribeNext:^(id  _Nullable x) {
            [subject sendNext:x];
            [subject sendCompleted];
        }error:^(NSError * _Nullable error) {
            [subject sendError:error];
        }];
    } failure:^(NSError *error, NSURLSessionDataTask *task) {
        [subject sendError:error];
    }];
    
    return subject;
}
@end


@implementation CZLoginDataRequestModel
@end
