//
//  KTStopwatch.h
//  My2048
//
//  Created by yang on 2018/11/19.
//  Copyright © 2018 yang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <mach/mach_time.h>
NS_ASSUME_NONNULL_BEGIN

@interface KTStopwatch : NSObject {
    Boolean isRunning;
    bool isUseWallClockTimer;
    double lastElapseTimeInSeconds;
    
    // Fields used by elapse timer.
    double conversionToSeconds;
    uint64_t lastStart;
    uint64_t sum;
    
    // Fields used by wall clock timer.
    NSTimeInterval lastStartTimeInterval;
    NSTimeInterval sumTimeInterval;
}

@property(readonly) Boolean isRunning;

- (id)init;
- (id)initForWallClockTime;
- (void)reset;
- (void)start;
- (void)stop;
- (double)elapsedSeconds;
- (NSString *)elapsedTime;

@end

NS_ASSUME_NONNULL_END
