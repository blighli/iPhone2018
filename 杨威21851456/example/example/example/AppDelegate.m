//
//  AppDelegate.m
//  example
//
//  Created by 杨威 on 2018/12/11.
//  Copyright © 2018年 杨威. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "LocationViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    NSString *configContent = [self getFile:@"config.cfg"];
    NSDictionary *configDic = [self dictionaryWithJsonString:configContent];
    NSString *amapKey=[configDic objectForKey:@"AMapKey"];
    
    [AMapServices sharedServices].apiKey =amapKey;
    [AMapServices sharedServices].enableHTTPS = YES;
    
    
    CGRect windowFrame =[[UIScreen mainScreen]bounds];
    UIWindow *theWindow = [[UIWindow alloc]initWithFrame:windowFrame];
    [self setWindow:theWindow];
    
    UIViewController *controller = [[ViewController alloc]init];
    
    self.window.rootViewController  = [[UINavigationController alloc] initWithRootViewController:controller];
    [[self window]setBackgroundColor:[UIColor whiteColor]];
    [[self window]makeKeyAndVisible];

    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
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

-(NSString*) pathForBundleResource:(NSString*)path{
    NSString *bundlePath = [[NSBundle mainBundle] resourcePath];
    NSString *directoryStr = [NSString stringWithFormat:@"%@/%@", bundlePath, path];
    return directoryStr;
}

-(NSString*) getFile:(NSString *)fileName{
    NSString* pfile = nil;
    NSString *filepath = [self pathForBundleResource:fileName];
    pfile = [NSString stringWithContentsOfFile:filepath encoding:NSUTF8StringEncoding error:NULL];
    if (pfile == nil) {
        pfile = [NSString stringWithContentsOfFile:filepath encoding:NSASCIIStringEncoding error:NULL];
    }
    return pfile;
}

- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err)
    {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

@end
