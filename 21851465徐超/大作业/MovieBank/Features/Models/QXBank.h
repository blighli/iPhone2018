//
//  QXBank.h
//  MovieBank
//
//  Created by 祈越 on 2018/12/18.
//  Copyright © 2018 QiyueX. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QXBank : NSObject

@property (copy, nonatomic) NSString *fileName;
@property (strong, nonatomic) NSMutableArray *folders;

- (instancetype)initWithFileName:(NSString *)fileName;

- (BOOL)addFolderWithTitle:(NSString *)title;
- (BOOL)renameFolderAtIndex:(NSUInteger)index withNewTitle:(NSString *)newTitle;
- (void)removeFolderAtIndex:(NSUInteger)index;
- (void)moveFolderAtIndex:(NSUInteger)index toIndex:(NSUInteger)destinationIndex;

@end

NS_ASSUME_NONNULL_END
