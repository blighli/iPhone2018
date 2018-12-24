//
//  BHAppPackageManager.m
//  Pods
//
//  Created by czy on 2018/12/5.
//
//

#import "BHAppPackage.h"

BHAppPackage *app = nil;

@implementation BHAppPackage

@def_singleton(BHAppPackage);

+ (void)load
{
    app = [self sharedInstance];
}

- (NSString *)version
{
    return [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"];
}

- (NSString *)buildVersion
{
    return [[NSBundle mainBundle] infoDictionary][@"CFBundleVersion"];
}

@end
