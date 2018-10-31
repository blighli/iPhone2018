//
//  LTYJudgeFormat.m
//  MyCal
//
//  Created by  年少相知君莫忘 on 2018/10/23.
//  Copyright © 2018年  年少相知君莫忘. All rights reserved.
//

#import "LTYJudgeFormat.h"

@implementation LTYJudgeFormat

/*
 输入数据的合法性检验 包括是否为数字 是否在有效范围内等
 */
- (BOOL) isNumber:(NSString*) str
{
    NSString *temp = @"^[0-9]+$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", temp];
    BOOL res = [pred evaluateWithObject:str];
    return res;
    
}
- (BOOL) isMonthLegal:(int) num
{
    if(num < 1){
        return false;
    }
    else{
        if(num < 13)return true;
        else return false;
    }
}
- (BOOL) isYearLegal:(int) num
{
    if(num < 1){
        return false;
    }
    else{
        if(num < 9999)return true;
        else return false;
    }
}
- (BOOL) isLegal:(NSString *) str
{
    NSString *temp = @"-m";
    BOOL res = [temp isEqualToString:str];
    return res;
}

- (int) isLineLegal:(NSString *) str
{
    NSString *temp = @"-\\d";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", temp];
    BOOL res = [pred evaluateWithObject:str];
    if(res){
        NSString *line = [str substringFromIndex:1];
        
        int num = [line intValue];
        
        return num;
    }
    else return 0;
}
@end
