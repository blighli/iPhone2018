//
//  JITTaskStore.m
//  JITTaskList
//
//  Created by JuicyITer on 31/10/2018.
//  Copyright © 2018 JuicyITer. All rights reserved.
//

#import "JITTaskStore.h"

@interface JITTaskStore()

@property (nonatomic) NSMutableArray *privateTasks;

@end

@implementation JITTaskStore

+ (instancetype)sharedStore
{
    static JITTaskStore *sharedStore = nil;
    
    if(!sharedStore){
        // first time to create a sharedStore
        sharedStore = [[self alloc] init];
    }
    return sharedStore;
}

- (instancetype)init
{
    self = [super init];
    if(self){
        
        _privateTasks = [[NSMutableArray alloc] init];
        [self restoreDataTo:_privateTasks];
    }
    
    return self;
}

- (NSArray *)allTasks
{
    return [self.privateTasks copy];
}

- (JITTaskItem *)createItemWithName:(NSString *)name
{
    JITTaskItem *item = [[JITTaskItem alloc] init];
    item.itemName = name;
    item.dateCreated = [NSDate date];
    if([self.privateTasks count] == 0)
        [self.privateTasks addObject:item];
    else
        [self.privateTasks insertObject:item atIndex:0];
    return item;
}

- (void)removeItem:(JITTaskItem *)item
{
    [self.privateTasks removeObject:item];
}

- (void)moveItemAtIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex
{
    if(fromIndex == toIndex)
        return;
    
    JITTaskItem *item = self.privateTasks[fromIndex];
    [self.privateTasks removeObjectAtIndex:fromIndex];
    
    [self.privateTasks insertObject:item atIndex:toIndex];
    
}

- (NSString *)itemArchivePath
{
    NSArray *docDirectives = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                                 NSUserDomainMask,
                                                                 YES);
    
    NSString *docDirective = [docDirectives firstObject];
    
    return [docDirective stringByAppendingPathComponent:@"items.plist"];
}

- (void)saveData
{
    NSString *file = [self itemArchivePath];
    
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    
    for(JITTaskItem *item in self.privateTasks){
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setObject:item.itemName forKey:@"itemName"];
        [dic setObject:item.dateCreated forKey:@"dateCreated"];
        [arr addObject:dic];
    }
    BOOL success = [arr writeToFile:file atomically:YES];
    
    NSAssert(success, @"failed");
}

- (void)restoreDataTo:(NSMutableArray *)arr
{
    NSString *file = [self itemArchivePath];
    NSMutableArray *farr = [NSMutableArray arrayWithContentsOfFile:file];
    
    for(NSMutableDictionary *dic in farr){
        JITTaskItem *item = [[JITTaskItem alloc] init];
        item.itemName = [dic objectForKey:@"itemName"];
        item.dateCreated = [dic objectForKey:@"dateCreated"];
        [arr addObject:item];
    }
    
}
@end
