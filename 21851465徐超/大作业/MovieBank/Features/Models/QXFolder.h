//
//  QXFolder.h
//  MovieBank
//
//  Created by 祈越 on 2018/12/18.
//  Copyright © 2018 QiyueX. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class QXMovie;

@interface QXFolder : NSObject

@property (copy, nonatomic) NSString *fileName;
@property (strong, nonatomic) NSMutableArray *movies;

- (instancetype)initWithFileName:(NSString *)fileName;

- (void)addMovie:(QXMovie *)movie;
- (void)updateMovie:(QXMovie *)movie;
- (void)removeMovieAtIndex:(NSUInteger)index;
- (void)removeMovieWithID:(NSString *)movieID;

@end

NS_ASSUME_NONNULL_END
