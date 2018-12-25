//
//  CZPingManager.m
//  pingping
//
//  Created by weichengzong on 2017/8/28.
//  Copyright © 2017年 weichengzong. All rights reserved.
//

#import "CZPingManager.h"
#import "CZPingServices.h"

@implementation CZPingManager


+ (void)getFastestAddress:(NSArray *)addressList finished:(void (^)(NSString *ipAddress))ipAddress{
    if (addressList.count==0) {
        NSLog(@"ip地址列表不能为空");
        return;
    }
    NSMutableArray *hostList = [[NSMutableArray alloc] init];
    
    //创建任务组
    dispatch_group_t group = dispatch_group_create();
    for (NSString *address in addressList) {
        dispatch_group_enter(group);
//        [CZPingServices startWithHostName:address count:2 pingCallback:^(NSArray *arr) {
//            [hostList addObject:arr];
//            dispatch_group_leave(group);
//        }];

        [[self class] gettimeaddress:address block:^(NSArray* timeNum){
            NSLog(@"--------------------%@",timeNum);
            [hostList addObject:timeNum];
            dispatch_group_leave(group);
        }];

    }
    // 任务执行完毕再计算平均ping值
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
       NSLog(@"计算延迟");
        if (hostList.count<=0) {
            return ;
        }
        NSLog(@"%@",hostList);
        NSString *fastestAddress = [addressList lastObject];
        int max = 1000;
       
        for (NSArray *arr in hostList) {
            if ([[arr lastObject] intValue]>0) {
                if ([[arr lastObject] intValue]<max) {
                    max = [[arr lastObject] intValue];
                    fastestAddress = [arr firstObject];
                }
            }
        }
        ipAddress(fastestAddress);
    });

}


+(void)gettimeaddress:(NSString *)url block:(void(^)(NSArray*))blocktime{
    NSMutableArray *dadic = [[NSMutableArray alloc] init];
    [dadic addObject:url];
    NSString *urlStr = [NSString stringWithFormat:@"http://%@/t.htm",url];
    NSMutableArray *daArr = [[NSMutableArray alloc] init];
    //创建任务组
    dispatch_group_t numgroup = dispatch_group_create();
    for (int i=0;i<3;i++) {
        dispatch_group_enter(numgroup);
        CFAbsoluteTime startTime =CFAbsoluteTimeGetCurrent();
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"text/plain",@"text/html"]];
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        manager.requestSerializer.timeoutInterval = 5;
        [manager GET:urlStr parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            NSLog(@"progress--%@--",downloadProgress);
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"success--%@--%@",[responseObject class],responseObject);
            CFAbsoluteTime linkTime = (CFAbsoluteTimeGetCurrent() - startTime);
            NSLog(@"Linked in %f ms", linkTime *1000.0);
            [daArr addObject:@(linkTime *1000.0)];
            dispatch_group_leave(numgroup);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"failure--%@",error);
            CFAbsoluteTime linkTime = (CFAbsoluteTimeGetCurrent() - startTime);
            [daArr addObject:@(1000.0)];
            NSLog(@"Linked in %f ms", linkTime *1000.0);
            dispatch_group_leave(numgroup);
        }];
    }
    // 任务执行完毕再计算平均ping值
    dispatch_group_notify(numgroup, dispatch_get_main_queue(), ^{
        NSLog(@"计算延迟");
        if (daArr.count<=0) {
            return ;
        }
        NSLog(@"%@",daArr);
        CGFloat max = 0.0;
        for (int i=0; i<3; i++) {
            max = max + [[daArr objectAtIndex:i] floatValue];
        }
        CGFloat maxnum = max/daArr.count;
        [dadic addObject:@(maxnum)];
        blocktime(dadic);
    });
    
    
    
    

}
@end
