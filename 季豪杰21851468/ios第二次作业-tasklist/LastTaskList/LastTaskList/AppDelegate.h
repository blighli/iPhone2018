//
//  AppDelegate.h
//  LastTaskList
//
//  Created by pc－jhj on 2018/10/28.
//  Copyright © 2018年 jhj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

