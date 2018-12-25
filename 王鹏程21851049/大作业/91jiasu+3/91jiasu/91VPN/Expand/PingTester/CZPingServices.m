//
//  CZPingServices.m
//  pingping
//
//  Created by weichengzong on 2017/8/28.
//  Copyright © 2017年 weichengzong. All rights reserved.
//

#import "CZPingServices.h"


@interface CZPingServices()<SimplePingDelegate>
{
    SimplePing *_pinger;
    NSDate *_startDate;
    /// If the Pinger is started
    BOOL _isStarted;
    NSTimer *_timer;
    /// The count of sent packets.
    NSInteger _count;
    NSString *hostname;
}
@property (nonatomic ,strong)void(^pingBack)(NSArray *arr);
@end

@implementation CZPingServices

+ (CZPingServices *)startWithHostName:(NSString * )hostName count:(NSInteger)count pingCallback:(void (^)(NSArray *arr))pingCallback{
    return [[CZPingServices alloc] initWithHostName:hostName count:count pingCallback:pingCallback];
}

- (instancetype)initWithHostName:(NSString *)hostName count:(NSInteger)count pingCallback:(void (^)( NSArray *arr))pingCallback{
    self = [super init];
    if (self) {
        hostname = hostName;
        self.pingBack = pingCallback;
        _pinger = [[SimplePing alloc] initWithHostName:hostName];
        _pinger.delegate =self;
        _count = count;
        _timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(startPinger) userInfo:nil repeats:YES];
        [_timer fire];
    }
    
    return self;
}
- (void)updateResult:(NSString *)format, ...
{
    va_list args;
    
    va_start(args, format);
    NSString *str = [[NSString alloc] initWithFormat:format arguments:args];
//    NSLog(@"%@",str);
    va_end(args);
    NSArray *arr = @[hostname,format];
    self.pingBack(arr);
//    [_result setText:[_result.text stringByAppendingString:str]];
}
- (void)startPinger
{
    assert(_pinger != nil);
    
    if (_isStarted) {
        [self stopPinger:@"Request timeout\n" terminal:NO];
    }
    
    [_pinger start];
    _isStarted = YES;
    
    _count -= 1;
    if (_count <= 0) {
        [_timer invalidate];
    }
}
/**
 * Stop Pinger
 *
 * @param reason   The reason that to stop the Pinger.
 * @param terminal Terminal the Timer or not.
 *
 */
- (void)stopPinger:(NSString *)reason terminal:(BOOL)terminal
{
    assert(_pinger != nil);
    
    if (!_isStarted){
        return;
    }
    
    [_pinger stop];
    _isStarted = NO;
    
    [self updateResult:reason];
    
    if (terminal) {
        [_timer invalidate];
    }
}
- (void) actionTimer
{
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(sendPingData) userInfo:nil repeats:YES];
}

- (void) sendPingData
{
    
    [_pinger sendPingWithData:nil];
    
}
#pragma mark - Simple Ping Delegate

- (void)simplePing:(SimplePing *)pinger didStartWithAddress:(NSData *)address
{
//    NSLog(@"Send data");
    [_pinger sendPingWithData:nil];
//    [self actionTimer];
}

- (void)simplePing:(SimplePing *)pinger didFailWithError:(NSError *)error
{
//    NSLog(@"Failed with error %@", error);
    [self stopPinger:@"Fail to start Ping\n" terminal:YES];
}

- (void)simplePing:(SimplePing *)pinger didSendPacket:(NSData *)packet sequenceNumber:(uint16_t)sequenceNumber
{
    _startDate = [NSDate date];
//    NSLog(@"Packet send successfully");
}

- (void)simplePing:(SimplePing *)pinger didFailToSendPacket:(NSData *)packet sequenceNumber:(uint16_t)sequenceNumber error:(NSError *)error
{
    NSLog(@"Fail to send packet");
    [self stopPinger:@"Fail to send packet\n" terminal:NO];
}

- (void)simplePing:(SimplePing *)pinger didReceivePingResponsePacket:(NSData *)packet sequenceNumber:(uint16_t)sequenceNumber
{
    NSTimeInterval interval = [[NSDate date] timeIntervalSinceDate:_startDate];
//    NSLog(@"Host responsed in %0.2lf ms", interval*1000);
    
    NSString *result = [[NSString alloc] initWithFormat:@"%.lf",interval*1000];
    [self stopPinger:result terminal:NO];
}

- (void)simplePing:(SimplePing *)pinger didReceiveUnexpectedPacket:(NSData *)packet
{
    NSLog(@"Received an unexpected packet");
    [self stopPinger:@"Received an unexpected packet\n" terminal:NO];
}


@end
