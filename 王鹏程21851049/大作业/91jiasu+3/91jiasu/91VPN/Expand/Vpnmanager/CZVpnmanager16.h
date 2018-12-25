//
//  CZVpnmanager16.h
//  91VPN
//
//  Created by weichengzong on 2017/11/8.
//  Copyright © 2017年 weichengzong. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, ConfigVpnAction) {
    ConfigVpnConnecting,
    ConfigVpnConneced,
    ConfigVpnDisconnecting,
    ConfigVpnDisconnected,
    ConfigVpnInvalid,
    ConfigVpnReasserting,
    shibaipeizhi
};
extern NSString *ConfigVPNStatusChangeNotification;

@interface CZVpnmanager16 : NSObject

@property (nonatomic, assign) ConfigVpnAction status;
@property (nonatomic, strong) NSString *vpnUserName;
@property (nonatomic, strong) NSString *vpnUserpwd;
@property (nonatomic, strong) NSString *severAddress;
@property (nonatomic, strong) NSString *remoteIdentifier;

+ (instancetype)shareManager;
- (void)connectVPN;
- (void)disconnectVPN;
- (void)connected:(void (^)(BOOL connected))completion;//需要异步读取VPN是否连接的状态

@end
