//
//  LTYJudgeFormat.h
//  MyCal
//
//  Created by  年少相知君莫忘 on 2018/10/23.
//  Copyright © 2018年  年少相知君莫忘. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LTYJudgeFormat : NSObject
- (BOOL) isNumber:(NSString*) str;
- (BOOL) isMonthLegal:(int) num;
- (BOOL) isYearLegal:(int) num;
- (BOOL) isLegal:(NSString *) str;
- (int) isLineLegal:(NSString *) str;
@end
