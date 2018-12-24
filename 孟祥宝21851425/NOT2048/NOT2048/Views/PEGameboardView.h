//
//  PEGameboardView.h
//  PE-2048
//
//  Created by Peng&Ethan on 13/12/2018.
//  Copyright © 2018 Peng&Ethan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol PEGameboardViewProtocol
- (void)blockTapped:(NSInteger)x andY:(NSInteger)y;
@end

@interface PEGameboardView : UIView

+ (instancetype)gameboardWithDimension:(NSUInteger)dimension
                             cellWidth:(CGFloat)width
                           cellPadding:(CGFloat)padding
                          cornerRadius:(CGFloat)cornerRadius
                       backgroundColor:(UIColor *)backgroundColor
                       foregroundColor:(UIColor *)foregroundColor
                              delegate:(id<PEGameboardViewProtocol>)delegate;

- (void)reset;

- (void)insertBlockAtIndexPath:(NSIndexPath *)path
                    withValue:(NSUInteger)value;

- (void)moveBlockOne:(NSIndexPath *)startA
            blockTwo:(NSIndexPath *)startB
        toIndexPath:(NSIndexPath *)end
          withValue:(NSUInteger)value;

- (void)moveTileAtIndexPath:(NSIndexPath *)start
                toIndexPath:(NSIndexPath *)end
                  withValue:(NSUInteger)value;

@end

NS_ASSUME_NONNULL_END
