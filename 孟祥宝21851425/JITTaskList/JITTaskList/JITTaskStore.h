//
//  JITTaskStore.h
//  JITTaskList
//
//  Created by JuicyITer on 31/10/2018.
//  Copyright © 2018 JuicyITer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JITTaskItem.h"
NS_ASSUME_NONNULL_BEGIN

@interface JITTaskStore : NSObject

@property (nonatomic, readonly)NSArray *allTasks;

+ (instancetype)sharedStore;
- (JITTaskItem *)createItemWithName:(NSString *)name;
- (void)removeItem:(JITTaskItem *)item;
- (void)moveItemAtIndex:(NSUInteger)fromIndex
                toIndex:(NSUInteger)toIndex;

- (void)saveData;
- (void)restoreDataTo:(NSMutableArray *)arr;
@end

NS_ASSUME_NONNULL_END
