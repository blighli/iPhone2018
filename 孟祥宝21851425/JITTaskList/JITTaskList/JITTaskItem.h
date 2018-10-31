//
//  JITTaskItem.h
//  JITTaskList
//
//  Created by JuicyITer on 31/10/2018.
//  Copyright © 2018 JuicyITer. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JITTaskItem : NSObject

- (NSString *)detail;
@property (nonatomic, copy) NSString *itemName;
@property (nonatomic, strong) NSDate *dateCreated;

@end


NS_ASSUME_NONNULL_END
