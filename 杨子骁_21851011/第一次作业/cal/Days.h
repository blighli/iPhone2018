//
//  Days.h
//  cal
//
//  Created by asd on 2018/10/17.
//  Copyright © 2018年 asd. All rights reserved.
//

#ifndef Days_h
#define Days_h
#import <Foundation/Foundation.h>

@interface Days : NSObject
//这个类里面的方法只要设计成类方法就好了，没必要使用实例方法，只要进行简单的计算即可；

//判断是否是闰年；
+ (BOOL)isLeapYear:(int)year;

//计算从公元0年到你输入的上一年总共有多少天；
+ (int)daysOfUntilLastYear:(int)year;

//计算公元0年到你输入上个月共有多少天；
+ (int)daysOfUntilLastMonth:(int)year yue:(int)yue;

@end


#endif /* Days_h */
