//
//  BHSingleton.h
//  Pods
//
//  Created by czy on 2018/12/5.
//
//

#import <Foundation/Foundation.h>

#undef  singleton
#define singleton(__class) \
    property(nonatomic, readonly) __class * sharedInstance; \
    - (__class *)sharedInstance; \
    + (__class *)sharedInstance;

#undef  def_singleton
#define def_singleton(__class) \
    dynamic sharedInstance; \
    - (__class *)sharedInstance \
    { \
        return [__class sharedInstance]; \
    } \
    + (__class *)sharedInstance \
    { \
        static dispatch_once_t once; \
        static __strong id __singleton__ = nil; \
        dispatch_once(&once, ^{ __singleton__ = [[__class alloc] init]; }); \
        return __singleton__; \
    }

@interface BHSingleton : NSObject

@end
