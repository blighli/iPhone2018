//
//  Print.h
//  cal
//
//  Created by M David on 18-10-20.
//  Copyright (c) 2018年 M David. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Print : NSObject
+(void)printMonth:(int) year:(int) month;
+(bool)addOneDay:(int) year;
+(void)printBlank:(int) day;
@end
