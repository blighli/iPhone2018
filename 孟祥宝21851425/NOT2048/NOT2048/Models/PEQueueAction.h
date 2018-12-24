//
//  PEQueueCommand.h
//  PE-2048
//
//  Created by Peng&Ethan on 13/12/2018.
//  Copyright © 2018 Peng&Ethan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PEGameModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface PEQueueAction : NSObject

@property (nonatomic) struct PEMovePoint point;
@property (nonatomic, copy) void(^completion)(BOOL atLeastOneMove);

+ (instancetype)actionWithPoint:(struct PEMovePoint)point completionBlock:(void(^)(BOOL))completion;
@end

NS_ASSUME_NONNULL_END
