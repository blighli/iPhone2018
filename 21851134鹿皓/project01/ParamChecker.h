//
//  ParamChecker.h
//  Cal
//
//  Created by dawn on 2018/10/20.
//  Copyright © 2018 dawn. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ParamChecker : NSObject

-(BOOL)isCal:(NSString*) arg;
-(BOOL)isNumber:(NSString*) arg;
-(BOOL)is_M:(NSString*) arg;


@end

NS_ASSUME_NONNULL_END
