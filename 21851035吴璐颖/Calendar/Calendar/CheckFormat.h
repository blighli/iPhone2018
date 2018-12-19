//
//  CheckFormat.h
//  Calendar
//
//  Created by wuluying on 2018/10/22.
//  Copyright © 2018年 wuluying. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CheckFormat : NSObject
{
    
}
+ (bool)is_Cal:(NSString *)str;
+ (bool)is_M:(NSString *)str;
+ (bool)is_Num:(NSString *)str;
+ (bool)is_Month:(NSString *)str;

@end
