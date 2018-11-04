//
//  AppDelegate.h
//  iTahDoodle
//
//  Created by shayue on 2018/10/25.
//  Copyright © 2018 shayue. All rights reserved.
//

#import <UIKit/UIKit.h>

NSString *docPath(void);

@interface AppDelegate : UIResponder <UIApplicationDelegate, UITableViewDataSource>

/***用户可以看见并交互的空间***/
//1. 表格视图，显示所有需要完成的任务
@property (nonatomic) UITableView *taskTable;
//2. 输入框，t供用户输入新任务
@property (nonatomic) UITextField *taskField;
//3. 一个按钮，按下后程序会将新任务加入表格
@property (nonatomic) UIButton *insertButton;

/***用户可以看见并交互的空间***/

//4. 所有的任务都将以字符串的形式保存在这个对象中
@property (nonatomic) NSMutableArray *tasks;

//5. window
@property (strong, nonatomic) UIWindow *window;


- (void)addTasks:(id)sender;

@end

