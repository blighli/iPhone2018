//
//  Error.m
//  Calendar
//
//  Created by wuluying on 2018/10/22.
//  Copyright © 2018年 wuluying. All rights reserved.
//

#import "Error.h"

@implementation Error
+ (void)printError {
    printf("Invalid Input. Please input in the following format:\n");
    printf("cal\n");
    printf("cal 'month' 'year'\n");
    printf("cal -m 'month'\n");
    printf("cal 'year'\n");
}
@end
