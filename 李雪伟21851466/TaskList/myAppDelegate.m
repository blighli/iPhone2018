//
//  myAppDelegate.m
//  TaskList
//
//  Created by M David on 18-10-29.
//  Copyright (c) 2018年 M David. All rights reserved.
//

#import "myAppDelegate.h"

@implementation myAppDelegate

NSString *docPath(void){
    NSArray *pathList=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [[pathList objectAtIndex:0] stringByAppendingString:@"data.txt"];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    NSArray *plist=[NSArray arrayWithContentsOfFile:docPath()];
    if(plist){
        tasks=[plist mutableCopy];
    }else{
        tasks=[[NSMutableArray alloc] init];
    }
    
    
    //set main window
    UIWindow *mainWindow=[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self setWindow:mainWindow];
    
    //set taskTable view
    CGRect tableFrame=CGRectMake(0, 80, 320, 380);
    taskTable=[[UITableView alloc] initWithFrame:tableFrame style:UITableViewStylePlain];
    [taskTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [taskTable setDataSource:self];
    
    //set taskField view
    CGRect fieldFrame=CGRectMake(20, 40, 200, 31);
    taskField=[[UITextField alloc] initWithFrame:fieldFrame];
    [taskField setPlaceholder:@"Type a task,tap Insert"];
    
    //set insertButton view
    CGRect buttonFrame=CGRectMake(230, 40, 70, 31);
    insertButton=[[UIButton alloc] initWithFrame:buttonFrame];
    [insertButton setTitle:@"Insert" forState:UIControlStateNormal];
    [insertButton addTarget:self action:@selector(addTask:) forControlEvents:UIControlEventTouchUpInside];
    
    
    //add three subview
    [[self window] addSubview:taskTable];
    [[self window] addSubview:taskField];
    [[self window] addSubview:insertButton];
    
    //
    [[self window] setBackgroundColor:[UIColor purpleColor]];
    [[self window] makeKeyAndVisible];
    
    return YES;
}

-(void)applicationDidEnterBackground:(UIApplication *)application
{
    [tasks writeToFile:docPath() atomically:YES];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tasks count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[taskTable dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    NSString *item=[tasks objectAtIndex:[indexPath row]];
    [[cell textLabel] setText:item];
    return cell;
    
}

-(void)addTask:(id)sender
{
    NSString *text=[taskField text];
    if([text isEqualToString:@""]){
        return;
    }
    
    [tasks addObject:text];
    [taskTable reloadData];
    [taskField setText:@""];
    [taskField resignFirstResponder];
    
}


@end
