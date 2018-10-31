//
//  main.m
//  Calendar
//
//  Created by macos on 2018/10/13.
//  Copyright © 2018 macos. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NEWCal.h"
//判断输入年份是否合法
Boolean isofyear(const char *str)
{
    for(int i = 0; i < strlen(str); i++)
    {
        if(str[i] < '0' || str[i] > '9')
        {
            return false;
        }
    }
    return true;
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        
        NEWCal *mycal = [[NEWCal alloc] init];
        //创建当前日历
        NSCalendar *calendar = [NSCalendar currentCalendar];
        //创建当前日期
        NSDate *date = [NSDate date];
        NSDateComponents *components = [calendar components:(NSCalendarUnitWeekday | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitDay) fromDate:date];
        
        NSUInteger year = [components year];
        NSUInteger month = [components month];
        //判断输入参数
        if(argc == 1)
        {
            //默认输入，输出当前月历
            [mycal printMonth:month ofYear:year];
        }
        else if(argc == 2)
        {
            //判断输入年份是否合法，输出年历
            if(isofyear(argv[1]))
            {
                year = atoi(argv[1]);
                [mycal printYear:year];
            }
            else
            {
                NSLog(@"Input error: %s is invalid.", argv[1]);
            }
        }
        else if(argc == 3)
        {
            //判断输入是否为-m，输出当年月历
            if(strcmp(argv[1], "-m") == 0)
            {
                if(atoi(argv[2]) >= 1 && atoi(argv[2]) <= 12)
                {
                    month = atoi(argv[2]);
                    [mycal printMonth:month ofYear:year];
                }
                else
                {
                    NSLog(@"Input error: %s is invalid.", argv[2]);
                }
            }
            //判断月份是否合法
            else if(atoi(argv[1]) >= 1 && atoi(argv[1]) <= 12)
            {
                //判断年份是否合法
                if(isofyear(argv[2]))
                {
                    year = atoi(argv[2]);
                    month = atoi(argv[1]);
                    [mycal printMonth:month ofYear:year];
                }
                else
                {
                    NSLog(@"Input error: %s is invalid.", argv[2]);
                }
            }
            else
            {
                NSLog(@"Input error: %s is invalid.", argv[1]);
            }
        
        }
    }
    return 0;
}
