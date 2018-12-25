//
//  CZPingManager.h
//  pingping
//
//  Created by weichengzong on 2017/8/28.
//  Copyright © 2017年 weichengzong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CZPingManager : NSObject


+ (void)getFastestAddress:(NSArray *)addressList finished:(void (^)(NSString *ipAddress))ipAddress;
@end
