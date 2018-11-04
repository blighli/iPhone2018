//
//  CalendarHelper.h
//  Project1
//
//  Created by 杨威 on 2018/10/21.
//  Copyright © 2018年 杨威. All rights reserved.
//

#ifndef CalendarHelper_h
#define CalendarHelper_h


#endif /* CalendarHelper_h */

#import <Foundation/Foundation.h>

@interface CalendarHelper : NSObject{
    
    
}

+(CalendarHelper*)Instance;

-(void)printMonth:(int)month withYear:(int)year;
-(void)printYear:(int)year;

@end
