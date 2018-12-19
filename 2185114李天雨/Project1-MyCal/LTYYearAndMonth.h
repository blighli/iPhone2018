//
//  LTYYearAndMonth.h
//  MyCal
//
//  Created by  年少相知君莫忘 on 2018/10/23.
//  Copyright © 2018年  年少相知君莫忘. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LTYYearAndMonth : NSObject

@property (nonatomic) int yearNow;
@property (nonatomic) int monthNow;
@property (nonatomic,readonly) int dayNow;

- (void) dateNow;
- (void) setYear:(int)year andMonth:(int)month;

@end
