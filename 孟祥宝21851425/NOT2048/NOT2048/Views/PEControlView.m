//
//  PEControlView.m
//  PE-2048
//
//  Created by Peng&Ethan on 13/12/2018.
//  Copyright © 2018 Peng&Ethan. All rights reserved.
//

#import "PEControlView.h"

#define DEFAULT_FRAME     CGRectMake(0, 0, 230, 30)

@interface PEControlView ()
@property (nonatomic) BOOL exitButtonEnabled;
@property (nonatomic, weak) id<PEControlViewProtocol> delegate;
@end

@implementation PEControlView

+ (instancetype)controlViewWithCornerRadius:(CGFloat)radius
                            backgroundColor:(UIColor *)color
                                 exitButton:(BOOL)exitButtonEnabled
                                   delegate:(id<PEControlViewProtocol>)delegate {
    PEControlView *view = [[[self class] alloc] initWithFrame:(DEFAULT_FRAME)];
    view.exitButtonEnabled = exitButtonEnabled;
    view.backgroundColor = color ?: [UIColor darkGrayColor];
    view.layer.cornerRadius = radius;
    view.delegate = delegate;
    [view setupSubviews];
    return view;
}

- (void)setupSubviews {
        // Small layout
        UIButton *resetButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 70, 30)];
        resetButton.titleLabel.textColor = [UIColor whiteColor];
        resetButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:14];
        resetButton.showsTouchWhenHighlighted = YES;
        [resetButton setTitle:@"RESET" forState:UIControlStateNormal];
        [resetButton addTarget:self
                        action:@selector(resetButtonTapped)
              forControlEvents:UIControlEventTouchUpInside];
        [resetButton setTitle:@"RESET" forState:UIControlStateNormal];
        [self addSubview:resetButton];
        
        if (self.exitButtonEnabled) {
            UIButton *exitButton = [[UIButton alloc] initWithFrame:CGRectMake(160, 0, 70, 30)];
            exitButton.titleLabel.textColor = [UIColor whiteColor];
            exitButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:14];
            exitButton.showsTouchWhenHighlighted = YES;
            [exitButton setTitle:@"EXIT" forState:UIControlStateNormal];
            [exitButton addTarget:self
                           action:@selector(exitButtonTapped)
                 forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:exitButton];
        }
}

- (void)resetButtonTapped {
    [self.delegate resetButtonTapped];
}

- (void)exitButtonTapped {
    [self.delegate exitButtonTapped];
}

@end

