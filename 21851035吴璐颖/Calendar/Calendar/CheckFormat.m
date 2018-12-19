//
//  CheckFormat.m
//  Calendar
//
//  Created by wuluying on 2018/10/22.
//  Copyright © 2018年 wuluying. All rights reserved.
//

#import "CheckFormat.h"
@implementation CheckFormat

+ (bool)is_Cal:(NSString *)str {
    NSString *calRegex = @"cal";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF == %@", calRegex];
    if ([predicate evaluateWithObject:str]) {
        return true;
    }
    else {
        return false;
    }
}

+ (bool)is_M:(NSString *)str {
    NSString *calRegex = @"-m";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF == %@", calRegex];
    if ([predicate evaluateWithObject:str]) {
        return true;
    }
    else {
        return false;
    }
}

+ (bool)is_Num:(NSString *)str {
    NSString *yearRegex = @"^[0-9]+$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", yearRegex];
    if ([predicate evaluateWithObject:str]) {
        return true;
    }
    else {
        return false;
    }
}

+ (bool)is_Month:(NSString *)str {
    if ([CheckFormat is_Num:str]) {
        NSInteger num = [str integerValue];
        if (num > 0 && num < 13) {
            return true;
        }
    }
    return false;
}

@end
