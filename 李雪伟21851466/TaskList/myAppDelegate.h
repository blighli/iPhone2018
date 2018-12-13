//
//  myAppDelegate.h
//  TaskList
//
//  Created by M David on 18-10-29.
//  Copyright (c) 2018年 M David. All rights reserved.
//

#import <UIKit/UIKit.h>

NSString *docPath(void);

@interface myAppDelegate : UIResponder <UIApplicationDelegate,UITableViewDataSource>
{
    UITableView *taskTable;
    UITextField *taskField;
    UIButton *insertButton;
    NSMutableArray *tasks;
}

-(void)addTask:(id)sender;

@property (strong,nonatomic)UIWindow *window;

@end
