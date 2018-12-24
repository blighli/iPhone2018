//
//  PEMoveOrder.h
//  PE-2048
//
//  Created by Peng&Ethan on 13/12/2018.
//  Copyright © 2018 Peng&Ethan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PEMoveOrder : NSObject

@property (nonatomic) NSInteger direction;
@property (nonatomic) NSInteger source1;
@property (nonatomic) NSInteger source2;
@property (nonatomic) NSInteger destination;
@property (nonatomic) BOOL doubleMove;
@property (nonatomic) NSInteger value;

+ (instancetype)singleMoveOrderWithSource:(NSInteger)source
                              destination:(NSInteger)destination
                                 newValue:(NSInteger)value
                                direction:(NSInteger)d;

+ (instancetype)doubleMoveOrderWithFirstSource:(NSInteger)source1
                                  secondSource:(NSInteger)source2
                                   destination:(NSInteger)destination
                                      newValue:(NSInteger)value
                                     direction:(NSInteger)d;

@end

NS_ASSUME_NONNULL_END
