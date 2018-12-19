//
//  PEGameModel.h
//  PE-2048
//
//  Created by Peng&Ethan on 13/12/2018.
//  Copyright © 2018 Peng&Ethan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

struct PEMovePoint {
    int x;
    int y;
};

@protocol PEGameModelProtocol

- (void)scoreChanged:(NSInteger)newScore;

- (void)moveBlockFromIndexPath:(NSIndexPath *)fromPath
                  toIndexPath:(NSIndexPath *)toPath
                     newValue:(NSUInteger)value;
- (void)moveTileOne:(NSIndexPath *)startA
            tileTwo:(NSIndexPath *)startB
        toIndexPath:(NSIndexPath *)end
           newValue:(NSUInteger)value;
- (void)insertBlockAtIndexPath:(NSIndexPath *)path
                        value:(NSUInteger)value;

@end

@interface PEGameModel : NSObject

@property (nonatomic, readonly) NSInteger score;

+ (instancetype)gameModelWithDimension:(NSUInteger)dimension
                              winValue:(NSUInteger)value
                              delegate:(id<PEGameModelProtocol>)delegate;

- (void)reset;

- (void)insertAtRandomLocationBlockWithValue:(NSUInteger)value;

- (void)insertBlockWithValue:(NSUInteger)value
                atIndexPath:(NSIndexPath *)path;

- (void)performMoveInPoint:(struct PEMovePoint)point
               completionBlock:(void(^)(BOOL))completion;

- (BOOL)userHasLost;
- (NSIndexPath *)userHasWon;

@end


NS_ASSUME_NONNULL_END
