//
//  TaskModel.m
//  HomeWork_TaskList
//
//  Created by Xia Wei on 2018/10/27.
//  Copyright © 2018 Xia Wei. All rights reserved.
//

#import "TaskModel.h"

@implementation TaskModel

- (instancetype)init{
    self = [super init];
    if (self) {
        self.taskArr = [[NSMutableArray alloc]init];
    }
    return self;
}

@end
