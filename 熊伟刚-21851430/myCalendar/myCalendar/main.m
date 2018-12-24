//
//  main.m
//  myCalendar
//
//  Created by 熊伟刚 on 2018/10/23.
//  Copyright © 2018 熊伟刚. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "myCalendar.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool
    {
        int year = 0,month = 0;
        
        myCalendar *calendar = [[myCalendar alloc] init];
        
        switch (argc) {
                //只有cal一个参数，输出当前年当前月的日历
            case 1:
                [calendar showCurrentMonth];
                break;
                
            case 2:
                ////有两个参数，说明要打印某年的所有月日历，第二个参数为年份
                year = atoi(argv[1]);  //将字符串类型转化为整型
                if(year <=0 || year > 9999){
                    NSLog(@"illegal year");  //非法输入
                } else {
                    [calendar showAllTheYear:year];
                }
                break;
                
            case 3:
                //有三个参数，说明要打印指定年指定月日历
                if ([@"-m" isEqualToString:[NSString stringWithUTF8String:argv[1]]]){  //第一个字符串为-m，则默认当年
                    month = atoi(argv[2]);     //将字符串类型转化为整型
                    
                    if (month <= 0 || month > 12) {  //非法输入
                        NSLog(@"illegal month");
                    } else {
                        [calendar showCurrentYearWithMonth:month];
                    }
                } else {
                    month = atoi(argv[1]);  //获取月份
                    year = atoi(argv[2]); //获取年份
                    if(month <= 0 || month > 12 || year <=0 || year > 9999)
                    {
                        NSLog(@"illegal month or year"); //非法输入
                    } else {
                        [calendar showMonth:month andYear:year];
                    }
                }
                break;
                
            default: NSLog(@" Usage: cal [general options] [-hjy] [[month] year] cal [general options] [-hj] [-m month] [year] ncal [general options] [-hJjpwy] [-s country_code] [[month] year] ncal [general options] [-hJeo] [year] General options: [-NC3] [-A months] [-B months] For debug the highlighting: [-H yyyy-mm-dd] [-d yyyy-mm]"); //非法输入
                break;
        }
    }
    return 0;
}
