//
//  CZPingServices.h
//  pingping
//
//  Created by weichengzong on 2017/8/28.
//  Copyright © 2017年 weichengzong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SimplePing.h"


@interface CZPingServices : NSObject



+ (CZPingServices *)startWithHostName:(NSString * )hostName count:(NSInteger)count pingCallback:(void (^)(NSArray *arr))pingCallback;

@end
