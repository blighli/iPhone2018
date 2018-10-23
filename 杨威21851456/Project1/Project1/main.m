//
//  main.m
//  Project1
//
//  Created by 杨威 on 2018/10/21.
//  Copyright © 2018年 杨威. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CalendarHelper.h"
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        if(argc==2){

            NSString *str1 = [[NSString alloc] initWithCString:(const char*)argv[1]
                                                                encoding:NSASCIIStringEncoding];
            if([str1 isEqualToString:@"cal"]){
               [[CalendarHelper Instance] printMonth:0 withYear:0];
            }
        }else if(argc==4){
            
            NSString *str1 = [[NSString alloc] initWithCString:(const char*)argv[1]
                                                      encoding:NSASCIIStringEncoding];
            NSString *str2 = [[NSString alloc] initWithCString:(const char*)argv[2]
                                                      encoding:NSASCIIStringEncoding];
            if([str1 isEqualToString:@"cal"]){
                
                if(atoi(argv[2])>=1&&atoi(argv[2])<=12&&atoi(argv[3])>=1&&atoi(argv[3])<=9999){
                    
                   [[CalendarHelper Instance] printMonth:atoi(argv[2]) withYear:atoi(argv[3])];
                }else if([str2 isEqualToString:@"-m"]&&atoi(argv[3])>=1&&atoi(argv[3])<=12){
                    
                    [[CalendarHelper Instance] printMonth:atoi(argv[3]) withYear:0];
                }
            }
        }else if(argc==3){
            
            NSString *str1 = [[NSString alloc] initWithCString:(const char*)argv[1]
                                                      encoding:NSASCIIStringEncoding];
            if([str1 isEqualToString:@"cal"]&&atoi(argv[2])>=1&&atoi(argv[2])<=9999){
                [[CalendarHelper Instance] printYear:atoi(argv[2])];
            }
        }else{
            NSLog(@"input error!");
        }
        
    }
    return 0;
}


