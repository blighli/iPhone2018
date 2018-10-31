//
//  TaskData+CoreDataProperties.h
//  TaskList
//
//  Created by 王玉金 on 2018/10/28.
//  Copyright © 2018年 yujin. All rights reserved.
//
//

#import "TaskData+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface TaskData (CoreDataProperties)

+ (NSFetchRequest<TaskData *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *taskName;

@end

NS_ASSUME_NONNULL_END
