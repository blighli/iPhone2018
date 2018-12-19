//
//  PETileModel.h
//  PE-2048
//
//  Created by Peng&Ethan on 13/12/2018.
//  Copyright © 2018 Peng&Ethan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PEBlockModel : NSObject

@property (nonatomic) BOOL empty;
@property (nonatomic) NSUInteger value;
+ (instancetype)emptyBlock;

@end

NS_ASSUME_NONNULL_END
