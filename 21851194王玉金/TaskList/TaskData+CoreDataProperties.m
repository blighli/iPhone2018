//
//  TaskData+CoreDataProperties.m
//  TaskList
//
//  Created by 王玉金 on 2018/10/28.
//  Copyright © 2018年 yujin. All rights reserved.
//
//

#import "TaskData+CoreDataProperties.h"

@implementation TaskData (CoreDataProperties)

+ (NSFetchRequest<TaskData *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"TaskData"];
}

@dynamic taskName;

@end
