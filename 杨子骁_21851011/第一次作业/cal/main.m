//
//  main.m
//  cal
//
//  Created by asd on 2018/10/17.
//  Copyright © 2018年 asd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Day.h"
#import "CalPrinter.h"
int main(int argc, const char * argv[]) {
    int year=2018;
    int month=0;
    int day=0;
    if(argc==1)
    {
        NSDate *now = [NSDate date];
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
        NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
        year = (int)[dateComponent year];
        month = (int)[dateComponent month];
        Day* myday=[[Day alloc] initWithYMD:year :month :day];
        CalPrinter* printer=[CalPrinter new];
        [printer printMonthCal: myday];
        return 0;
    }
    else if(argc==2)
    {
        NSString *argv1 = [NSString stringWithUTF8String:argv[1]];
        NSString *numberRegex = @"^(1949|19[5-9][0-9]|20[0-9]{2}|2100)$";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", numberRegex];
        BOOL isMatch = [pred evaluateWithObject:argv1];
        if(!isMatch){
            printf("输入格式非法！\n");
            return 0;
        }
        year =[argv1 intValue];
        Day* myday=[[Day alloc] initWithYMD:year :month :day];
        CalPrinter* printer=[CalPrinter new];
        [printer printYearCal: myday];
        return 0;
        
    }
    else if(argc==3)
    {
        NSDate *now = [NSDate date];
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
        NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
        
        NSString *argv1 = [NSString stringWithUTF8String:argv[1]];
        NSString *argv2 = [NSString stringWithUTF8String:argv[2]];
        if([argv1 isEqualToString: @"-m"]){
            NSString *numberRegex = @"^([1-9]|1[0-2]|0[1-9])$";
            NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", numberRegex];
            BOOL isMatch = [pred evaluateWithObject:argv2];
            if(!isMatch){
                printf("输入格式非法！\n");
                return 0;
            }
            
            year = (int)[dateComponent year];
            month =[argv2 intValue];
            Day* myday=[[Day alloc] initWithYMD:year :month :day];
            CalPrinter* printer=[CalPrinter new];
            [printer printMonthCal: myday];
            return 0;
        }
        else{
            NSString *numberRegex = @"^([1-9]|1[0-2]|0[1-9])$";
            NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", numberRegex];
            BOOL isMatch = [pred evaluateWithObject:argv1];
            if(!isMatch){
                printf("输入格式非法！\n");
                return 0;
            }
            NSString *numberRegex2 = @"^(1949|19[5-9][0-9]|20[0-9]{2}|2100)$";
            NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", numberRegex2];
            BOOL isMatch2 = [pred2 evaluateWithObject:argv2];
            if(!isMatch2){
                printf("输入格式非法！\n");
                return 0;
            }
            year =[argv2 intValue];
            month =[argv1 intValue];
            Day* myday=[[Day alloc] initWithYMD:year :month :day];
            CalPrinter* printer=[CalPrinter new];
            [printer printMonthCal: myday];
            return 0;
        }
            
            
        year =[argv1 intValue];
        
        
    }
    else
    {
        printf("输入格式非法！\n");
        return 0;
        
    }
    
    
    
}





