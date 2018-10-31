//
//  PrintData.h
//  CalendarSMC
//
//  Created by 史梦辰 on 2018/10/25.
//  Copyright © 2018年 史梦辰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PrintData : NSObject
-(BOOL) isNumber:(NSString*)str;
-(void)printMonth:(int)year month:(int)month;
-(void)printYear:(int)year;
//判断是否是闰年
@end
