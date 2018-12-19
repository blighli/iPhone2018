//
//  PEGameViewController.m
//  PE-2048
//
//  Created by Peng&Ethan on 13/12/2018.
//  Copyright © 2018 Peng&Ethan. All rights reserved.
//

#import "PEGameViewController.h"

#import "PEGameboardView.h"
#import "PEControlView.h"
#import "PEScoreView.h"
#import "PEGameModel.h"

#define ELEMENT_SPACING 10

@interface PEGameViewController () <PEGameModelProtocol, PEControlViewProtocol, PEGameboardViewProtocol>

@property (nonatomic, strong) PEGameboardView *gameboard;
@property (nonatomic, strong) PEGameModel *model;
@property (nonatomic, strong) PEScoreView *scoreView;
@property (nonatomic, strong) PEControlView *controlView;

@property (nonatomic) BOOL useScoreView;

@property (nonatomic) NSUInteger dimension;
@property (nonatomic) NSUInteger threshold;
@end

@implementation PEGameViewController

+ (instancetype)numberBlockGameWithDimension:(NSUInteger)dimension
                               winThreshold:(NSUInteger)threshold
                            backgroundColor:(UIColor *)backgroundColor
                                scoreModule:(BOOL)scoreModuleEnabled {
    PEGameViewController *c = [[self class] new];
    c.dimension = dimension > 2 ? dimension : 2;
    c.threshold = threshold > 8 ? threshold : 8;
    c.useScoreView = scoreModuleEnabled;
    c.view.backgroundColor = backgroundColor ?: [UIColor whiteColor];
    return c;
}


#pragma mark - Controller Lifecycle


- (void)setupGame {
    PEScoreView *scoreView;
    PEControlView *controlView;
    
    CGFloat totalHeight = 0;
    
    // Set up score view
    if (self.useScoreView) {
        scoreView = [PEScoreView scoreViewWithCornerRadius:6
                                            backgroundColor:[UIColor darkGrayColor]
                                                  textColor:[UIColor whiteColor]
                                                   textFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:16]];
        totalHeight += (ELEMENT_SPACING + scoreView.bounds.size.height);
        self.scoreView = scoreView;
    }
    
    // Set up control view
    controlView = [PEControlView controlViewWithCornerRadius:6
                                                  backgroundColor:[UIColor blackColor]
                                                       exitButton:YES
                                                         delegate:self];
    totalHeight += (ELEMENT_SPACING + controlView.bounds.size.height);
    self.controlView = controlView;

    
    // Create gameboard
    CGRect rx = [UIScreen mainScreen].bounds;
    CGFloat padding = (self.dimension > 5) ? 3.0 : 6.0;
    CGFloat cellWidth = floorf((rx.size.width - 10 - padding*(self.dimension+1))/((float)self.dimension));
    if (cellWidth < 30) {
        cellWidth = 30;
    }
    PEGameboardView *gameboard = [PEGameboardView gameboardWithDimension:self.dimension
                                                                 cellWidth:cellWidth
                                                               cellPadding:padding
                                                              cornerRadius:6
                                                           backgroundColor:[UIColor blackColor]
                                                           foregroundColor:[UIColor darkGrayColor]
                                                                  delegate:self];
    totalHeight += gameboard.bounds.size.height;
    
    // Calculate heights
    CGFloat currentTop = 0.5*(self.view.bounds.size.height - totalHeight);
    if (currentTop < 0) {
        currentTop = 0;
    }
    
    if (self.useScoreView) {
        CGRect scoreFrame = scoreView.frame;
        scoreFrame.origin.x = 0.5*(self.view.bounds.size.width - scoreFrame.size.width);
        scoreFrame.origin.y = currentTop;
        scoreView.frame = scoreFrame;
        [self.view addSubview:scoreView];
        currentTop += (scoreFrame.size.height + ELEMENT_SPACING);
    }
    
    CGRect gameboardFrame = gameboard.frame;
    gameboardFrame.origin.x = 0.5*(self.view.bounds.size.width - gameboardFrame.size.width);
    gameboardFrame.origin.y = currentTop;
    gameboard.frame = gameboardFrame;
    [self.view addSubview:gameboard];
    currentTop += (gameboardFrame.size.height + ELEMENT_SPACING);
    

    CGRect controlFrame = controlView.frame;
    controlFrame.origin.x = 0.5*(self.view.bounds.size.width - controlFrame.size.width);
    controlFrame.origin.y = currentTop;
    controlView.frame = controlFrame;
    [self.view addSubview:controlView];

    
    self.gameboard = gameboard;
    
    // Create mode;
    PEGameModel *model = [PEGameModel gameModelWithDimension:self.dimension
                                                      winValue:self.threshold
                                                      delegate:self];
    [model insertAtRandomLocationBlockWithValue:2];
    [model insertAtRandomLocationBlockWithValue:2];
    self.model = model;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupGame];
}


#pragma mark - Private API

- (void)followUp {
    // This is the earliest point the user can win
    if ([self.model userHasWon]) {
        [self.delegate gameFinishedWithVictory:YES score:self.model.score];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Victory!" message:@"You won!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else {
        NSInteger rand = arc4random_uniform(10);
        if (rand == 1) {
            [self.model insertAtRandomLocationBlockWithValue:4];
        }
        else {
            [self.model insertAtRandomLocationBlockWithValue:2];
        }
        // At this point, the user may lose
        if ([self.model userHasLost]) {
            [self.delegate gameFinishedWithVictory:NO score:self.model.score];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Defeat!" message:@"You lost..." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
    }
}


#pragma mark - Model Protocol

- (void)moveBlockFromIndexPath:(NSIndexPath *)fromPath toIndexPath:(NSIndexPath *)toPath newValue:(NSUInteger)value {
    [self.gameboard moveTileAtIndexPath:fromPath toIndexPath:toPath withValue:value];
}

- (void)moveTileOne:(NSIndexPath *)startA tileTwo:(NSIndexPath *)startB toIndexPath:(NSIndexPath *)end newValue:(NSUInteger)value {
    [self.gameboard moveBlockOne:startA blockTwo:startB toIndexPath:end withValue:value];
}

- (void)insertBlockAtIndexPath:(NSIndexPath *)path value:(NSUInteger)value {
    [self.gameboard insertBlockAtIndexPath:path withValue:value];
}

- (void)scoreChanged:(NSInteger)newScore {
    self.scoreView.score = newScore;
}


#pragma mark - Control View Protocol

- (void)blockTapped:(NSInteger)x andY:(NSInteger)y {
    struct PEMovePoint point;
    point.x = x;
    point.y = y;
    [self.model performMoveInPoint:point completionBlock:^(BOOL changed) {
        if (changed) [self followUp];
    }];
}

- (void)resetButtonTapped {
    [self.gameboard reset];
    [self.model reset];

    [self.model insertBlockWithValue:2 atIndexPath:[NSIndexPath indexPathForRow:3 inSection:1]];
    [self.model insertBlockWithValue:2 atIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    [self.model insertBlockWithValue:4 atIndexPath:[NSIndexPath indexPathForRow:2 inSection:3]];
    [self.model insertBlockWithValue:8 atIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    [self.model insertBlockWithValue:16 atIndexPath:[NSIndexPath indexPathForRow:2 inSection:4]];
    [self.model insertBlockWithValue:32 atIndexPath:[NSIndexPath indexPathForRow:4 inSection:1]];
    //[self.model insertAtRandomLocationBlockWithValue:2];
    //[self.model insertAtRandomLocationBlockWithValue:2];
}

- (void)exitButtonTapped {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end

