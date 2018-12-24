//
//  QXBank.m
//  MovieBank
//
//  Created by 祈越 on 2018/12/18.
//  Copyright © 2018 QiyueX. All rights reserved.
//

#import "QXBank.h"

#define SANDBOX_DOCUMENT_PATH   NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0]
#define DEFAULT_FILE_MANAGER    [NSFileManager defaultManager]

@implementation QXBank

- (instancetype)initWithFileName:(NSString *)fileName {
    if (self = [super init]) {
        self.fileName = fileName;
        [self readDataFromFile];
    }
    return self;
}

#pragma mark - Methods

- (BOOL)addFolderWithTitle:(NSString *)title {
    for (NSString *t in self.folders) {
        if ([title isEqualToString:t]) {
            return NO;
        }
    }
    [self.folders addObject:title];
    [self writeDataToFile];
    return YES;
}

- (BOOL)renameFolderAtIndex:(NSUInteger)index withNewTitle:(NSString *)newTitle {
    for (NSString *t in self.folders) {
        if ([newTitle isEqualToString:t]) {
            return NO;
        }
    }
    NSString *filePath = [SANDBOX_DOCUMENT_PATH stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.Folder.plist", self.folders[index]]];
    if ([DEFAULT_FILE_MANAGER fileExistsAtPath:filePath]) {
        NSString *newFilePath = [SANDBOX_DOCUMENT_PATH stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.Folder.plist", newTitle]];
        [DEFAULT_FILE_MANAGER moveItemAtPath:filePath toPath:newFilePath error:nil];
    }
    [self.folders replaceObjectAtIndex:index withObject:newTitle];
    [self writeDataToFile];
    return YES;
}

- (void)removeFolderAtIndex:(NSUInteger)index {
    NSString *filePath = [SANDBOX_DOCUMENT_PATH stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.Folder.plist", self.folders[index]]];
    if ([DEFAULT_FILE_MANAGER fileExistsAtPath:filePath]) {
        [DEFAULT_FILE_MANAGER removeItemAtPath:filePath error:nil];
    }
    [self.folders removeObjectAtIndex:index];
    [self writeDataToFile];
}

- (void)moveFolderAtIndex:(NSUInteger)index toIndex:(NSUInteger)destinationIndex {
    NSString *t = self.folders[index];
    [self.folders removeObjectAtIndex:index];
    [self.folders insertObject:t atIndex:destinationIndex];
    [self writeDataToFile];
}

#pragma mark - DataFile

- (void)readDataFromFile {
    NSLog(@"%@", SANDBOX_DOCUMENT_PATH);
    NSString *filePath = [SANDBOX_DOCUMENT_PATH stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.Bank.plist", self.fileName]];
    if ([DEFAULT_FILE_MANAGER fileExistsAtPath:filePath]) {
        self.folders = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    } else {
        self.folders = [[NSMutableArray alloc] init];
    }
}

- (void)writeDataToFile {
    NSString *filePath = [SANDBOX_DOCUMENT_PATH stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.Bank.plist", self.fileName]];
    [NSKeyedArchiver archiveRootObject:self.folders toFile:filePath];
}

@end
