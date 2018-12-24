//
//  main.m
//  Cal
//
//  Created by dawn on 2018/10/19.
//  Copyright © 2018 dawn. All rights reserved.
//
#define UNDEFINE -1
#import <Foundation/Foundation.h>
#import "DateHelper.h"
#import "CalPrinter.h"
#import "ParamChecker.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        DateHelper *date = [[DateHelper alloc] init];
        CalPrinter *printer = [[CalPrinter alloc] init];
        ParamChecker *checker = [[ParamChecker alloc] init];
        
        int year = [date getCurrentYear];
        int month = [date getCurrentMonth];
//        int day = [date getCurrentDay];
        
        if (argc == 1) {
            // cal
            [printer prin:(year) and:(month) and:(UNDEFINE)];
        } else if (argc == 2) {
            // cal 2018
            if (![checker isNumber:[NSString stringWithUTF8String:argv[1]]]) {
                printf("%s\n", "Parameter Error");
                return -1;
            }
            NSString *year = [NSString stringWithUTF8String:argv[1]];
        [printer prin:([year intValue]) and:(UNDEFINE) and:(UNDEFINE)];
        } else if (argc == 3) {
            // cal 10 2018
            // cal -m 10
            NSString *arg1 = [NSString stringWithUTF8String:argv[1]];
            NSString *arg2 = [NSString stringWithUTF8String:argv[2]];
            unichar ch = [arg1 characterAtIndex:0];
            if (ch == '-') {
                // cal -m 10
                if ([checker is_M:[NSString stringWithUTF8String:argv[1]]] ||
                    ![checker isNumber:[NSString stringWithUTF8String:argv[2]]] ||
                    [arg2 intValue] < 1 || [arg2 intValue] > 12) {
                    printf("%s\n", "Parameter Error");
                    return -1;
                }
                [printer prin:year and:[arg2 intValue] and:UNDEFINE];
            } else {
                // cal 10 2018
                if (![checker isNumber:[NSString stringWithUTF8String:argv[1]]] ||
                    ![checker isNumber:[NSString stringWithUTF8String:argv[2]]] ||
                    [arg1 intValue] < 1 || [arg1 intValue] > 12) {
                    printf("%s\n", "Parameter Error");
                    return -1;
                }
                [printer prin:[arg2 intValue] and:[arg1 intValue] and:UNDEFINE];
            }
        } else {
            printf("%s\n", "Parameter Error");
        }
    }
    return 0;
}
