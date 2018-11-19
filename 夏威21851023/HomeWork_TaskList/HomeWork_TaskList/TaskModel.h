//
//  TaskModel.h
//  HomeWork_TaskList
//
//  Created by Xia Wei on 2018/10/27.
//  Copyright © 2018 Xia Wei. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TaskModel : NSObject

@property(nonatomic,strong)NSMutableArray *taskArr;
-(instancetype)init;

@end

NS_ASSUME_NONNULL_END
