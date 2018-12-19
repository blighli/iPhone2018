//
//  XCUtilities.m
//  Calendar
//
//  Created by 徐超 on 2018/10/15.
//  Copyright © 2018 徐超. All rights reserved.
//

#import "XCUtilities.h"

@implementation XCUtilities

+ (BOOL)isPureInt:(NSString *)str {
    NSScanner* scan = [NSScanner scannerWithString:str];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}

@end
