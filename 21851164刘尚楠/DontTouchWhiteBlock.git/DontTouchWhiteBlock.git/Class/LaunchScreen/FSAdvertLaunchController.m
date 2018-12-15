//
//  FSAdvertLaunchController.m
//  Nitrogen
//
//  Created by czy on 2018/12/11.
//  Copyright © 2018年 czy. All rights reserved.
//

#import "FSAdvertLaunchController.h"
#import "FSAdvertService.h"
#import "FSLaunchScreenView.h"

@interface FSAdvertLaunchController ()

@property (nonatomic, strong) UIWindow *window;

@end

@implementation FSAdvertLaunchController

@def_singleton(FSAdvertLaunchController);

+ (void)load
{
    [self sharedInstance];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        // 应用启动
        [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidFinishLaunchingNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
            // 要等DidFinished方法结束后才能初始化UIWindow，不然会检测是否有rootViewController
             [self showAdLaunchScreen];
        }];
    }
    return self;
}

- (void)showAdLaunchScreen
{
    FSLaunchScreenView *launchView = [app.advert setUpLaunchScreenView];
    if ( launchView == nil ) {
        return;
    }
    
    [launchView setLaunchComplete:^(NSString *skipUrlString) {
        if ( skipUrlString.length == 0 ) {
            [self hideAdLaunchScreen];
        } else {
            [self hideAdLaunchScreen];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
            });
        }
    }];
    
    UIWindow *window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    window.rootViewController = [UIViewController new];
    window.backgroundColor = [UIColor clearColor];
    window.windowLevel = UIWindowLevelAlert + 1;
    window.hidden = NO;
    [window addSubview:launchView];
    
    self.window = window;
    
    // fetch leancloud
}

- (void)hideAdLaunchScreen
{
    [UIView animateWithDuration:0.3 animations:^{
        self.window.alpha = 0;
    } completion:^(BOOL finished) {
        self.window.hidden = YES;
        self.window = nil;
    }];
}

@end
