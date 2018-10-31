//
//  main.m
//  MyCal
//
//  Created by  年少相知君莫忘 on 2018/10/23.
//  Copyright © 2018年  年少相知君莫忘. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LTYYearAndMonth.h"
#import "LTYPrintCal.h"
#import "LTYJudgeFormat.h"

#define NSLog(FORMAT, ...) printf("%s", [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String])


int main(int argc, const char * argv[]){
    
    
    //调用LTYYearAndMonth创建当前日期
    LTYYearAndMonth *date = [[LTYYearAndMonth alloc] init];
    [date dateNow];
    
    
    //输出当月日历
    //mycal
    if(argc == 1){
        NSString *argv0 = [NSString stringWithUTF8String:argv[0]];
        
        [LTYPrintCal printCal:date.yearNow month:date.monthNow num:1];
        
    }
    //输出指定年份全年日历
    //mycal 2018
    else if(argc == 2){
        NSString *argv1 = [NSString stringWithUTF8String:argv[1]];
        
        LTYJudgeFormat *jf = [[LTYJudgeFormat alloc] init];
        
        BOOL res1 = [jf isNumber:argv1];
        
        if(res1){
            int y = [argv1 intValue];
            BOOL res2 = [jf isYearLegal:y];
            
            if(res2){
                [date dateNow];
                [LTYPrintCal printCal:y month:date.monthNow num:3];
            }
            else{
                NSLog(@"year %d not in range 1..9999",y);
            }
            
        }
        else{
            NSLog(@"usage: cal [[month] year]\ncal [-m month] [year]");
        }
        
        
        
    }
    //输出制定当年中指定月份的日历
    //或 以指定格式输出指定年份的全年日历
    //cal -m 10
    //cal -6 2018 （一行输出六个月 共两行）
    else if(argc == 3){
        NSString *argv1 = [NSString stringWithUTF8String:argv[1]];
        NSString *argv2 = [NSString stringWithUTF8String:argv[2]];
        
        LTYJudgeFormat *jf = [[LTYJudgeFormat alloc] init];
        
        BOOL res1 = [jf isNumber:argv1];
        BOOL res2 = [jf isNumber:argv2];
        
        if(res1 && res2){
            int m = [argv1 intValue];
            int y = [argv2 intValue];
            BOOL res3 = [jf isMonthLegal:m];
            BOOL res4 = [jf isYearLegal:y];
            
            if(res3){
                if(res4){
                    [date setYear:y andMonth:m];
                    [LTYPrintCal printCal:date.yearNow month:date.monthNow num:1];
                    
                }
                else{
                    NSLog(@"year %d not in range 1..9999",y);
                }
            }
            else{
                NSLog(@"month %d is not in range (1..12)",m);
            }
            
        }

        
        else if(res2 && !(res1)){
            BOOL res3 = [jf isLegal:argv1];
            int res4 = [jf isLineLegal:argv1];
                        
            if(res3){
                int m = [argv2 intValue];
                BOOL res5 = [jf isMonthLegal:m];
                
                if(res5){
                    [date dateNow];
                    int y = date.yearNow;
                    
                    [date setYear:y andMonth:m];
                    
                    [LTYPrintCal printCal:date.yearNow month:date.monthNow num:1];
                    
                }
                else{
                    NSLog(@"month %d is not in range (1..12)",m);
                }
                
            }
            
            else if(res4 && !(res3)){
                int y = [argv2 intValue];
                
                [LTYPrintCal printCal:y month:date.monthNow num:res4];
                
            }

            
            
            else{
                NSLog(@"usage: cal [[month] year]\ncal [-m month] [year]");
                
            }
            
        }
        
        
        
    }
    
    else{
        NSLog(@"usage: cal [[month] year]\ncal [-m month] [year]");
        
    }
    return 0;
}
