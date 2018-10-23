//
//  Calendar.h
//  Calendar
//
//  Created by 叶晨宇 on 2018/10/21.
//  Copyright © 2018年 叶晨宇. All rights reserved.
//
#ifdef DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"%s\n",[[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(...)
#endif

#import <Foundation/Foundation.h>

@interface Calendar : NSObject

@property(nonatomic)int year;
@property(nonatomic)int month;

@property(nonatomic)int assigned;

-(void)print;

@end
