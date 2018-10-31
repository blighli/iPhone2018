//
//  AppDelegate.h
//  Project2
//
//  Created by 杨威 on 2018/10/30.
//  Copyright © 2018年 杨威. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate,UITableViewDataSource>
{
    UITableView *taskTable;
    UITextField *taskField;
    UIButton *insertButton;
    NSMutableArray *tasks;
}

-(void)addTask:(id)sender;
@property (strong, nonatomic) UIWindow *window;


@end

