//
//  PEQueueAction.m
//  PE-2048
//
//  Created by Peng&Ethan on 13/12/2018.
//  Copyright © 2018 Peng&Ethan. All rights reserved.
//

#import "PEQueueAction.h"

@implementation PEQueueAction

+ (instancetype) actionWithPoint:(struct PEMovePoint)point completionBlock:(void (^)(BOOL))completion {
    PEQueueAction *action = [[self class] new];
    action.point = point;
    action.completion = completion;
    return action;
}

@end
