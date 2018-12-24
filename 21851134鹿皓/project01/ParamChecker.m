//
//  ParamChecker.m
//  Cal
//
//  Created by dawn on 2018/10/20.
//  Copyright © 2018 dawn. All rights reserved.
//

#import "ParamChecker.h"

@implementation ParamChecker


-(BOOL)isCal:(NSString*) arg {
    NSString *p = @"cal";
    return [p compare: arg];
}

-(BOOL)isNumber:(NSString*) arg {
    arg = [arg stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    return arg.length == 0;
}

-(BOOL)is_M:(NSString*) arg {
    NSString *p = @"-m";
    return [p compare: arg];
}

@end
