//
//  calendar.m
//  myCal
//
//  Created by 施泰龙 on 2018/10/22.
//  Copyright © 2018年 shitailong. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "calendar.h"

@implementation Cal: NSObject

/*
 *输入：NSDate date   BooL yearFlag
 *返回：输入日期的日历（月）
 *功能：根据输入的日期和是否在日历头部显示年份，返回输入日期的日历（月）
 */
- (NSString *)showMonth:(NSDate *)date showTheYear: (BOOL)yearFlag{
    NSMutableString *retString = [NSMutableString stringWithFormat:@""];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    //获取日期的元素
    NSDateComponents *components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday fromDate:date];
    int year = (int)components.year;
    int month = (int)components.month;
    // NSRange是一个结构体，其中location是一个以0为开始的index，length是表示对象的长度。他们都是NSUInteger类型。
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    int monthRange = (int)range.length;

    NSDateComponents *firstDayComponents = [[NSDateComponents alloc] init];
    [firstDayComponents setYear:year];
    [firstDayComponents setMonth:month];
    NSDate *firstDay = [calendar dateFromComponents:firstDayComponents];
    firstDayComponents = [calendar components:NSCalendarUnitWeekday fromDate:firstDay];
    //周日-周六   对应weekday为0-6
    int weekday = (int)firstDayComponents.weekday-1;
    
    //定义t日历头
    //    9 2018
    //       9
    NSString *title;
    if(yearFlag)
    {
        title = [NSString stringWithFormat:@"      %2d %4d       \n",(int)components.month,(int)components.year];
    }
    else{
        title = [NSString stringWithFormat:@"        %2d         \n",(int)components.month];
    }
    NSString *subTitle = @"Su Mo Tu We Th Fr Sa\n";
    [retString appendFormat:@"%@%@",title,subTitle];
    
    int day = 1;
    int col = 0;
    while(weekday>0){
        [retString appendString:@"   "];
        weekday--;
        col++;
    }
    while(day<=monthRange){
        while(col<7){
            if(col==6){
                [retString appendFormat:@"%2d",day];
            }
            else [retString appendFormat:@"%2d ",day];
            col++;
            day++;
            if(day>monthRange) break;
        }
        if(day>monthRange){
            while(col<7){
                if(col==6){
                    [retString appendString:@"  "];
                }
                else [retString appendString:@"   "];
                col++;
            }
            break;
        }
        col = 0;
        [retString appendString:@"\n"];
    }
    return retString;
}

/*
 *输入：year
 *返回：输入年份的日历（年）
 *功能：根据输入的年份，返回一整年的日历
 */
- (NSString *)showYear:(int)year {
    NSMutableString *retString = [NSMutableString stringWithFormat:@""];
    [retString appendFormat:@"                             %4d                             \n\n",year];
    NSMutableArray *monthStringArray = [[NSMutableArray alloc] init];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM";
    for(int month=1;month<=12;month++){
        NSDate *date = [dateFormatter dateFromString:[NSString stringWithFormat:@"%4d-%2d",year,month]];
        NSString *monthString = [self showMonth:date showTheYear:false];
        NSMutableArray *tempArray = [monthString componentsSeparatedByString:@"\n"].mutableCopy;
        [monthStringArray addObject:tempArray];
    }
    
    for(int i=0;i<12/3;i++){
        int returnFlag=0;
        int maxLineCount=(int)((NSMutableArray *)monthStringArray[3*i]).count;
        for(int m=3*i;m<3*(i+1);m++){
            int tempCount=(int)((NSMutableArray *)monthStringArray[m]).count;
            if(maxLineCount<tempCount){
                maxLineCount = tempCount;
            }
        }
        for(int m=3*i;m<3*(i+1);m++){
            int tempCount=(int)((NSMutableArray *)monthStringArray[m]).count;
            if(tempCount<maxLineCount){
                returnFlag = 1;
                NSMutableArray *tempMutableArray = (NSMutableArray *)monthStringArray[m];
                [tempMutableArray addObject:@"                    "];
            }
        }
        for(int m=0;m<maxLineCount;m++){
            for(int n=3*i;n<3*(i+1);n++){
                [retString appendFormat:@"%@",(NSMutableArray *)monthStringArray[n][m]];
                [retString appendString:@"  "];
            }
            [retString appendString:@"\n"];
        }
        if(!returnFlag){
            [retString appendString:@"\n"];
        }
    }
    return retString;
}
@end
