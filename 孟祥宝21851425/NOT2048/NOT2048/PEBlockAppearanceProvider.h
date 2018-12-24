//
//  PETileAppearanceProvider.h
//  PE-2048
//
//  Created by Peng&Ethan on 13/12/2018.
//  Copyright © 2018 Peng&Ethan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol PETileAppearanceProviderProtocol <NSObject>

- (UIColor *)blockColorForValue:(NSUInteger)value;
- (UIColor *)numberColorForValue:(NSUInteger)value;
- (UIFont *)fontForNumbers;

@end

@interface PEBlockAppearanceProvider : NSObject <PETileAppearanceProviderProtocol>

@end


NS_ASSUME_NONNULL_END
