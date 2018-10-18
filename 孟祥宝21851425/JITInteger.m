//
//  JITDateOut.m
//  JITCalendar
//
//  Created by JuicyITer on 13/10/2018.
//  Copyright © 2018 JuicyITer. All rights reserved.
//

#import "JITInteger.h"


@implementation JITInteger

+ (NSInteger)stringLength:(NSString *)str
{
    const char *string = [str UTF8String];
    
    return [str length] + 0.5 * (strlen(string) - [str length]);
 
}

+ (NSInteger)numberFromString:(NSString *)str
{
    const char *uString = [str UTF8String];
    NSString *number = [[NSString alloc] init];
    for(int i = 0; i < strlen(uString); i++){
        if(uString[i] >= '0' && uString[i] <= '9')
            number = [number stringByAppendingFormat:@"%c", uString[i]];
        else
            break;
    }
    
    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    f.numberStyle = NSNumberFormatterNoStyle;
    NSNumber *value = [f numberFromString:number];
    
    return value.integerValue;
}

+ (NSInteger)maxLengthInStrings:(NSMutableArray *)arr
{
    NSInteger max = 0;
    for(NSInteger i = 1; i < [arr count]; i++){
        NSInteger length = [JITInteger stringLength:arr[i]];
        if(length > max)
            max = length;
    }
    
    return max;
}


+ (NSInteger)getWeekdayIndexFromComponents:(JITDateComponents *)comps
{
    NSDate *date = [comps.calendar dateFromComponents:comps];
    
    return [comps.calendar component:NSCalendarUnitWeekday
                            fromDate:date];
}

+ (NSInteger)getLine:(NSInteger)m
{
    NSInteger index = m;
    if(index < COUNT){
        // nothing
    }
    else if(index > COUNT && index < 2*COUNT)
    {
        index -= COUNT;
    }
    else
        index -= 2*COUNT;
    
    return (index - 1) / WEEKDAYS;
}

+ (NSInteger)isLastInWeek:(NSInteger)index
{
    if(index < COUNT){
        if(index % WEEKDAYS){
            return 0;
        }
        else
            return 1;
    }
    else if(index < 2 * COUNT)
    {
        index -= COUNT;
    }
    else{
        index -= 2*COUNT;
    }
    
    if(index % WEEKDAYS){
        return 0;
    }
    else
        return 1;
}

+ (NSInteger)maxWidthOfString:(NSString *)str
{
    NSInteger index = 0;
    for(NSInteger i = 0; i < [str length]; i++){
        index ++;
        if([str characterAtIndex:i] == '\n')
            break;
    }
    NSString *oneline = [str substringToIndex:index];
    return [JITInteger stringLength:oneline];
}
@end
