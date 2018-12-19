//
//  PEScoreView.m
//  PE-2048
//
//  Created by Peng&Ethan on 13/12/2018.
//  Copyright © 2018 Peng&Ethan. All rights reserved.
//

#import "PEScoreView.h"

#define DEFAULT_FRAME CGRectMake(0, 0, 140, 40)

@interface PEScoreView ()
@property (nonatomic, strong) UILabel *scoreLabel;
@end

@implementation PEScoreView

+ (instancetype)scoreViewWithCornerRadius:(CGFloat)radius
                          backgroundColor:(UIColor *)color
                                textColor:(UIColor *)textColor
                                 textFont:(UIFont *)textFont {
    PEScoreView *view = [[[self class] alloc] initWithFrame:DEFAULT_FRAME];
    view.score = 0;
    view.layer.cornerRadius = radius;
    view.backgroundColor = color ?: [UIColor whiteColor];
    view.userInteractionEnabled = YES;
    if (textColor) {
        view.scoreLabel.textColor = textColor;
    }
    if (textFont) {
        view.scoreLabel.font = textFont;
    }
    return view;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self) return nil;
    UILabel *scoreLabel = [[UILabel alloc] initWithFrame:frame];
    scoreLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:scoreLabel];
    self.scoreLabel = scoreLabel;
    return self;
}

- (void)setScore:(NSInteger)score {
    _score = score;
    self.scoreLabel.text = [NSString stringWithFormat:@"SCORE: %ld", (long)score];
}

@end

