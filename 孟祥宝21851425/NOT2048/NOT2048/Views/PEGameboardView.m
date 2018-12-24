//
//  PEGameboardView.m
//  PE-2048
//
//  Created by Peng&Ethan on 13/12/2018.
//  Copyright © 2018 Peng&Ethan. All rights reserved.
//

#import "PEGameboardView.h"

#import <QuartzCore/QuartzCore.h>
#import "PEBlockView.h"
#import "PEBlockAppearanceProvider.h"

#define PER_SQUARE_SLIDE_DURATION 0.08

#if DEBUG
#define PELOG(...) NSLog(__VA_ARGS__)
#else
#define PELOG(...)
#endif

// Animation parameters
#define TILE_POP_START_SCALE    0.1
#define TILE_POP_MAX_SCALE      1.1
#define TILE_POP_DELAY          0.05
#define TILE_EXPAND_TIME        0.18
#define TILE_RETRACT_TIME       0.08

#define TILE_MERGE_START_SCALE  1.0
#define TILE_MERGE_EXPAND_TIME  0.08
#define TILE_MERGE_RETRACT_TIME 0.08


@interface PEGameboardView ()

@property (nonatomic, strong) NSMutableDictionary *boardTiles;

@property (nonatomic) NSUInteger dimension;
@property (nonatomic) CGFloat blockSideLength;

@property (nonatomic) CGFloat padding;
@property (nonatomic) CGFloat cornerRadius;

@property (nonatomic, strong) PEBlockAppearanceProvider *provider;
@property (nonatomic, weak) id<PEGameboardViewProtocol> delegate;
@end

@implementation PEGameboardView

+ (instancetype)gameboardWithDimension:(NSUInteger)dimension
                             cellWidth:(CGFloat)width
                           cellPadding:(CGFloat)padding
                          cornerRadius:(CGFloat)cornerRadius
                       backgroundColor:(UIColor *)backgroundColor
                       foregroundColor:(UIColor *)foregroundColor
                              delegate:(id<PEGameboardViewProtocol>)delegate {
    
    CGFloat sideLength = padding + dimension*(width + padding);
    PEGameboardView *view = [[[self class] alloc] initWithFrame:CGRectMake(0,
                                                                            0,
                                                                            sideLength,
                                                                            sideLength)];
    view.dimension = dimension;
    view.padding = padding;
    view.blockSideLength = width;
    view.layer.cornerRadius = cornerRadius;
    view.cornerRadius = cornerRadius;
    view.delegate = delegate;
    [view setupBackgroundWithBackgroundColor:backgroundColor
                             foregroundColor:foregroundColor];
    return view;
}

- (void)reset {
    for (NSString *key in self.boardTiles) {
        PEBlockView *tile = self.boardTiles[key];
        [tile removeFromSuperview];
    }
    [self.boardTiles removeAllObjects];
}

- (void)setupBackgroundWithBackgroundColor:(UIColor *)background
                           foregroundColor:(UIColor *)foreground {
    self.backgroundColor = background;
    CGFloat xCursor = self.padding;
    CGFloat yCursor;
    CGFloat cornerRadius = self.cornerRadius - 2;
    if (cornerRadius < 0) {
        cornerRadius = 0;
    }
    for (NSInteger i=0; i<self.dimension; i++) {
        yCursor = self.padding;
        for (NSInteger j=0; j<self.dimension; j++) {
            UIButton *bkgndTile = [[UIButton alloc] initWithFrame:CGRectMake(xCursor,
                                                                         yCursor,
                                                                         self.blockSideLength,
                                                                         self.blockSideLength)];
            bkgndTile.layer.cornerRadius = cornerRadius;
            bkgndTile.backgroundColor = foreground;
            bkgndTile.tag = j * self.dimension + i;
            [bkgndTile addTarget:self
                          action:@selector(blockTapped:)
                  forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:bkgndTile];
            yCursor += self.padding + self.blockSideLength;
        }
        xCursor += self.padding + self.blockSideLength;
    }
}

- (void)blockTapped:(id)sender {
    UIButton *button = (UIButton *)sender;
    NSInteger y = button.tag / self.dimension;
    NSInteger x = button.tag % self.dimension;
    [self.delegate blockTapped:x andY:y];
    PELOG(@"Block Tapped %ld, %ld", x, y);
}

// Insert a tile, with the popping animation
- (void)insertBlockAtIndexPath:(NSIndexPath *)path
                    withValue:(NSUInteger)value {
    PELOG(@"Inserting tile at row %ld, column %ld", (long)path.row, (long)path.section);
    if (!path
        || path.row >= self.dimension
        || path.section >= self.dimension
        || self.boardTiles[path]) {
        // Index path out of bounds, or there already is a tile
        return;
    }
    
    CGFloat x = self.padding + path.section*(self.blockSideLength + self.padding);
    CGFloat y = self.padding + path.row*(self.blockSideLength + self.padding);
    CGPoint position = CGPointMake(x, y);
    CGFloat cornerRadius = self.cornerRadius - 2;
    if (cornerRadius < 0) {
        cornerRadius = 0;
    }
    PEBlockView *block = [PEBlockView blockForPosition:position
                                          sideLength:self.blockSideLength
                                               value:value
                                        cornerRadius:cornerRadius];
    block.delegate = self.provider;
    block.layer.affineTransform = CGAffineTransformMakeScale(TILE_POP_START_SCALE, TILE_POP_START_SCALE);
    [self addSubview:block];
    self.boardTiles[path] = block;
    
    // Add the new tile to the board, with a pop animation
    [UIView animateWithDuration:TILE_EXPAND_TIME
                          delay:TILE_POP_DELAY
                        options:0
                     animations:^{
                         block.layer.affineTransform = CGAffineTransformMakeScale(TILE_POP_MAX_SCALE,
                                                                                 TILE_POP_MAX_SCALE);
                     } completion:^(BOOL finished) {
                         // Run the 'shrink' animation
                         [UIView animateWithDuration:TILE_RETRACT_TIME animations:^{
                             block.layer.affineTransform = CGAffineTransformIdentity;
                         } completion:^(BOOL finished) {
                             // Nothing right now
                         }];
                     }];
}

- (void)moveBlockOne:(NSIndexPath *)startA
            blockTwo:(NSIndexPath *)startB
        toIndexPath:(NSIndexPath *)end
          withValue:(NSUInteger)value {
    PELOG(@"Moving tiles at row %ld, column %ld and row %ld, column %ld to destination row %ld, column %ld",
           (long)startA.row, (long)startA.section,
           (long)startB.row, (long)startB.section,
           (long)end.row, (long)end.section);
    if (!startA || !startB || !self.boardTiles[startA] || !self.boardTiles[startB]
        || end.row >= self.dimension
        || end.section >= self.dimension) {
        NSAssert(NO, @"Invalid two-tile move and merge");
        return;
    }
    PEBlockView *tileA = self.boardTiles[startA];
    PEBlockView *tileB = self.boardTiles[startB];
    
    CGFloat x = self.padding + end.section*(self.blockSideLength + self.padding);
    CGFloat y = self.padding + end.row*(self.blockSideLength + self.padding);
    CGRect finalFrame = tileA.frame;
    finalFrame.origin.x = x;
    finalFrame.origin.y = y;
    
    // Don't perform update after animation
    [self.boardTiles removeObjectForKey:startA];
    [self.boardTiles removeObjectForKey:startB];
    self.boardTiles[end] = tileA;
    
    [UIView animateWithDuration:(PER_SQUARE_SLIDE_DURATION*1)
                          delay:0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         tileA.frame = finalFrame;
                         tileB.frame = finalFrame;
                     }
                     completion:^(BOOL finished) {
                         tileA.tileValue = value;
                         if (!finished) {
                             [tileB removeFromSuperview];
                             return;
                         }
                         tileA.layer.affineTransform = CGAffineTransformMakeScale(TILE_MERGE_START_SCALE,
                                                                                  TILE_MERGE_START_SCALE);
                         [tileB removeFromSuperview];
                         [UIView animateWithDuration:TILE_MERGE_EXPAND_TIME
                                          animations:^{
                                              tileA.layer.affineTransform = CGAffineTransformMakeScale(TILE_POP_MAX_SCALE,
                                                                                                       TILE_POP_MAX_SCALE);
                                          } completion:^(BOOL finished) {
                                              [UIView animateWithDuration:TILE_MERGE_RETRACT_TIME
                                                               animations:^{
                                                                   tileA.layer.affineTransform = CGAffineTransformIdentity;
                                                               } completion:^(BOOL finished) {
                                                                   // nothing yet
                                                               }];
                                          }];
                     }];
}

// Move a single tile onto another tile (that stays stationary), merging the two
- (void)moveTileAtIndexPath:(NSIndexPath *)start
                toIndexPath:(NSIndexPath *)end
                  withValue:(NSUInteger)value {
    PELOG(@"Moving tile at row %ld, column %ld to destination row %ld, column %ld",
           (long)start.row, (long)start.section, (long)end.row, (long)end.section);
    if (!start || !end || !self.boardTiles[start]
        || end.row >= self.dimension
        || end.section >= self.dimension) {
        NSAssert(NO, @"Invalid one-tile move and merge");
        return;
    }
    PEBlockView *tile = self.boardTiles[start];
    PEBlockView *endTile = self.boardTiles[end];
    BOOL shouldPop = endTile != nil;
    
    CGFloat x = self.padding + end.section*(self.blockSideLength + self.padding);
    CGFloat y = self.padding + end.row*(self.blockSideLength + self.padding);
    CGRect finalFrame = tile.frame;
    finalFrame.origin.x = x;
    finalFrame.origin.y = y;
    
    // Update board state
    [self.boardTiles removeObjectForKey:start];
    self.boardTiles[end] = tile;
    
    [UIView animateWithDuration:(PER_SQUARE_SLIDE_DURATION)
                          delay:0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         tile.frame = finalFrame;
                     }
                     completion:^(BOOL finished) {
                         tile.tileValue = value;
                         if (!shouldPop || !finished) {
                             return;
                         }
                         tile.layer.affineTransform = CGAffineTransformMakeScale(TILE_MERGE_START_SCALE,
                                                                                 TILE_MERGE_START_SCALE);
                         [endTile removeFromSuperview];
                         [UIView animateWithDuration:TILE_MERGE_EXPAND_TIME
                                          animations:^{
                                              tile.layer.affineTransform = CGAffineTransformMakeScale(TILE_POP_MAX_SCALE,
                                                                                                      TILE_POP_MAX_SCALE);
                                          } completion:^(BOOL finished) {
                                              [UIView animateWithDuration:TILE_MERGE_RETRACT_TIME
                                                               animations:^{
                                                                   tile.layer.affineTransform = CGAffineTransformIdentity;
                                                               } completion:^(BOOL finished) {
                                                                   // nothing yet
                                                               }];
                                          }];
                     }];
}

- (PEBlockAppearanceProvider *)provider {
    if (!_provider) {
        _provider = [PEBlockAppearanceProvider new];
    }
    return _provider;
}

- (NSMutableDictionary *)boardTiles {
    if (!_boardTiles) {
        _boardTiles = [NSMutableDictionary dictionary];
    }
    return _boardTiles;
}

@end

