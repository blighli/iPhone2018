//
//  AppDelegate.h
//  HomeWork_TaskList
//
//  Created by Xia Wei on 2018/10/25.
//  Copyright © 2018 Xia Wei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

