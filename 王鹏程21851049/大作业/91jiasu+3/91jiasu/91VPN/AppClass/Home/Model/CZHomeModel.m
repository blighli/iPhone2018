//
//  CZHomeModel.m
//  91VPN
//
//  Created by weichengzong on 2017/8/20.
//  Copyright © 2017年 weichengzong. All rights reserved.
//

#import "CZHomeModel.h"

@implementation CZHomeModel
- (void)huoqulist:(NSString *)token
         complete:(void (^)(NSDictionary *result))complete
            error:(void(^)(NSDictionary* err))errorHandle{
    CZHomeRequestModel *request=[[CZHomeRequestModel alloc]init];
    request.token = token;
    request.sys_type = @"ios";
    [AFNetInterFaceManager Post:getallserverAPI parameters:request success:^(NSDictionary *response, NSURLSessionDataTask *task) {
        NSDictionary *dict = (NSDictionary*)response;
        complete(dict);
        
    } failure:^(NSError *error, NSURLSessionDataTask *task) {
        NSDictionary *dic;
        errorHandle(dic);
    }];
}
- (void)huoqutaocanlist:(NSString *)token
               complete:(void (^)(CZHomeModel *result))complete{
    CZHomeRequestModel *request=[[CZHomeRequestModel alloc]init];
    request.token = token;
//    request.type = @"debug";
    [AFNetInterFaceManager Post:GETPlabAPI parameters:request success:^(NSDictionary *response, NSURLSessionDataTask *task) {
        NSDictionary *dict = (NSDictionary*)response;
        NSError *error;
        CZHomeModel *result = [[CZHomeModel alloc]initWithDictionary:dict error:&error];
        NSLog(@"Category Error: %@", [error localizedDescription]);
        if (result && complete) {
            complete(result);
        }
        
    } failure:^(NSError *error, NSURLSessionDataTask *task) {
        
    }];
}
- (void)huoqukefu:(NSString *)token
         complete:(void (^)(CZHomeModel *result))complete{
    [AFNetInterFaceManager Post:GETServiceAPI hostUrl:A_Address parameters:nil success:^(NSDictionary *response, NSURLSessionDataTask *task) {
        NSDictionary *dict = (NSDictionary*)response;
        NSError *error;
        CZHomeModel *result = [[CZHomeModel alloc]initWithDictionary:dict error:&error];
        NSLog(@"Category Error: %@", [error localizedDescription]);
        if (result && complete) {
            complete(result);
        }
    } failure:^(NSError *error, NSURLSessionDataTask *task) {
        
    }];
}
- (void)getUserinfo:(NSString *)token
           complete:(void (^)(NSDictionary *result))complete{
    CZHomeRequestModel *request=[[CZHomeRequestModel alloc]init];
    request.token = token;
    [AFNetInterFaceManager Post:GETUserInfo parameters:request success:^(NSDictionary *response, NSURLSessionDataTask *task) {
        NSDictionary *dict = (NSDictionary*)response;
        if (dict) {
            complete(dict);
        }
    } failure:^(NSError *error, NSURLSessionDataTask *task) {
        
    }];
}
- (void)getCertcomplete:(void (^)(NSDictionary *result))complete  error:(void(^)(NSDictionary* err))errorHandle{
    [AFNetInterFaceManager Post:GETCertAPI hostUrl:A_Address parameters:nil success:^(NSDictionary *response, NSURLSessionDataTask *task) {
        NSDictionary *dict = (NSDictionary*)response;
        complete(dict);
    } failure:^(NSError *error, NSURLSessionDataTask *task) {
        NSDictionary *dic;
        errorHandle(dic);
    }];
}
- (void)isopay:(void (^)(BOOL result))complete{
    [AFNetInterFaceManager Post:getiOSversionAPI hostUrl:A_Address parameters:nil success:^(NSDictionary *response, NSURLSessionDataTask *task) {
        NSString *staStr = [NSString stringWithFormat:@"%@",[response objectForKey:@"status"]];
        if (staStr.integerValue==0000) {
            CGFloat afversion = [[response objectForKey:@"data"] floatValue];
            NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
            NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
            if ([app_Version floatValue]<afversion) {
                complete(YES);
            }else{
                complete(NO);
            }
        }else{
            complete(YES);
        }
    } failure:^(NSError *error, NSURLSessionDataTask *task) {
        complete(NO);
    }];
}

@end


@implementation CZHomeRequestModel

@end
