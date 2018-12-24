//
//  AppDelegate.m
//  School_2
//
//  Created by 汤凯凯 on 15/12/5.
//  Copyright © 2015年 TomKK All rights reserved.
//

#import "AppDelegate.h"
#import <Parse/Parse.h>
#import <AMapNaviKit/MAMapKit.h>
#import <AMapNaviKit/AMapNaviKit.h>


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.i = 0;
    [MAMapServices sharedServices].apiKey = @"833bb9fff4fcbb9d36c81c156fe7b368";
    [AMapNaviServices sharedServices].apiKey =@"833bb9fff4fcbb9d36c81c156fe7b368";
    
    // [Optional] Power your app with Local Datastore. For more info, go to
    // https://parse.com/docs/ios_guide#localdatastore/iOS
    [Parse enableLocalDatastore];
    
    // Initialize Parse.
    [Parse setApplicationId:@"DDKv3CQyUlfjdt4DFqOJISgxiPndF2d7w0kAgO71"
                  clientKey:@"tL15fhoWtOzRumoWVpDi4GsDarKmmkmbyzlhq60f"];
    
    // [Optional] Track statistics around application opens.
    
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    //[[NSUserDefaults standardUserDefaults] synchronize];
    NSString *userName = [[NSUserDefaults standardUserDefaults]stringForKey:@"user_name"];
    //[[NSUserDefaults standardUserDefaults] synchronize];
    if (userName != nil) {
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *main = [storyBoard instantiateViewControllerWithIdentifier:@"MainViewController"];
        UINavigationController *mainNav =[[UINavigationController alloc]initWithRootViewController:main];
        self.window.rootViewController = mainNav;
    
    }

 
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
