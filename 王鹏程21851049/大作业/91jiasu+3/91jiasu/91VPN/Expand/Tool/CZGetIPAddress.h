//
//  CZGetIPAddress.h
//  91VPN
//
//  Created by weichengzong on 2017/11/13.
//  Copyright © 2017年 weichengzong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CZGetIPAddress : NSObject


+ (NSString *)getIPAddress:(BOOL)preferIPv4;
@end
