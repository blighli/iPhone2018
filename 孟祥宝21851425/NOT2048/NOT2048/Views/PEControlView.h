//
//  PEControlView.h
//  PE-2048
//
//  Created by Peng&Ethan on 13/12/2018.
//  Copyright © 2018 Peng&Ethan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol PEControlViewProtocol

- (void)resetButtonTapped;
- (void)exitButtonTapped;

@end

@interface PEControlView : UIView

+ (instancetype)controlViewWithCornerRadius:(CGFloat)radius
                            backgroundColor:(UIColor *)color
                                 exitButton:(BOOL)exitButtonEnabled
                                   delegate:(id<PEControlViewProtocol>)delegate;

@end

NS_ASSUME_NONNULL_END
