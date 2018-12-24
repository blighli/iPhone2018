//
//  PETileView.m
//  PE-2048
//
//  Created by Peng&Ethan on 13/12/2018.
//  Copyright © 2018 Peng&Ethan. All rights reserved.
//

#import "PEBlockView.h"

#import <QuartzCore/QuartzCore.h>
#import "PEBlockAppearanceProvider.h"
@interface PEBlockView ()

@property (nonatomic, readonly) UIColor *defaultBackgroundColor;
@property (nonatomic, readonly) UIColor *defaultNumberColor;

@property (nonatomic, strong) UILabel *numberLabel;
@property (nonatomic) NSUInteger value;
@end

@implementation PEBlockView

+ (instancetype)blockForPosition:(CGPoint)position
                     sideLength:(CGFloat)side
                          value:(NSUInteger)value
                   cornerRadius:(CGFloat)cornerRadius {
    PEBlockView *tile = [[[self class] alloc] initWithFrame:CGRectMake(position.x,
                                                                       position.y,
                                                                       side,
                                                                       side)];
    tile.tileValue = value;
    tile.backgroundColor = tile.defaultBackgroundColor;
    tile.numberLabel.textColor = tile.defaultNumberColor;
    tile.value = value;
    tile.layer.cornerRadius = cornerRadius;
    return tile;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self) return nil;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0,
                                                               0,
                                                               frame.size.width,
                                                               frame.size.height)];
    label.textAlignment = NSTextAlignmentCenter;
    label.minimumScaleFactor = 0.5;
    [self addSubview:label];
    self.numberLabel = label;
    return self;
}

- (void)setDelegate:(id<PETileAppearanceProviderProtocol>)delegate {
    _delegate = delegate;
    if (delegate) {
        self.backgroundColor = [delegate blockColorForValue:self.tileValue];
        self.numberLabel.textColor = [delegate numberColorForValue:self.tileValue];
        self.numberLabel.font = [delegate fontForNumbers];
    }
}

- (void)setTileValue:(NSInteger)tileValue {
    _tileValue = tileValue;
    self.numberLabel.text = [@(tileValue) stringValue];
    if (self.delegate) {
        self.backgroundColor = [self.delegate blockColorForValue:tileValue];
        self.numberLabel.textColor = [self.delegate numberColorForValue:tileValue];
    }
    self.value = tileValue;
}

- (UIColor *)defaultBackgroundColor {
    return [UIColor lightGrayColor];
}

- (UIColor *)defaultNumberColor {
    return [UIColor blackColor];
}

@end
