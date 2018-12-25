//
//  CZHomeModel.h
//  91VPN
//
//  Created by weichengzong on 2017/8/20.
//  Copyright © 2017年 weichengzong. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface CZHomeModel : JSONModel
@property (nonatomic, strong) NSString *msg;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSArray *data;

- (void)huoqulist:(NSString *)token
          complete:(void (^)(NSDictionary *result))complete
            error:(void(^)(NSDictionary* err))errorHandle;


- (void)Gethuoqutaocanlist:(NSString *)token
         complete:(void (^)(CZHomeModel *result))complete;
- (void)huoqukefu:(NSString *)token
               complete:(void (^)(CZHomeModel *result))complete;
- (void)getUserinfo:(NSString *)token
         complete:(void (^)(NSDictionary *result))complete;

- (void)getCertcomplete:(void (^)(NSDictionary *result))complete
                   error:(void(^)(NSDictionary* err))errorHandle;

- (void)isopay:(void (^)(BOOL result))complete;
@end


@interface CZHomeRequestModel : JSONModel
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *sys_type;
@property (nonatomic, strong) NSString *type;
@end
