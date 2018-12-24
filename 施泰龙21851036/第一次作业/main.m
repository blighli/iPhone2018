//
//  main.m
//  myCal
//
//  Created by 施泰龙 on 2018/12/20.
//  Copyright © 2018年 shitailong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "calendar.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        Cal *newCal = [[Cal alloc] init];
        switch(argc) {
            case 1: {
                //执行：./cal
                //输出：输出当月的日历
                NSDate *now = [NSDate date];
                printf("%s\n",[newCal showMonth:now showTheYear:true].UTF8String);
                break;
            }
            case 2: {
                //执行：./cal 2018
                //输出：输出2018年的日历
                @try {
                    int year = atoi(argv[1]);
                    if(year<1 || year>9999){
                        printf("cal: year \'%s\' not in range 1..9999\n",argv[1]);
                    }
                    printf("%s\n",[newCal showYear:year].UTF8String);
                    break;
                }
                @catch (NSException *exception) {
                    printf("Example:cal 2018\n");
                    //NSLog(@"exception = %@", exception);
                }
                break;
            }
            case 3: {
                @try {
                    NSString *argv1 = [[NSString alloc] initWithCString:(const char*)argv[1]
                                                               encoding:NSASCIIStringEncoding];
                    if([argv1 isEqualToString: @"-m"])
                    {
                        //执行：./cal -m 10
                        //输出：输出当年10月的日历
                        int month = atoi(argv[2]);
                        int year=0;
                        if(month<1 || month>12){
                            printf("cal: \'%s\' is neither a month number (1..12) nor a name\n",argv[2]);
                        }
                        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                        dateFormatter.dateFormat = @"yyyy-MM";
                        
                        //获取当前时间的年 月 日
                        NSDate *date1 = [NSDate date];
                        NSCalendar *cal = [NSCalendar currentCalendar];
                        //获取日期的元素
                        unsigned int unitFlags = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay;
                        //把要从date1中获取的unitFlags标示的日期元素存放在NSDateComponents类型的YearMonthDay里面；
                        NSDateComponents *YearMonthDay = [cal components:unitFlags fromDate:date1];
                        //得到当前的年份
                        year = (int)[YearMonthDay year];
                        
                        NSDate *date = [dateFormatter dateFromString:[NSString stringWithFormat:@"%4d-%2d",year,month]];
                        printf("%s\n",[newCal showMonth:date showTheYear:true].UTF8String);
                        break;
                    }
                    else
                    {
                        //执行：./cal 10 2018
                        //输出：输出2018年10月的日历
                        int month = atoi(argv[1]);
                        int year = atoi(argv[2]);
                        if(month<1 || month>12){
                            printf("cal: \'%s\' is neither a month number (1..12) nor a name\n",argv[1]);
                        }
                        if(year<1 || year>9999){
                            printf("cal: year \'%s\' not in range 1..9999\n",argv[2]);
                        }
                        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                        dateFormatter.dateFormat = @"yyyy-MM";
                        NSDate *date = [dateFormatter dateFromString:[NSString stringWithFormat:@"%4d-%2d",year,month]];
                        printf("%s\n",[newCal showMonth:date showTheYear:true].UTF8String);
                        break;
                    }
                }
                @catch (NSException *exception) {
                    //NSLog(@"exception = %@", exception);
                    printf("Example: cal -m 2018 \t cal 10 2018\n");
                }
                break;
            }
            default:
                printf("Input parameters are incorrect!Example:cal -m 2018 or cal -m 2018 or cal 10 2018\n");
                break;
        }
    }
    return 0;
}
