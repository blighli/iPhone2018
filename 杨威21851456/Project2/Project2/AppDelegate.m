//
//  AppDelegate.m
//  Project2
//
//  Created by 杨威 on 2018/10/30.
//  Copyright © 2018年 杨威. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    NSArray *plist =[NSArray arrayWithContentsOfFile:docPath()];
    if(plist){
        tasks = [plist mutableCopy];
    }else{
        tasks = [[NSMutableArray alloc]init];
    }
    if([tasks count]==0){
        [tasks addObject:@"Walk the dogs"];
        [tasks addObject:@"Feed the hogs"];
        [tasks addObject:@"Chop the logs"];
    }
    CGRect windowFrame =[[UIScreen mainScreen]bounds];
    UIWindow *theWindow = [[UIWindow alloc]initWithFrame:windowFrame];
    [self setWindow:theWindow];
    CGRect tableFrame = CGRectMake(0, 80, 320, 380);
    CGRect fieldFrame = CGRectMake(20, 40, 200, 31);
    CGRect buttonFrame = CGRectMake(228, 40, 72, 31);
    taskTable = [[UITableView alloc]initWithFrame:tableFrame style:UITableViewStylePlain];
    [taskTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    taskField = [[UITextField alloc]initWithFrame:fieldFrame];
    [taskField setBorderStyle:UITextBorderStyleRoundedRect];
    [taskField setPlaceholder:@"Type a task,tap Insert"];
    
    
    
    insertButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [insertButton setFrame:buttonFrame];
    [insertButton setTitle:@"Insert" forState:UIControlStateNormal];

    [insertButton addTarget:self action:@selector(addTask:) forControlEvents:UIControlEventTouchUpInside];
    
    UIColor *testColor1= [UIColor colorWithRed:162/255.0 green:162/255.0 blue:162/255.0 alpha:1];
    insertButton.layer.borderWidth =1;
    insertButton.layer.cornerRadius = 5;
    insertButton.layer.borderColor = testColor1.CGColor;
    
    UIViewController *controller = [[UIViewController alloc]init];
    [[self window]setRootViewController:controller];
    
    
    [[self window]setBackgroundColor:[UIColor whiteColor]];
    [[self window]makeKeyAndVisible];
    
    [[self window]addSubview:taskTable];
    [[self window]addSubview:taskField];
    [[self window]addSubview:insertButton];
    
    [taskTable setDataSource:self];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [tasks writeToFile:docPath() atomically:YES];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [tasks writeToFile:docPath() atomically:YES];
}

NSString *docPath(){
    NSArray *pathList = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [[pathList objectAtIndex:0] stringByAppendingPathComponent:@"data.txt"];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [tasks count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [taskTable dequeueReusableCellWithIdentifier:@"Cell"];
    if(!cell){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    NSString *item = [tasks objectAtIndex:[indexPath row]];
    [[cell textLabel]setText:item];
    return cell;
}

-(void)addTask:(id)sender{
    NSString *text =[taskField text];
    if([text isEqualToString:@""]){
        return;
    }
    [tasks addObject:text];
    [taskTable reloadData];
    [taskField setText:@""];
    [taskField resignFirstResponder];
}
@end
