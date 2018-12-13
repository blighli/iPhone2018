//
//  Judge.m
//  calendar_jhj
//
//  Created by pc－jhj on 2018/10/23.
//  Copyright © 2018年 jhj. All rights reserved.
//

#import "Judge.h"

@implementation Judge
- (BOOL)isAllNum:(NSString *)string{
    unichar c;
    for (int i=0; i<string.length; i++) {
        c=[string characterAtIndex:i];
        if (!isdigit(c)) {
            return NO;
        }
    }
    return YES;
}
 
@end
