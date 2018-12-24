//
//  main.m
//  Project 1
//
//  Created by 张正昱阳 on 18-12-13.
//  Copyright (c) 2018年 张正昱阳. All rights reserved.
//

#import "Calender.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        if(argc == 2) {
            NSDate *dateNow = [NSDate date];
            NSCalendar *calendar = [NSCalendar currentCalendar];
            NSInteger year, month, day;
            [calendar getEra:nil year:&year month:&month day:&day fromDate:dateNow];
            
            MonthCalendar *monthCalendar = [[MonthCalendar alloc] initWithYear:year usingMonth:month];
            [monthCalendar printMonthCalendar];
        }
        
        else if(argc == 3) {
            NSString *yearstr = [NSString stringWithUTF8String:argv[2]];
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
            BOOL isMatch = [pred evaluateWithObject:monthstr];
            if(isMatch) {
                NSString *yearstr = [NSString stringWithUTF8String:argv[3]];
                if([monthstr integerValue] >= 1 && [monthstr integerValue] <= 12) {
                    if([yearstr integerValue] >= 0 && [yearstr integerValue] <= 9999){
                        MonthCalendar *monthCalendar = [[MonthCalendar alloc] initWithYear:[yearstr intValue] usingMonth:[monthstr intValue]];
                        [monthCalendar printMonthCalendar];
                    }
                    else {
                        NSLog(@"cal: year `%d' not in range 1..9999", [yearstr intValue]);
                        return 0;
                    }
                }
                else {
                    NSLog(@"cal: %d is neither a month number (1..12) nor a name", [monthstr intValue]);
                    return 0;
                }
            } else {
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
