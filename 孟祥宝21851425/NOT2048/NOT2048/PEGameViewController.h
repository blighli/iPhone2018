//
//  PEGameViewController.h
//  PE-2048
//
//  Created by Peng&Ethan on 13/12/2018.
//  Copyright © 2018 Peng&Ethan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol PEGameProtocol <NSObject>
/*!
 Inform the delegate that the user completed a game.
 
 \param didWin   YES if the player won, NO otherwise
 \param score    the final score the player achieved
 */
- (void)gameFinishedWithVictory:(BOOL)didWin score:(NSInteger)score;
@end

@interface PEGameViewController : UIViewController

@property (nonatomic, weak) id<PEGameProtocol>delegate;

/*!
 Return an instance of the number tile game view controller.
 
 \param dimension                how many tiles wide and high the gameboard should be
 \param threshold                the tile value the player must achieve to win the game (e.g. 2048)
 \param backgroundColor          the background color of the gameboard
 \param scoreModuleEnabled       if YES, the score module will be visible
 */
+ (instancetype)numberBlockGameWithDimension:(NSUInteger)dimension
                               winThreshold:(NSUInteger)threshold
                            backgroundColor:(UIColor *)backgroundColor
                                scoreModule:(BOOL)scoreModuleEnabled;

@end


NS_ASSUME_NONNULL_END
