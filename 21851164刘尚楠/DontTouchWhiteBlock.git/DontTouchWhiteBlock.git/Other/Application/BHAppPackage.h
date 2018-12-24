//
//  BHAppPackageManager.h
//  Pods
//
//  Created by czy on 2018/12/5.
//
//

#import <Foundation/Foundation.h>
#import "BHSingleton.h"

@class BHAppPackage;
extern BHAppPackage *app;

#define app_package(__class, __propertyName) \
    class __class; \
    @interface BHAppPackage (__propertyName) \
    @property (nonatomic, readonly) __class *__propertyName; \
    @end

#define def_app_package(__class, __instance, __propertyName) \
    implementation BHAppPackage (__propertyName) \
    - (__class *)__propertyName \
    { \
        return __instance; \
    } \
    @end

@interface BHAppPackage : NSObject
{
}

@singleton(BHAppPackage);

@property (nonatomic, strong, readonly) NSString *version;
@property (nonatomic, strong, readonly) NSString *buildVersion;

@end
