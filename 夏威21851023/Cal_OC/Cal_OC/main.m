//
//  main.m
//  Cal_OC
//
//  Created by Xia Wei on 2018/10/23.
//  Copyright © 2018 Xia Wei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JudgeNumberRegex.h"
#import "CurrentYearAndMonth.h"
#import "PrintCal.h"

int main(int argc, const char * argv[])
{
    
    
    @autoreleasepool{
        
        CurrentYearAndMonth *currentYandM = [[CurrentYearAndMonth alloc]init];
        //运行cal，输出当月的月历。
        if (argc == 2) {
            int year = currentYandM.year;
            int month = currentYandM.month;
            PrintCal *printDate = [[PrintCal alloc]init:year];
            [printDate printCalendar:month year:year];
        }
        //运行cal 2018，输出2018年的月历
        else if(argc == 3){
            NSString *argv2 = [NSString stringWithUTF8String:argv[2]];
            PrintCal *printDate = [[PrintCal alloc]init:[argv2 intValue]];
            [printDate PrintCalendar:[argv2 intValue]];
        }
        else if(argc == 4){
            //把传递进来的参数转化为OC中的NSString；
            NSString *argv2 = [NSString stringWithUTF8String:argv[2]];
            NSString *argv3 = [NSString stringWithUTF8String:argv[3]];
            
            JudgeNumberRegex *judgeNumberRegex = [[JudgeNumberRegex alloc] init];
            //用正则表达式判断是不是数字
            BOOL isMonthRegex = [judgeNumberRegex isNumber:argv2];
            if (isMonthRegex) {
                //执行“cal 10 2018”命令,输出2018年10月的月历；
                PrintCal *printDate = [[PrintCal alloc]init:[argv3 intValue]];
                [printDate printCalendar:[argv2 intValue] year:[argv3 intValue]];
            }
            else{
                //执行“cal -m 10”命令,输出当年10月的月历；
                int year = currentYandM.year;
                PrintCal *printDate = [[PrintCal alloc]init:year];
                [printDate printCalendar:[argv3 intValue] year:year];
            }
            
            
        }
        else{
            NSLog(@"输入错误!");
        }
        
    }
    
    
    return 0;
}
