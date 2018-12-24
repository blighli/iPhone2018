//
//  QXFolder.m
//  MovieBank
//
//  Created by 祈越 on 2018/12/18.
//  Copyright © 2018 QiyueX. All rights reserved.
//

#import "QXFolder.h"
#import "QXMovie.h"

#define SANDBOX_DOCUMENT_PATH       NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0]
#define DEFAULT_FILE_MANAGER        [NSFileManager defaultManager]

@implementation QXFolder

- (instancetype)initWithFileName:(NSString *)fileName {
    if (self = [super init]) {
        self.fileName = fileName;
        [self readDataFromFile];
    }
    return self;
}

#pragma mark - Methods

- (void)addMovie:(QXMovie *)movie {
    NSUInteger index = [self indexInArrayWithID:movie.movieID];
    if (index < self.movies.count) {
        [self.movies replaceObjectAtIndex:index withObject:movie];
    } else {
        [self.movies addObject:movie];
        [self sortData];
    }
    [self writeDataToFile];
}

- (void)updateMovie:(QXMovie *)movie {
    NSUInteger index = [self indexInArrayWithID:movie.movieID];
    if (index < self.movies.count) {
        [self.movies replaceObjectAtIndex:index withObject:movie];
        [self writeDataToFile];
    }
}

- (void)removeMovieAtIndex:(NSUInteger)index {
    [self.movies removeObjectAtIndex:index];
    [self writeDataToFile];
}

- (void)removeMovieWithID:(NSString *)movieID {
    NSUInteger index = [self indexInArrayWithID:movieID];
    if (index < self.movies.count) {
        [self removeMovieAtIndex:index];
    }
}

#pragma mark - PrivateMethods

// 按字典序排序数组
- (void)sortData {
    [self.movies sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        NSString *str1 = [NSString stringWithFormat:@"%@(%@)", ((QXMovie *)obj1).titlePinyin, ((QXMovie *)obj1).year];
        NSString *str2 = [NSString stringWithFormat:@"%@(%@)", ((QXMovie *)obj2).titlePinyin, ((QXMovie *)obj2).year];
        return [str1 compare:str2];
    }];
}

// 返回指定ID的电影在数组中的位置，若不在数组中，则返回数组长度
- (NSUInteger)indexInArrayWithID:(NSString *)movieID {
    for (NSUInteger i = 0; i < self.movies.count; i++) {
        QXMovie *t = self.movies[i];
        if([movieID isEqualToString:t.movieID]) {
            return i;
        }
    }
    return self.movies.count;
}

#pragma mark - DataFile

- (void)readDataFromFile {
    NSString *filePath = [SANDBOX_DOCUMENT_PATH stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.Folder.plist", self.fileName]];
    if ([DEFAULT_FILE_MANAGER fileExistsAtPath:filePath]) {
        self.movies = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    } else {
        self.movies = [[NSMutableArray alloc] init];
    }
}

- (void)writeDataToFile {
    NSString *filePath = [SANDBOX_DOCUMENT_PATH stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.Folder.plist", self.fileName]];
    [NSKeyedArchiver archiveRootObject:self.movies toFile:filePath];
}

@end
