//
//  JITTaskItem.m
//  JITTaskList
//
//  Created by JuicyITer on 31/10/2018.
//  Copyright © 2018 JuicyITer. All rights reserved.
//

#import "JITTaskItem.h"

@implementation JITTaskItem

- (void)setDateCreated:(NSDate *)date
{
    NSCalendar *cal = [NSCalendar autoupdatingCurrentCalendar];
    NSDateComponents *comps = [cal components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay |NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond)
                                     fromDate:date];
    _dateCreated = [cal dateFromComponents:comps];
    
}
- (NSString *)detail
{
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.locale = [NSLocale autoupdatingCurrentLocale];
    dateFormatter.dateStyle = NSDateFormatterMediumStyle;
    dateFormatter.timeStyle = NSDateFormatterMediumStyle;

    NSString *des = [[NSString alloc] initWithFormat:@"created at %@", [dateFormatter stringFromDate:self.dateCreated]];
    return des;
}
@end
