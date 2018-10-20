//
//  main.m
//  JITCalendar
//
//  Created by JuicyITer on 12/10/2018.
//  Copyright © 2018 JuicyITer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JITDateComponents.h"
#import "JITInteger.h"
#import "JITString.h"
#import "JITOut.h"
#import "JITArray.h"
#import "JITIn.h"
#import "JITError.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        if(argc == 1){
            JITDateComponents *now = [JITDateComponents newDateWithYear:1970];
            JITDateComponents *comps = [now today];
            [JITOut gOneMonthOut:comps isWithYear:WITHYEAR];
        }
        else{
            NSMutableArray *argList = [[NSMutableArray alloc] init];
            for(int i = 1; i < argc; i++){
                NSString *item = [[NSString alloc] initWithUTF8String:argv[i]];
                [argList addObject:item];
            }
            
            [JITIn handleOption:argList];
        }
    }
    return 0;
}
