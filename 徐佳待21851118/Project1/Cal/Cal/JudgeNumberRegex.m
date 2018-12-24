//
//  JudgeNumberRegex.m
//  Cal
//
//  Created by xujiadai on 18/10/24.
//  Copyright © 2018年 xujiadai. All rights reserved.
//

#import "JudgeNumberRegex.h"

@implementation JudgeNumberRegex

- (BOOL) isNumber:(NSString*)str{
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
