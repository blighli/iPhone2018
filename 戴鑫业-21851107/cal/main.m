//
//  main.m
//  cal
//
//  Created by dxy on 2018/10/18.
//  Copyright © 2018年 dxy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Date.h"
#import "Cal.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        @autoreleasepool {
            Date *date = [[Date alloc] init];
            Cal *cal = [[Cal alloc] init];
            NSInteger year, month;
            
            switch(argc){
                case 1:
                    // usecase:1 输出：当月月历
                    year = [date getCurrentYear];
                    month = [date getCurrentMonth];
                    [cal printCal:month andYear:year];
                    break;
                case 2:
                    if(argv[1][0] == '-'){
                        if([@"-m" compare: [NSString stringWithUTF8String:argv[1]]] == NSOrderedSame){
                            printf("cal: option requires an argument -- m\n");
                        }else{
                            printf("cal: illegal option\n");
                        }
                        return 1;
                    }else{
                        // usecase:4 输入：<year> 输出：当年年历
                        // validate: <year>
                        if([cal validateYear:argv[1]]){
                            year = [[NSString stringWithUTF8String:argv[1]] intValue];
                            [cal printYearCal:year];
                            return 1;
                        }
                    }
                    break;
                case 3:
                    if(argv[1][0] == '-'){
                        // usecase:3 输入: -m <month> 输出：当年该月
                        if([@"-m" compare: [NSString stringWithUTF8String:argv[1]]] == NSOrderedSame){
                            // validate: <month>
                            if([cal validateMonth:argv[2]]){
                                year = [date getCurrentYear];
                                month = [[NSString stringWithUTF8String:argv[2]] intValue];
                                [cal printCal:month andYear:year];
                            }
                        }else{
                            // validate: <option>
                            printf("cal: illegal option\n");
                            return 1;
                        }
                    }else{
                        // usecase:2 输入：<month> <year> 输出：该年该月月历
                        // validate: <month> & <year>
                        if([cal validateMonth:argv[1]] && [cal validateYear:argv[2]]){
                            month = [[NSString stringWithUTF8String:argv[1]] intValue];
                            year = [[NSString stringWithUTF8String:argv[2]] intValue];
                            [cal printCal:month andYear:year];
                        }
                    }
                    break;
                    
            }
        }
        
    }
    return 0;
}
