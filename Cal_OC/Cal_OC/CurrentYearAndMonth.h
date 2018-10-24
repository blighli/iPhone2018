//
//  CurrentYearAndMonth.h
//  Cal_OC
//
//  Created by Xia Wei on 2018/10/24.
//  Copyright © 2018 Xia Wei. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CurrentYearAndMonth : NSObject

@property(nonatomic,assign)int year;
@property(nonatomic,assign)int month;

-(instancetype)init;

@end

NS_ASSUME_NONNULL_END
