//
//  AppDelegate.m
//  iTahDoodle
//
//  Created by shayue on 2018/10/25.
//  Copyright © 2018 shayue. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

NSString *docPath(void)
{
	NSArray *pathList = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory
															, NSUserDomainMask
															, YES);
	return [pathList[0] stringByAppendingString:@"data.td"];
}
@interface AppDelegate ()

@end

@implementation AppDelegate

#pragma mark

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	//6. 空的NSMutableArray
	self.tasks = [NSMutableArray array];
	
	NSArray *plist = [NSArray arrayWithContentsOfFile:docPath()];
	if(plist)
		self.tasks = [plist mutableCopy];
	else
		self.tasks = [NSMutableArray array];
	// 创建并设置UIWindow对象
	// CGRECT是C结构
	CGRect winFrame = [[UIScreen mainScreen] bounds];
	UIWindow *theWindow = [[UIWindow alloc] initWithFrame:winFrame];
	theWindow.backgroundColor = [UIColor blackColor];
	self.window = theWindow;
	
	// root指向ViewController
	self.window.rootViewController = [[ViewController alloc] init];
	
	// 设置三个UI对象的frame属性
	CGRect tableFrame = CGRectMake(0, 80, winFrame.size.width, winFrame.size.height - 175);
	CGRect fiedFrame = CGRectMake(20, 40, 225, 31);
	CGRect buttonFrame = CGRectMake(247, 40, 72, 31);
	
	// 创建并设置UITableView对象
	self.taskTable = [[UITableView alloc] initWithFrame:tableFrame
												  style:UITableViewStylePlain];
	self.taskTable.separatorStyle = UITableViewCellSeparatorStyleNone;
	// 将需要创新的单元格时，告诉UITableView对象队哪个类进行实例化
	self.taskTable.dataSource = self;
	
	// 需要创建新的单元格时，告诉UITablevView对象要实例化哪一个类
	[self.taskTable registerClass:[UITableViewCell class]
		   forCellReuseIdentifier:@"Cell"];
	
	// 创建并设置UITextField对象
	self.taskField = [[UITextField alloc] initWithFrame:fiedFrame];
	self.taskField.borderStyle = UITextBorderStyleRoundedRect;
	self.taskField.placeholder = @"Type a task, tap Insert";
	
	// 创建并设置UIButton对象
	self.insertButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	self.insertButton.frame = buttonFrame;
	
	// 为按钮设置标题
	[self.insertButton setTitle:@"Insert"
					   forState:UIControlStateNormal];
	
	// 	设置Insert按钮的目标-动作对
	[self.insertButton addTarget:self
						  action:@selector(addTasks:)
				forControlEvents:UIControlEventTouchUpInside];
	
	// 将以下三个UI对象加入UIWindow实例
	[self.window.rootViewController.view addSubview:self.taskTable];
	[self.window.rootViewController.view addSubview:self.taskField];
	[self.window.rootViewController.view addSubview:self.insertButton];
	
	// 设置UIWindow实例的背景颜色，并放上屏幕
	self.window.backgroundColor = [UIColor whiteColor];
	[self.window makeKeyAndVisible];
	
	return YES;
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
	return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
	[self.tasks writeToFile:docPath()
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

- (void)addTasks:(id)sender
{
	// 	获取新任务的文字描述
	NSString *text = [self.taskField text];
	
	// 如果没有内容，直接返回
	if([text length] == 0)
		return;
	else
		[self.tasks addObject:text];
	
	//刷新表格视图
	[self.taskTable reloadData];
	
	// 清空taskField
	[self.taskField setText:@""];
	
	// 关闭键盘
	[self.taskField resignFirstResponder];
}

#pragma - 管理表格视图

- (NSInteger)tableView:(UITableView *)tableView
 		numberOfRowsInSection:(NSInteger)section
{
	return [self.tasks count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView
		cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *c = [self.taskTable dequeueReusableCellWithIdentifier:@"Cell"];
	
	NSString *item = [self.tasks objectAtIndex:indexPath.row];
	c.textLabel.text = item;
	return c;
}

@end
