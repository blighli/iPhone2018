//
//  PEGameModel.m
//  PE-2048
//
//  Created by Peng&Ethan on 13/12/2018.
//  Copyright © 2018 Peng&Ethan. All rights reserved.
//

#import "PEGameModel.h"

#import "PEMoveOrder.h"
#import "PEBlockModel.h"
#import "PEQueueAction.h"

// Command queue
#define MAX_ACTIONS      100
#define QUEUE_DELAY       0.3

@interface PEGameModel ()

@property (nonatomic, weak) id<PEGameModelProtocol> delegate;

@property (nonatomic, strong) NSMutableArray *gameState;

@property (nonatomic) NSUInteger dimension;
@property (nonatomic) NSUInteger winValue;

@property (nonatomic, strong) NSMutableArray *actionQueue;
@property (nonatomic, strong) NSTimer *queueTimer;

@property (nonatomic, readwrite) NSInteger score;

@end

@implementation PEGameModel

+ (instancetype)gameModelWithDimension:(NSUInteger)dimension
                              winValue:(NSUInteger)value
                              delegate:(id<PEGameModelProtocol>)delegate {
    PEGameModel *model = [PEGameModel new];
    model.dimension = dimension;
    model.winValue = value;
    model.delegate = delegate;
    [model reset];
    return model;
}

- (void)reset {
    self.score = 0;
    self.gameState = nil;
    [self.actionQueue removeAllObjects];
    [self.queueTimer invalidate];
    self.queueTimer = nil;
}

#pragma mark - Insertion API

- (void)insertAtRandomLocationBlockWithValue:(NSUInteger)value {
    // Check if gameboard is full
    BOOL emptySpotFound = NO;
    for (NSInteger i=0; i<[self.gameState count]; i++) {
        if (((PEBlockModel *) self.gameState[i]).empty) {
            emptySpotFound = YES;
            break;
        }
    }
    if (!emptySpotFound) {
        // Board is full, we will never be able to insert a tile
        return;
    }
    // Yes, this could run forever. Given the size of any practical gameboard, I don't think it's likely.
    NSInteger row = 0;
    BOOL shouldExit = NO;
    while (YES) {
        row = arc4random_uniform((uint32_t)self.dimension);
        // Check if row has any empty spots in column
        for (NSInteger i=0; i<self.dimension; i++) {
            if ([self blockForIndexPath:[NSIndexPath indexPathForRow:row inSection:i]].empty) {
                shouldExit = YES;
                break;
            }
        }
        if (shouldExit) {
            break;
        }
    }
    NSInteger column = 0;
    shouldExit = NO;
    while (YES) {
        column = arc4random_uniform((uint32_t)self.dimension);
        if ([self blockForIndexPath:[NSIndexPath indexPathForRow:row inSection:column]].empty) {
            shouldExit = YES;
            break;
        }
        if (shouldExit) {
            break;
        }
    }
    [self insertBlockWithValue:value atIndexPath:[NSIndexPath indexPathForRow:row inSection:column]];
}

- (void)insertBlockWithValue:(NSUInteger)value
                atIndexPath:(NSIndexPath *)path {
    if (![self blockForIndexPath:path].empty) {
        return;
    }
    PEBlockModel *tile = [self blockForIndexPath:path];
    tile.empty = NO;
    tile.value = value;
    [self.delegate insertBlockAtIndexPath:path value:value];
}


#pragma mark - Movement API

- (void)performMoveInPoint:(struct PEMovePoint)point
           completionBlock:(void(^)(BOOL))completion {
    [self queueAction:[PEQueueAction actionWithPoint:point completionBlock:completion]];
}

- (NSInteger) getMergeNumberWithArray: (NSMutableArray *) array {
    if ([array count] > 1) {
        NSArray *sortedArray = [array sortedArrayUsingComparator: ^(id obj1, id obj2) {
            if ([obj1 integerValue] > [obj2 integerValue]) {
                return (NSComparisonResult)NSOrderedDescending;
            }
            if ([obj1 integerValue] < [obj2 integerValue]) {
                return (NSComparisonResult)NSOrderedAscending;
            }
            return (NSComparisonResult)NSOrderedSame;
        }];
        for (int i = 1;i < [sortedArray count]; i++) {
            if (sortedArray[i] == sortedArray[i - 1]) {
                return [sortedArray[i] integerValue];
            }
        }
        return -1;
    } else {
        return -1;
    }
}

- (NSArray *)getMovePath: (NSIndexPath *) destIndex
            withRowBlocks: (NSArray *)rowTiles
         withColumnBlocks: (NSArray *)columnTiles
{
    NSMutableArray* stack = [NSMutableArray array];
    
    NSInteger top = destIndex.row;
    NSInteger left = destIndex.section;
    NSInteger right = destIndex.section;
    NSInteger bottom = destIndex.row;
    NSInteger blockTop = top - 1;
    NSInteger blockLeft = left - 1;
    NSInteger blockRight = right + 1;
    NSInteger blockbottom = bottom + 1;
    
    NSInteger value = 0;
    NSInteger mergeValue = 0;
    NSInteger mergeCount = 0;
    BOOL hasMerge = FALSE;
    while (top != -1 || left != -1 || right != -1 || bottom != -1) {
        NSInteger i = 0;
        NSMutableArray* blockArray = [NSMutableArray array];
        if (top != -1) {
            for (i = top - 1; i >= 0; i--) {
                PEBlockModel * tile = columnTiles[i];
                if (!tile.empty) {
                    top = i;
                    [blockArray addObject:[NSNumber numberWithInteger:((PEBlockModel *)columnTiles[top]).value]];
                    break;
                }
            }
            if (i == -1) {
                top = -1;
            }
        }
        if (bottom != -1) {
            for (i = bottom + 1; i < self.dimension; i++) {
                PEBlockModel * tile = columnTiles[i];
                if (!tile.empty) {
                    bottom = i;
                    [blockArray addObject:[NSNumber numberWithInteger:((PEBlockModel *)columnTiles[bottom]).value]];
                    break;
                }
            }
            if (i == self.dimension) {
                bottom = -1;
            }
        }
        if (left != -1) {
            for (i = left - 1; i >= 0; i--) {
                PEBlockModel * tile = rowTiles[i];
                if (!tile.empty) {
                    left = i;
                    [blockArray addObject:[NSNumber numberWithInteger:((PEBlockModel *)rowTiles[left]).value]];
                    break;
                }
            }
            if (i == -1) {
                left = -1;
            }
        }
        if (right != -1) {
            for (i = right + 1; i < self.dimension; i++) {
                PEBlockModel * tile = rowTiles[i];
                if (!tile.empty) {
                    right = i;
                    [blockArray addObject:[NSNumber numberWithInteger:((PEBlockModel *)rowTiles[right]).value]];
                    break;
                }
            }
            if (i == self.dimension) {
                right = -1;
            }
        }
        
        if (mergeValue == 0) {
            NSInteger temp = [self getMergeNumberWithArray:blockArray];
            if (temp == -1) {
                hasMerge = false;
            } else {
                hasMerge = true;
                mergeValue = temp;
            }
        } else if (mergeValue == -1) {
            hasMerge = false;
        } else {
            NSInteger temp = 0;
            if (top != -1) {
                if(((PEBlockModel *)columnTiles[top]).value == mergeValue && blockTop == destIndex.row - 1)
                    temp++;
            }
            if (left != -1) {
                if(((PEBlockModel *)rowTiles[left]).value == mergeValue && blockLeft == destIndex.section - 1)
                    temp++;
            }
            if (right != -1) {
                if(((PEBlockModel *)rowTiles[right]).value == mergeValue && blockRight == destIndex.section + 1)
                    temp++;
            }
            if (bottom != -1) {
                if(((PEBlockModel *)columnTiles[bottom]).value == mergeValue && blockbottom == destIndex.row + 1)
                    temp++;
            }
            hasMerge = temp != 0;
        }
        //NSMutableArray * temp = [NSMutableArray array];
        
        if (top != -1) {
            if(((PEBlockModel *)columnTiles[top]).value == mergeValue && blockTop == destIndex.row - 1) {
                mergeCount++;
                if (value == 0) {
                    value = mergeValue;
                } else {
                    value = value * 2;
                }
                [stack addObject:[PEMoveOrder singleMoveOrderWithSource:top
                                                             destination:destIndex.row
                                                                newValue:value
                                                               direction:1]];
            } else if (mergeValue != 0) {
                if (hasMerge)
                    top++;
                else {
                    if (top != blockTop)
                        [stack addObject:[PEMoveOrder singleMoveOrderWithSource:top
                                                                     destination:blockTop
                                                                        newValue:((PEBlockModel *)columnTiles[top]).value
                                                                       direction:1]];
                    //[stack addObject:columnTiles[top]];
                    blockTop--;
                }
            } else {
                [stack addObject:[PEMoveOrder singleMoveOrderWithSource:top
                                                             destination:destIndex.row
                                                                newValue:((PEBlockModel *)columnTiles[top]).value
                                                               direction:1]];
                mergeValue = -1;
            }
        }
        if (left != -1) {
            if(((PEBlockModel *)rowTiles[left]).value == mergeValue && blockLeft == destIndex.section - 1) {
                mergeCount++;
                if (value == 0) {
                    value = mergeValue;
                } else {
                    value = value * 2;
                }
                [stack addObject:[PEMoveOrder singleMoveOrderWithSource:left
                                                             destination:destIndex.section
                                                                newValue:value
                                                               direction:2]];
                //[stack addObject:rowTiles[left]];
            } else if (mergeValue != 0) {
                if (hasMerge)
                    left++;
                else {
                    if (left != blockLeft)
                        [stack addObject:[PEMoveOrder singleMoveOrderWithSource:left
                                                                     destination:blockLeft
                                                                        newValue:((PEBlockModel *)rowTiles[left]).value
                                                                       direction:2]];
                    //[stack addObject:rowTiles[left]];
                    blockLeft--;
                }
            } else {
                [stack addObject:[PEMoveOrder singleMoveOrderWithSource:left
                                                             destination:destIndex.section
                                                                newValue:((PEBlockModel *)rowTiles[left]).value
                                                               direction:2]];
                mergeValue = -1;
            }
        }
        if (right != -1) {
            if(((PEBlockModel *)rowTiles[right]).value == mergeValue && blockRight == destIndex.section + 1) {
                mergeCount++;
                if (value == 0) {
                    value = mergeValue;
                } else {
                    value = value * 2;
                }
                [stack addObject:[PEMoveOrder singleMoveOrderWithSource:right
                                                             destination:destIndex.section
                                                                newValue:value
                                                               direction:3]];
                //[stack addObject:rowTiles[right]];
            } else if (mergeValue != 0) {
                if (hasMerge)
                    right--;
                else {
                    if (right != blockRight)
                        [stack addObject:[PEMoveOrder singleMoveOrderWithSource:right
                                                                     destination:blockRight
                                                                        newValue:((PEBlockModel *)rowTiles[right]).value
                                                                       direction:3]];
                    //[stack addObject:rowTiles[right]];
                    blockRight++;
                }
            } else {
                [stack addObject:[PEMoveOrder singleMoveOrderWithSource:right
                                                             destination:destIndex.section
                                                                newValue:((PEBlockModel *)rowTiles[right]).value
                                                               direction:3]];
                mergeValue = -1;
            }
        }
        if (bottom != -1) {
            if(((PEBlockModel *)columnTiles[bottom]).value == mergeValue && blockbottom == destIndex.row + 1) {
                mergeCount++;
                if (value == 0) {
                    value = mergeValue;
                } else {
                    value = value * 2;
                }
                [stack addObject:[PEMoveOrder singleMoveOrderWithSource:bottom
                                                             destination:destIndex.row
                                                                newValue:value
                                                               direction:4]];
                //[stack addObject:columnTiles[bottom]];
            } else if (mergeValue != 0) {
                if (hasMerge)
                    bottom--;
                else {
                    if (bottom != blockbottom)
                        [stack addObject:[PEMoveOrder singleMoveOrderWithSource:bottom
                                                                     destination:blockbottom
                                                                        newValue:((PEBlockModel *)columnTiles[bottom]).value
                                                                       direction:4]];
                    //[stack addObject:columnTiles[bottom]];
                    blockbottom++;
                }
            } else {
                [stack addObject:[PEMoveOrder singleMoveOrderWithSource:bottom
                                                             destination:destIndex.row
                                                                newValue:((PEBlockModel *)columnTiles[bottom]).value
                                                               direction:4]];
                mergeValue = -1;
            }
        }
        if (mergeValue != 0 && mergeValue != -1) {
            mergeValue = value;
            mergeCount = 1;
        }
    }
    
    return [NSArray arrayWithArray:stack];
}

- (BOOL)performPointMove:(struct PEMovePoint)point {
    BOOL hasMove = NO;
    NSInteger moveToX = point.x;
    NSInteger moveToY = point.y;
    
    if (![self blockForIndexPath:[NSIndexPath indexPathForRow:moveToY inSection:moveToX]].empty) {
        return NO;
    }
    
    NSMutableArray *thisColumnBlocks = [NSMutableArray arrayWithCapacity:self.dimension];
    for (NSInteger row = 0; row<self.dimension; row++) {
        [thisColumnBlocks addObject:[self blockForIndexPath:[NSIndexPath indexPathForRow:row inSection:moveToX]]];
    }
    NSMutableArray *thisRowBlocks = [NSMutableArray arrayWithCapacity:self.dimension];
    for (NSInteger column = 0; column<self.dimension; column++) {
        [thisRowBlocks addObject:[self blockForIndexPath:[NSIndexPath indexPathForRow:moveToY inSection:column]]];
    }
    NSArray *ordersArray = [self getMovePath:[NSIndexPath indexPathForRow:moveToY inSection:moveToX] withRowBlocks:thisRowBlocks withColumnBlocks:thisColumnBlocks];
    
    if ([ordersArray count] > 0) {
        hasMove = YES;
        for (NSInteger i=0; i<[ordersArray count]; i++) {
            PEMoveOrder *order = ordersArray[i];
            switch (order.direction) {
                case 1:{
                    NSIndexPath *sourcePath = [NSIndexPath indexPathForRow:order.source1 inSection:moveToX];
                    NSIndexPath *destinationPath = [NSIndexPath indexPathForRow:order.destination inSection:moveToX];
                    
                    PEBlockModel *sourceBlock = [self blockForIndexPath:sourcePath];
                    sourceBlock.empty = YES;
                    PEBlockModel *destinationBlock = [self blockForIndexPath:destinationPath];
                    destinationBlock.empty = NO;
                    destinationBlock.value = order.value;
                    // Update delegate
                    [self.delegate moveBlockFromIndexPath:sourcePath
                                             toIndexPath:destinationPath
                                                newValue:order.value];
                }
                    break;
                case 2:{
                    NSIndexPath *sourcePath = [NSIndexPath indexPathForRow:moveToY inSection:order.source1];
                    NSIndexPath *destinationPath = [NSIndexPath indexPathForRow:moveToY inSection:order.destination];
                    
                    PEBlockModel *sourceBlock = [self blockForIndexPath:sourcePath];
                    sourceBlock.empty = YES;
                    PEBlockModel *destinationBlock = [self blockForIndexPath:destinationPath];
                    destinationBlock.empty = NO;
                    destinationBlock.value = order.value;
                    // Update delegate
                    [self.delegate moveBlockFromIndexPath:sourcePath
                                             toIndexPath:destinationPath
                                                newValue:order.value];
                    
                }
                    break;
                case 3:{
                    NSIndexPath *sourcePath = [NSIndexPath indexPathForRow:moveToY inSection:order.source1];
                    NSIndexPath *destinationPath = [NSIndexPath indexPathForRow:moveToY inSection:order.destination];
                    
                    PEBlockModel *sourceBlock = [self blockForIndexPath:sourcePath];
                    sourceBlock.empty = YES;
                    PEBlockModel *destinationBlock = [self blockForIndexPath:destinationPath];
                    destinationBlock.empty = NO;
                    destinationBlock.value = order.value;
                    // Update delegate
                    [self.delegate moveBlockFromIndexPath:sourcePath
                                             toIndexPath:destinationPath
                                                newValue:order.value];
                }
                    break;
                case 4:{
                    NSIndexPath *sourcePath = [NSIndexPath indexPathForRow:order.source1 inSection:moveToX];
                    NSIndexPath *destinationPath = [NSIndexPath indexPathForRow:order.destination inSection:moveToX];
                    
                    PEBlockModel *sourceBlock = [self blockForIndexPath:sourcePath];
                    sourceBlock.empty = YES;
                    PEBlockModel *destinationBlock = [self blockForIndexPath:destinationPath];
                    destinationBlock.empty = NO;
                    destinationBlock.value = order.value;
                    // Update delegate
                    [self.delegate moveBlockFromIndexPath:sourcePath
                                             toIndexPath:destinationPath
                                                newValue:order.value];
                    
                }break;
                default:
                    break;
                    
            }
        }
    }
    //    }
    return hasMove;
}

#pragma mark - Game State API

- (BOOL)userHasLost {
    for (NSInteger i=0; i<[self.gameState count]; i++) {
        if (((PEBlockModel *) self.gameState[i]).empty) {
            // Gameboard must be full for the user to lose
            return NO;
        }
    }
    return YES;
}

- (NSIndexPath *)userHasWon {
    for (NSInteger i=0; i<[self.gameState count]; i++) {
        if (((PEBlockModel *) self.gameState[i]).value == self.winValue) {
            return [NSIndexPath indexPathForRow:(i / self.dimension)
                                      inSection:(i % self.dimension)];
        }
    }
    return nil;
}


#pragma mark - Private Methods

- (void)queueAction:(PEQueueAction *)action {
    if (!action || [self.actionQueue count] > MAX_ACTIONS) return;
    
    [self.actionQueue addObject:action];
    if (!self.queueTimer || ![self.queueTimer isValid]) {
        [self timerFired:nil];
    }
}

- (void)timerFired:(NSTimer *)timer {
    if ([self.actionQueue count] == 0) return;
    
    BOOL changed = NO;
    while ([self.actionQueue count] > 0) {
        PEQueueAction *action = [self.actionQueue firstObject];
        [self.actionQueue removeObjectAtIndex:0];
        changed = [self performPointMove:action.point];
        if (action.completion) {
            action.completion(changed);
        }
        if (changed) {
            break;
        }
    }
    
    self.queueTimer = [NSTimer scheduledTimerWithTimeInterval:QUEUE_DELAY
                                                       target:self
                                                     selector:@selector(timerFired:)
                                                     userInfo:nil
                                                      repeats:NO];
}

- (PEBlockModel *)blockForIndexPath:(NSIndexPath *)indexPath {
    NSInteger idx = (indexPath.row*self.dimension + indexPath.section);
    if (idx >= [self.gameState count]) {
        return nil;
    }
    return self.gameState[idx];
}

- (void)setBlock:(PEBlockModel *)tile forIndexPath:(NSIndexPath *)indexPath {
    NSInteger idx = (indexPath.row*self.dimension + indexPath.section);
    if (!tile || idx >= [self.gameState count]) {
        return;
    }
    self.gameState[idx] = tile;
}

- (NSMutableArray *)actionQueue {
    if (!_actionQueue) {
        _actionQueue = [NSMutableArray array];
    }
    return _actionQueue;
}

- (NSMutableArray *)gameState {
    if (!_gameState) {
        _gameState = [NSMutableArray array];
        for (NSInteger i=0; i<(self.dimension * self.dimension); i++) {
            [_gameState addObject:[PEBlockModel emptyBlock]];
        }
    }
    return _gameState;
}

- (void)setScore:(NSInteger)score {
    _score = score;
    [self.delegate scoreChanged:score];
}

@end

