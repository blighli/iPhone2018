/**
 * @author vosamowho
 * @Date   2018/10/17
*/

#ifndef calendar_h
#define calendar_h

@interface Calendar : NSObject

//PrintUsage give a intorduce
- (void) printUsage;

//Leap year justice
- (bool) isLeapYear:(int)year;
- (int) countDays:(int)year :(int) month :(int)day;
- (int) getDayOfWeek:(int)year :(int)month :(int)day;

//Print date and check format
- (void) printYear:(int)year;
- (void) printMonth:(int)year :(int)month;
- (void) printLine:(int)year :(int)start :(int)end;
- (bool) checkYear:(int)year;
- (bool) checkMonth:(int)month;
@end


#endif /* calendar_h */



