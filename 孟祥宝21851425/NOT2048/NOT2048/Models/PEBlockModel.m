//
//  PETileModel.m
//  PE-2048
//
//  Created by Peng&Ethan on 13/12/2018.
//  Copyright © 2018 Peng&Ethan. All rights reserved.
//

#import "PEBlockModel.h"

@implementation PEBlockModel

+ (instancetype)emptyBlock {
    PEBlockModel *block = [[self class] new];
    block.empty = YES;
    block.value = 0;
    return block;
}

- (NSString *)description {
    if (self.empty) {
        return @"Tile (empty)";
    }
    return [NSString stringWithFormat:@"Tile (value: %lu)", (unsigned long)self.value];
}

@end
