//
//  LTYPrintCal.m
//  MyCal
//
//  Created by  年少相知君莫忘 on 2018/10/23.
//  Copyright © 2018年  年少相知君莫忘. All rights reserved.
//

#import "LTYPrintCal.h"
#import "LTYCalInfo.h"

#define NSLog(FORMAT, ...) printf("%s", [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String])

@implementation LTYPrintCal

+ (void) printCal:(int)year
            month:(int)month
              num:(int)num
{
    NSString *jan = @"一月";
    NSString *feb = @"二月";
    NSString *mar = @"三月";
    
    NSString *apr = @"四月";
    NSString *may = @"五月";
    NSString *jun = @"六月";
    
    NSString *jul = @"七月";
    NSString *aug = @"八月";
    NSString *sep = @"九月";
    
    NSString *oco = @"十月";
    NSString *nov = @"十一月";
    NSString *dec = @"十二月";
    
    NSMutableArray *calList = [NSMutableArray array];
    
    [calList addObject:jan];
    [calList addObject:feb];
    [calList addObject:mar];
    
    [calList addObject:apr];
    [calList addObject:may];
    [calList addObject:jun];
    
    [calList addObject:jul];
    [calList addObject:aug];
    [calList addObject:sep];
    
    [calList addObject:oco];
    [calList addObject:nov];
    [calList addObject:dec];
    
    if(num == 1){
        
        NSLog(@"      %@%d年   \n",calList[month-1],year);
        NSLog(@" 日 一 二 三 四 五 六\n");
        
        int weekday = 0;
        int days = 0;
        
        
        weekday = [LTYCalInfo getTheWeekOfDayByYear:year
                                         andByMonth:month];
        
        days = [LTYCalInfo getDaysInMonth:year
                                    month:month];
        
        for(int i = 0;i < weekday;i++){
            NSLog(@"   ");
        }
        
        for(int i = 1;i <= days;i++){
            NSLog(@"%3d",i);
            if((i + weekday)%7 == 0) NSLog(@"\n");
        }
        NSLog(@"\n\n");
        
    }

    
    else{

        int flag1 = 0;
        
        int weekday[12];
        int days[12];
        int temp[12];
        memset(weekday, 0, sizeof(weekday));
        memset(days, 0, sizeof(days));
        memset(temp, 0, sizeof(temp));
        
        for(int i = 0;i < 12;i++){
            weekday[i] = [LTYCalInfo getTheWeekOfDayByYear:year andByMonth:(i+1)];
            days[i] = [LTYCalInfo getDaysInMonth:year month:(i+1)];
        }
        for(int i = 0;i < 12;i++){
            temp[i] = days[i];
        }
        
        NSLog(@"%28d年\n",year);
        
        for(int i = 0;i < 12;i = i+num){
            flag1 = 1;
            
            for(int k = i;(k < num+i) && (k < 12);k++){
                if(k == 11){
                    NSLog(@"      %@",calList[k]);
                }
                else{
                    NSLog(@"         %@         ",calList[k]);
                }
                
            }
            NSLog(@"\n");
            
            for(int j = i;(j < num+i) && (j < 12);j++){
                NSLog(@" 日 一 二 三 四 五 六 ");
            }
            NSLog(@"\n");
            
            //日历首行存在空格 单独处理
            if(flag1){
                
                
                for(int k = i;(k < num + i) && k < 12;k++){
                    for(int t = 0;t < weekday[k];t++){
                        NSLog(@"   ");
                    }
                    
                    //每个月历按顺序一行输出
                    for(int t = 1;t < days[k];t++){
                        NSLog(@"%3d",t+(days[k] - temp[k]));
                        if((t+(days[k] - temp[k]) + weekday[k])%7 == 0) {
                            NSLog(@" ");
                            temp[k] = temp[k] - t;
                            break;
                        }
                        
                    }
                    
                    
                }
                flag1 = 0;
                NSLog(@"\n");
            }
            
            
            
            for(int k = i;(k < num + i) && k < 12;k++){
                
                for(int t = 1;t < days[k];t++){
                    
                    //日历最后一行存在空格
                    if((t+(days[k] - temp[k])) > days[k]){
                        NSLog(@"   ");
                    }
                    else{
                        NSLog(@"%3d",t+(days[k] - temp[k]));
                    }
                    
                    if((t+(days[k] - temp[k]) + weekday[k])%7 == 0) {
                        NSLog(@" ");
                        temp[k] = temp[k] - t;
                        break;
                    }
                    
                }
                
                if((k == num + i - 1) && temp[k]>=-6) {
                    k = i - 1;
                    NSLog(@"\n");
                }
                
            }
            
            

            NSLog(@"\n");
    
        }
        
    }
    

}
@end
