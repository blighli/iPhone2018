//
//  myCalendar.h
//  myCalendar
//
//  Created by 熊伟刚 on 2018/10/23.
//  Copyright © 2018 熊伟刚. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface myCalendar : NSObject

-(void)showCurrentMonth;
-(void)showCurrentYearWithMonth:(NSInteger)month;
-(void)showAllTheYear:(NSInteger)year;
-(void)showMonth:(NSInteger)month andYear:(NSInteger)year;

@end

NS_ASSUME_NONNULL_END
