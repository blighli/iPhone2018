//
//  calendar.h
//  myCal
//
//  Created by 施泰龙 on 2018/10/22.
//  Copyright © 2018年 shitailong. All rights reserved.
//

#ifndef calendar_h
#define calendar_h

#import <Foundation/Foundation.h>

@interface Cal : NSObject

-(NSString *)showMonth:(NSDate *)date showTheYear: (BOOL)yearFlag;

-(NSString *)showYear:(int)year;

@end

#endif /* calendar_h */
