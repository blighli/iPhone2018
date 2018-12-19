//
//  main.m
//  Cal
//
//  Created by xujiadai on 18/10/24.
//  Copyright © 2018年 xujiadai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YearAndMonthNow.h"
#import "JudgeNumberRegex.h"
#import "PrintYearAndMonth.h"
#import "Days.h"

int main(int argc, const char * argv[]){
  @autoreleasepool{
    
    int year,yue;
    PrintYearAndMonth *printMonthObj = [[PrintYearAndMonth alloc] init];
    PrintYearAndMonth *printYearObj = [[PrintYearAndMonth alloc] init];
    if (argc == 2) {

      YearAndMonthNow *yearAndMonthNow = [[YearAndMonthNow alloc] init];
      [yearAndMonthNow yearAndMonth];
      year = yearAndMonthNow.yearNow;
      yue = yearAndMonthNow.monthNow;
      
      [printMonthObj printmonth:year yue:yue];
    }
    else if(argc == 3){
      //4.执行“cal 2018”命令；
      NSString *argv2 = [NSString stringWithUTF8String:argv[2]];
      [printYearObj printyear:[argv2 intValue]];
    }
    else if(argc == 4){
      //2.执行“cal 10 2018”命令；
      NSString *argv2 = [NSString stringWithUTF8String:argv[2]];
      NSString *argv3 = [NSString stringWithUTF8String:argv[3]];
      JudgeNumberRegex *judgeNumberRegex = [[JudgeNumberRegex alloc] init];
      BOOL isMonthRegex = [judgeNumberRegex isNumber:argv2];
      BOOL isYearRegex = [judgeNumberRegex isNumber:argv3];
      
      if (isMonthRegex && isYearRegex) {
        //执行该命令时，argc = 4,argv[1] = cal,argv[2] = 10,argv[3] = 2014;
        //需要把数字字符串转化为整型；
        [printMonthObj printmonth:[argv3 intValue] yue:[argv2 intValue]];
      }
      else{
        //3.执行“cal -m 10”命令；
        YearAndMonthNow *yearAndMonthNow = [[YearAndMonthNow alloc] init];
        [yearAndMonthNow yearAndMonth];
        year = yearAndMonthNow.yearNow;
        [printMonthObj printmonth:year yue:[argv3 intValue]];
      }
    }
  }
  return 0;
}
