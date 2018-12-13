//
//  AppDelegate.m
//  MyApp
//
//  Created by Loren on 2018/10/31.
//  Copyright © 2018年 Loren. All rights reserved.
//

#import "AppDelegate.h"


@interface AppDelegate ()
@end
//文件路径
NSString *LTYFieldsPath()
{
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    //NSLog(@"%@",path[0]);
    
    return[path[0] stringByAppendingPathComponent:@"data.td"];
}

@implementation AppDelegate

#pragma mark - 回调方法
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    NSArray *plist =[NSArray arrayWithContentsOfFile:LTYFieldsPath()];
    
    if(plist){
        self.tasks = [plist mutableCopy];
    }
    else{
        //默认
        self.tasks = [NSMutableArray array];
        [self.tasks addObject:@"吃饭"];
        [self.tasks addObject:@"睡觉"];
        [self.tasks addObject:@"打豆豆"];
    }
    
    
    CGRect windowFrame = [[UIScreen mainScreen] bounds];
    UIWindow *createWindow = [[UIWindow alloc] initWithFrame:windowFrame];
    self.window = createWindow;
    
    CGRect tableFrame = CGRectMake(0, 80, windowFrame.size.width, windowFrame.size.height - 100);
    CGRect textFrame = CGRectMake(20,40,230,35);
    CGRect buttonFrame = CGRectMake(260,40,80,35);
    
    self.tableViewTask = [[UITableView alloc] initWithFrame:tableFrame
                                                      style:UITableViewStylePlain];
    //self.tableViewTask.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableViewTask.tableFooterView = [[UIView alloc] init];
    
    self.tableViewTask.dataSource = self;
    [self.tableViewTask registerClass:[UITableViewCell class]
               forCellReuseIdentifier:@"Cell"];
    //显示滚动条
    self.tableViewTask.showsVerticalScrollIndicator = YES;
    
    
    
    
    self.textFieldTask = [[UITextField alloc] initWithFrame:textFrame];
    self.textFieldTask.borderStyle = UITextBorderStyleRoundedRect;
    self.textFieldTask.placeholder = @"请输入...";
    
    
    
    self.buttonTask = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.buttonTask.frame = buttonFrame;
    self.buttonTask.backgroundColor = [UIColor lightGrayColor];
    [self.buttonTask setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    [self.buttonTask setTitle:@"添加"
                     forState:UIControlStateNormal];
    [self.buttonTask addTarget:self
                        action:@selector(addTask:)
              forControlEvents:UIControlEventTouchUpInside];
    
    
    self.window.rootViewController = [[UIViewController alloc] init];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    
    [self.window addSubview:self.textFieldTask];
    [self.window addSubview:self.buttonTask];
    [self.window addSubview:self.tableViewTask];
    
    
    
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [self.tasks writeToFile:LTYFieldsPath()
                 atomically:YES];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Actions
- (void) addTask:(id)sender
{
    NSString *textFiled = [self.textFieldTask text];
    
    if([textFiled length] == 0){
        return ;
        
    }
    [self.tasks addObject:textFiled];
    
    [self.tableViewTask reloadData];
    
    [self.textFieldTask setText:@""];
    
    [self.textFieldTask resignFirstResponder];
}

#pragma mark -管理表格视图

- (NSInteger) tableView:(UITableView *)tableView
  numberOfRowsInSection:(NSInteger)section
{
    return [self.tasks count];
}

- (UITableViewCell *) tableView:(UITableView *)tableView
          cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *tableCell = [self.tableViewTask dequeueReusableCellWithIdentifier:@"Cell"];
    
    NSString *item = [self.tasks objectAtIndex:indexPath.row];
    tableCell.textLabel.text = item;
    return tableCell;
}

@end
