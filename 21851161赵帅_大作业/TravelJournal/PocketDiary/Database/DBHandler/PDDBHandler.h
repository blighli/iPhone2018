//
//  PDDBHandler.h
//  PocketDiary
//
//  Created by 赵帅 on 2018/11/20.
//  Copyright © 2018 赵帅. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"
#import "PDDatabaseKeyDefine.h"

@interface PDDBHandler : NSObject

@property (nonatomic, strong) FMDatabaseQueue *queue;

+ (instancetype)shareDBHandler;

@end
