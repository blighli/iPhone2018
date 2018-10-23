//
//  main.m
//  myCal
//
//  Created by 之川 on 2018/10/11.
//  Copyright © 2018 LX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Calendar.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        
        Calendar *cal = [[Calendar alloc]init];
        
        //get today's info
        NSDate *date = [NSDate date];
        NSCalendar *sCal = [NSCalendar currentCalendar];
        unsigned int unitFlags = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay;
        NSDateComponents *d = [sCal components:unitFlags fromDate:date];
        
        int curYear = (int)[d year];
        int curMonth= (int)[d month];
        
        if(argc == 1){
            [cal print:curYear :curMonth];
        }else if(argc == 2){
            NSString *yearStr=[[NSString alloc] initWithUTF8String:argv[1]];
            if([cal checkYear:yearStr]) [cal print:[yearStr intValue]];
            
        }else if (argc == 3){
            NSString *yearStr=[[NSString alloc] initWithUTF8String:argv[1]];
            
            if([cal checkYear:yearStr]){
                NSString *monthStr=[[NSString alloc] initWithUTF8String:argv[2]];
                if([cal checkMonth:monthStr]) [cal print:[yearStr intValue] :[monthStr intValue]];
            }else{
                if([yearStr  isEqual: @"-m"]){
                    NSString *monthStr=[[NSString alloc] initWithUTF8String:argv[2]];
                    if([cal checkMonth:monthStr]) [cal print:curYear :[monthStr intValue]];
                }else{
                    printf("Wrong command!\n");
                    [cal printHelp];
                }
            }
        }else{
            printf("Wrong command!\n");
            [cal printHelp];
        }
        
    }
    return 0;
}
