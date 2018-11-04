//
//  AppDelegate.m
//  ListTodo
//
//  Created by dawn on 2018/10/27.
//  Copyright © 2018 dawn. All rights reserved.
//

#import "AppDelegate.h"

NSString *TodoListPath()
{
    NSArray *pathList = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    return [pathList[0] stringByAppendingPathComponent:@"todoList.td"];
}

@interface AppDelegate ()
@property UITableView *taskTable;
@property UITextField *taskField;
@property UIButton *insertButton;
@property NSMutableArray *tasks;

- (void)addTask:(id)sender;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    UIViewController *vc = [[UIViewController alloc] init];
    self.window.rootViewController = vc;
    int winFrameWidth = self.window.frame.size.width;
    int winFrameHeight = self.window.frame.size.height;
    CGRect tableFrame = CGRectMake(20, 80, winFrameWidth - 40,winFrameHeight - 100);
    int fieldFrameWidth = winFrameWidth * 4 / 6;
    CGRect fieldFrame = CGRectMake(20, 40, fieldFrameWidth, 30);
    int buttonFrameWidth = winFrameWidth * 1 / 6;
    CGRect buttonFrame = CGRectMake(20 + fieldFrameWidth, 40, buttonFrameWidth, 30);
    self.taskTable = [[UITableView alloc] initWithFrame:tableFrame style:UITableViewStylePlain];
    self.taskTable.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.taskTable setSeparatorColor:[UIColor whiteColor]];
    self.taskTable.dataSource = self;
    self.taskTable.delegate = self;
    [self.taskTable registerClass:[UITableViewCell class]
           forCellReuseIdentifier:@"Cell"];
    self.taskField = [[UITextField alloc] initWithFrame:fieldFrame];
    self.taskField.borderStyle = UITextBorderStyleRoundedRect;
    self.taskField.placeholder = @"Type a task, tap Insert";
    
    self.insertButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.insertButton.frame = buttonFrame;
    [self.insertButton setTitle:@"Add"
                       forState:UIControlStateNormal];
    
    [self.insertButton addTarget:self
                          action:@selector(addTask:)
                forControlEvents:UIControlEventTouchUpInside];
    
    NSArray *plist = [NSArray arrayWithContentsOfFile:TodoListPath()];
    if (plist) {
        self.tasks = [plist mutableCopy];
    } else {
        self.tasks = [NSMutableArray array];
    }
    [vc.view addSubview:self.taskTable];
    [vc.view addSubview:self.taskField];
    [vc.view addSubview:self.insertButton];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    [self.tasks writeToFile:TodoListPath() atomically:YES];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
}


- (void)applicationWillTerminate:(UIApplication *)application {
}

- (void)addTask:(id)sender{
    NSString *task = self.taskField.text;
    if([task isEqualToString:@""]){
        return;
    }
    [self.tasks addObject:task];
    [self.taskTable reloadData];
    self.taskField.text = @"";
    [self.taskField resignFirstResponder];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.tasks count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [self.taskTable dequeueReusableCellWithIdentifier:@"Cell"];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:@"Cell"];
    }
    NSString *item = [self.tasks objectAtIndex:[indexPath row]];
    [[cell textLabel] setText:item];
    
    if (cell.gestureRecognizers.count ==0) {
        UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
        lpgr.minimumPressDuration = 1;
        lpgr.delegate = self;
        [cell addGestureRecognizer:lpgr];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

-(void)handleLongPress:(UILongPressGestureRecognizer *)gestureRecognizer {
    
}

@end
