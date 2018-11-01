//
//  JudgeNumberRegex.m
//  Cal_OC
//
//  Created by Xia Wei on 2018/10/23.
//  Copyright © 2018 Xia Wei. All rights reserved.
//

#import "JudgeNumberRegex.h"

@implementation JudgeNumberRegex

- (BOOL) isNumber:(NSString*)str{
    
    //匹配数字字符串的正则表达式；
    NSString *numberRegex = @"^[0-9]+$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", numberRegex];
    BOOL isMatch = [pred evaluateWithObject:str];
    
    if (isMatch) {
        return true;
    } else {
        
        return false;
    }
}

@end
