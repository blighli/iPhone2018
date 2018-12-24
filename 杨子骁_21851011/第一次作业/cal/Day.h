//
//  Day.h
//  cal
//
//  Created by asd on 2018/10/17.
//  Copyright © 2018年 asd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Day : NSObject{
    
    NSDate* _myNSDate;
    NSDateComponents* _myComp;
    
}
@property int year;
@property int month;
@property int day;

- (id)initWithYMD:(int) Y:(int) M:(int) D;
- (NSDate*)getDate;
- (int) getWeek;
- (bool) isRun;
- (int) getMonthNum;
-(NSMutableString *) getMonthInEnglish;
@end
