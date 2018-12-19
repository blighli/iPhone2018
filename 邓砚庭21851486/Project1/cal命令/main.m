//
//  main.m
//  cal命令
//
//  Created by 邓砚庭 on 2018/10/23.
//  Copyright © 2018 邓砚庭21851486. All rights reserved.
//

#import "MonthCalendar.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        if(argc == 2) {
            //cal 输出当月月历
            //获取当前日期
            NSDate *dateNow = [NSDate date];
            
            NSCalendar *calendar = [NSCalendar currentCalendar];
            NSInteger year, month, day;
            [calendar getEra:nil year:&year month:&month day:&day fromDate:dateNow];
            
            MonthCalendar *monthCalendar = [[MonthCalendar alloc] initWithYear:year usingMonth:month];
            [monthCalendar printMonthCalendar];
        }
        
        else if(argc == 3) {
            //cal 2018 输出年历
            NSString *yearstr = [NSString stringWithUTF8String:argv[2]];
            //判年份合法
            if([yearstr integerValue] >= 1 && [yearstr integerValue] <= 9999) {
                for(int i = 1; i <= 12; i++) {
                    MonthCalendar *monthCalendar = [[MonthCalendar alloc] initWithYear:[yearstr intValue] usingMonth:i];
                    [monthCalendar printMonthCalendar];
                }
            }
            else {
                NSLog(@"cal: year `%d' not in range 1..9999", [yearstr intValue]);
            }
        }
        else if(argc == 4) {
            NSString *monthstr = [NSString stringWithUTF8String:argv[2]];
            
            NSString *numberRegex = @"^[0-9]+$";
            NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", numberRegex];
            //第二个输入的是月份
            BOOL isMatch = [pred evaluateWithObject:monthstr];
            if(isMatch) {
                //cal 10 2018 输出月历
                NSString *yearstr = [NSString stringWithUTF8String:argv[3]];
                if([monthstr integerValue] >= 1 && [monthstr integerValue] <= 12) {
                    MonthCalendar *monthCalendar = [[MonthCalendar alloc] initWithYear:[yearstr intValue] usingMonth:[monthstr intValue]];
                    [monthCalendar printMonthCalendar];
                }
                else {
                    NSLog(@"cal: %d is neither a month number (1..12) nor a name", [monthstr intValue]);
                    return 0;
                }
            } else {
                //第二个输入的是-m
                //cal -m 10 输出当年某月月历
                NSString *monthstr = [NSString stringWithUTF8String:argv[3]];
                if([monthstr integerValue] >= 1 && [monthstr integerValue] <= 12) {
                    NSDate *dateNow = [NSDate date];
                    NSCalendar *calendar = [NSCalendar currentCalendar];
                    NSInteger year, month, day;
                    [calendar getEra:nil year:&year month:&month day:&day fromDate:dateNow];
                    
                    MonthCalendar *monthCalendar = [[MonthCalendar alloc] initWithYear:year usingMonth:[monthstr intValue]];
                    [monthCalendar printMonthCalendar];
                }
                else {
                    NSLog(@"cal: %d is neither a month number (1..12) nor a name", [monthstr intValue]);
                    return 0;
                }
            }
        }
    }
    return 0;
}








