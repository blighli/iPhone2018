//
//  main.m
//  ZSCalendarTest
//
//  Created by 赵帅 on 2018/10/16.
//  Copyright © 2018 赵帅. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YearMonthDay.h"
#import "PrintCalendar.h"
int main(int argc, const char * argv[]) {
    @autoreleasepool{
        int year = 0,month = 0;
        
        if (argc==2) {
            NSString* argv1 = [NSString stringWithUTF8String:argv[1]];
            if ([argv1 isEqualToString:@"cal"]) {
                //执行cal命令
                //输出当年当月日历
                YearMonthDay* getYearMonth = [[YearMonthDay alloc]init];
                [getYearMonth currentYearMonth];
                year = getYearMonth.thisYear;
                month = getYearMonth.thisMonth;
                YearMonthDay* thisYearMonthCal = [[YearMonthDay alloc]getYearMonth:year Month:month];
                PrintCalendar* printYearMonthNow = [PrintCalendar new];
                [printYearMonthNow printMonth:thisYearMonthCal];
            }
            else
                NSLog(@"不支持‘%@'命令,请输入cal命令",argv1);
        }
        
        if(argc==3)
        {
            NSString* argv1 = [NSString stringWithUTF8String:argv[1]];
            NSString* argv2 = [NSString stringWithUTF8String:argv[2]];
            if ([argv1 isEqualToString:@"cal"]) {
                year= [argv2 intValue];
                if (1<=year&&year<=9999) {
                    //执行“cal 2018”命令；
                    //argv[2]==2018;
                    //输出指定年份 某月日历   传参数 year = argv[2]
                    YearMonthDay* myday=[[YearMonthDay alloc] getYearMonth:year Month:month];
                    PrintCalendar* printer=[PrintCalendar new];
                    [printer printYear: myday];
                    return 0;
                }
                else if (year<1||9999<year){
                    NSLog(@"‘%@’并不是一个正确的年份(1..9999)",argv2);
                }
            }
            else
                NSLog(@"不支持‘%@'命令,请输入cal命令",argv1);
        }
        
        if (argc==4) {
            NSString* argv1 = [NSString stringWithUTF8String:argv[1]];
            NSString* argv2 = [NSString stringWithUTF8String:argv[2]];
            NSString* argv3 = [NSString stringWithUTF8String:argv[3]];
            if ([argv1 isEqualToString:@"cal"]) {
                if ([argv2 isEqualToString:@"-m"]) {
                    month = [argv3 intValue];
                    if (1<=month&&month<=12) {
                        //执行“cal -m 10”命令；
                        //argv[3]==10;
                        //输出当年指定月份日历， 传参数 month = argv[3]
                        YearMonthDay* getYear = [[YearMonthDay alloc]init];
                        [getYear currentYearMonth];
                        year = getYear.thisYear;                        
                        YearMonthDay* someMonth = [[YearMonthDay alloc]getYearMonth:year Month:month];
                        PrintCalendar* printSomeMonth = [PrintCalendar new];
                        [printSomeMonth printMonth:someMonth];
                    }
                    else if (month<1||12<month){
                        NSLog(@"‘%@’并不是一个正确的月份(1..12)",argv3);
                    }
                }
                else{
                    //执行“cal 10 2018”命令；
                    //argv[2]==10;
                    //argv[3]==2018;
                    //输出指定年份 某月日历   传参数 month = argv[2] ， year = argv[3]
                    year = [argv3 intValue];
                    month = [argv2 intValue];
                    if(1<=month&&month<=12&&1<=year&&year<=9999){
                        YearMonthDay* monthDay = [[YearMonthDay alloc] getYearMonth:year Month:month];
                        PrintCalendar* monthCal = [[PrintCalendar alloc]init];
                        [monthCal printMonth:monthDay];
                    }else if (month<1||12<month){
                        NSLog(@"‘%@’并不是一个正确的月份(1..12)",argv2);
                    }
                    else if (year<1||9999<year){
                        NSLog(@"‘%@’并不是一个正确的年份(1..9999)",argv3);
                    }
                }
            }else
                NSLog(@"不支持‘%@’命令,请输入cal命令",argv1);
        }
    }
}
