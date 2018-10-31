//
//  CalPrinter.h
//  cal
//
//  Created by asd on 2018/10/17.
//  Copyright © 2018年 asd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Day.h"
@interface CalPrinter : NSObject{
    
}
-(void) printMonthCal:(Day*) day;
-(void) printYearCal:(Day*) day;


@end
