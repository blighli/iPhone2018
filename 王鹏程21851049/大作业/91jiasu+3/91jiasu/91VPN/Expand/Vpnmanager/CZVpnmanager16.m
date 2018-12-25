//
//  CZVpnmanager16.m
//  91VPN
//
//  Created by weichengzong on 2017/11/8.
//  Copyright © 2017年 weichengzong. All rights reserved.
//

#import "CZVpnmanager16.h"
#import <NetworkExtension/NEVPNManager.h>
#import <NetworkExtension/NEVPNProtocolIPSec.h>
#import <NetworkExtension/NetworkExtension.h>

NSString *ConfigVPNStatusChangeNotification = @"ConfigVPNStatusChangeNotification";

@implementation CZVpnmanager16

//从Keychain取密码对应的key
#define kPasswordReference @"passwordReferencess"


+ (instancetype)shareManager{
    static CZVpnmanager16 *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[CZVpnmanager16 alloc] init];
    });
    return manager;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NEVPNStatusDidChangeNotification object:nil];
}
- (instancetype) init{
    if (self = [super init]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(VPNStatusDidChangeNotification:) name:NEVPNStatusDidChangeNotification object:nil];
    }
    return self;
}

- (void)setVpnUserpwd:(NSString *)vpnUserpwd{
    _vpnUserpwd = vpnUserpwd;
    [self deleteKeychainItem:kPasswordReference];
    [self addKeychainItem:kPasswordReference password:self.vpnUserpwd];
}
- (void)connected:(void (^)(BOOL))completion
{
    [[NEVPNManager sharedManager] loadFromPreferencesWithCompletionHandler:^(NSError *error){
        if (!error)
        {
            completion([self connected]);
        }
        else
        {
            completion(NO);
        }
    }];
}
- (BOOL)connected
{
    return (NEVPNStatusConnected == [[NEVPNManager sharedManager] connection].status);
}

- (void)connectVPN{
    [self connectVPNfixProfile:YES];
}
//连接VPN fix==YES 写入本地
- (void)connectVPNfixProfile:(BOOL)fix
{
    [[NEVPNManager sharedManager] loadFromPreferencesWithCompletionHandler:^(NSError *error){
        if (!error)
        {
            //配置IKEV2 参数
            [self setupIKEv2];
            [[NEVPNManager sharedManager]saveToPreferencesWithCompletionHandler:^(NSError * _Nullable error) {
                if (!error) {
                    //保存成功
                    NSLog(@"成功保存");
                    NSError *intererror;
                    [[NEVPNManager sharedManager].connection startVPNTunnelAndReturnError:&intererror];
                    if (intererror &&fix) {
                        ///连接失败
                        NSLog(@"Start error: %@", error.localizedDescription);
                        [self performSelector:@selector(connectVPNfixProfile:) withObject:0 afterDelay:0];
                    }else{
                        ///连接成功
                        NSLog(@"Connection established!");
                    }
                }else{
                    //保存失败
                    NSLog(@"保存失败");
                    if (fix && iGetSystemVersion() > 8)
                    {
                        [self performSelector:@selector(connectVPNfixProfile:) withObject:0 afterDelay:0];
                    }
                }
            }];
        }else{
            ///加载配置失败
            NSLog(@"配置失败");
            self.status = shibaipeizhi;
            [[NSNotificationCenter defaultCenter] postNotificationName:ConfigVPNStatusChangeNotification object:self];
        }
    }];
}
float iGetSystemVersion()
{
    return [[[UIDevice currentDevice] systemVersion] floatValue];
}
#pragma mark - VPNConfig
- (void)setupIKEv2{
    
    NEVPNProtocolIKEv2* ikev = [[NEVPNProtocolIKEv2 alloc] init];
    ikev.certificateType = NEVPNIKEv2CertificateTypeRSA;
    ikev.authenticationMethod = NEVPNIKEAuthenticationMethodCertificate;
    ikev.useExtendedAuthentication = YES;
    ikev.disconnectOnSleep = NO;
    
    ikev.username = _vpnUserName;
    ikev.passwordReference = [self searchKeychainCopyMatching:kPasswordReference];
    ikev.serverAddress = _severAddress;
    ikev.remoteIdentifier = _remoteIdentifier;
    
    [[NEVPNManager sharedManager] setEnabled:YES];
    [[NEVPNManager sharedManager] setProtocol:ikev];
    [[NEVPNManager sharedManager] setOnDemandEnabled:NO];
    [[NEVPNManager sharedManager] setLocalizedDescription:@"91加速器PRO"];
}

- (void)disconnectVPN
{
    [[NEVPNManager sharedManager] loadFromPreferencesWithCompletionHandler:^(NSError *error){
        if (!error)
        {
            [[NEVPNManager sharedManager].connection stopVPNTunnel];
        }
    }];
}

//获取VPN连接状态改变的通知
- (void)VPNStatusDidChangeNotification:(id)error
{
    switch ([NEVPNManager sharedManager].connection.status)
    {
        case NEVPNStatusInvalid:
        {
            NSLog(@"NEVPNStatusInvalid 连接无效");
            self.status = ConfigVpnInvalid;
            [[NSNotificationCenter defaultCenter] postNotificationName:ConfigVPNStatusChangeNotification object:self];
            break;
        }
        case NEVPNStatusDisconnected:
        {
            NSLog(@"NEVPNStatusDisconnected 已经断开");
            self.status = ConfigVpnDisconnected;
            [[NSNotificationCenter defaultCenter] postNotificationName:ConfigVPNStatusChangeNotification object:self];
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            break;
        }
        case NEVPNStatusConnecting:
        {
            NSLog(@"NEVPNStatusConnecting 正在连接");
            self.status = ConfigVpnConnecting;
            [[NSNotificationCenter defaultCenter] postNotificationName:ConfigVPNStatusChangeNotification object:self];
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
            break;
        }
        case NEVPNStatusConnected:
        {
            NSLog(@"NEVPNStatusConnected 已经连接");
            self.status = ConfigVpnConneced;
            [[NSNotificationCenter defaultCenter] postNotificationName:ConfigVPNStatusChangeNotification object:self];
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            break;
        }
        case NEVPNStatusReasserting:
        {
            NSLog(@"NEVPNStatusReasserting 正在断言");
            self.status = ConfigVpnReasserting;
            [[NSNotificationCenter defaultCenter] postNotificationName:ConfigVPNStatusChangeNotification object:self];
            break;
        }
        case NEVPNStatusDisconnecting:
        {
            NSLog(@"NEVPNStatusDisconnecting 正在断开");
            self.status = ConfigVpnDisconnecting;
            [[NSNotificationCenter defaultCenter] postNotificationName:ConfigVPNStatusChangeNotification object:self];
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
            break;
        }
            
        default:
            break;
    }
}

//获取Keychain里的对应密码
- (NSData *)searchKeychainCopyMatching:(NSString *)identifier
{
    NSMutableDictionary *searchDictionary = [[NSMutableDictionary alloc] init];
    
    NSData *encodedIdentifier = [identifier dataUsingEncoding:NSUTF8StringEncoding];
    
    searchDictionary[(__bridge id)kSecClass] = (__bridge id)kSecClassGenericPassword;
    //    searchDictionary[(__bridge id)kSecAttrGeneric] = encodedIdentifier;
    searchDictionary[(__bridge id)kSecAttrAccount] = encodedIdentifier;
    searchDictionary[(__bridge id)kSecAttrService] = encodedIdentifier;
    searchDictionary[(__bridge id)kSecMatchLimit] = (__bridge id)kSecMatchLimitOne;
    searchDictionary[(__bridge id)kSecReturnPersistentRef] = @YES;//这很重要
    searchDictionary[(__bridge id)kSecAttrSynchronizable] = @NO;
    
    CFTypeRef result = NULL;
    SecItemCopyMatching((__bridge CFDictionaryRef)searchDictionary, &result);
    return (__bridge NSData *)result;
}
//插入密码到Keychain
- (void)addKeychainItem:(NSString *)identifier password:(NSString*)password
{
    NSData *passData = [password dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableDictionary *searchDictionary = [[NSMutableDictionary alloc] init];
    
    NSData *encodedIdentifier = [identifier dataUsingEncoding:NSUTF8StringEncoding];
    
    searchDictionary[(__bridge id)kSecClass] = (__bridge id)kSecClassGenericPassword;
    //         searchDictionary[(__bridge id)kSecAttrGeneric] = encodedIdentifier;
    searchDictionary[(__bridge id)kSecAttrAccount] = encodedIdentifier;
    searchDictionary[(__bridge id)kSecAttrService] = encodedIdentifier;
    searchDictionary[(__bridge id)kSecValueData] = passData;
    searchDictionary[(__bridge id)kSecAttrSynchronizable] = @NO;
    ;
    
    CFTypeRef result = NULL;
    OSStatus status = SecItemAdd((__bridge CFDictionaryRef)(searchDictionary), &result);
    if (status != noErr)
    {
        NSLog(@"Keychain插入错误!");
        
    }
}
//删除Keychain里的对应密码
- (void)deleteKeychainItem:(NSString *)identifier
{
    NSMutableDictionary *searchDictionary = [[NSMutableDictionary alloc] init];
    
    NSData *encodedIdentifier = [identifier dataUsingEncoding:NSUTF8StringEncoding];
    
    searchDictionary[(__bridge id)kSecClass] = (__bridge id)kSecClassGenericPassword;
    //    searchDictionary[(__bridge id)kSecAttrGeneric] = encodedIdentifier;
    searchDictionary[(__bridge id)kSecAttrAccount] = encodedIdentifier;
    searchDictionary[(__bridge id)kSecAttrService] = encodedIdentifier;
    searchDictionary[(__bridge id)kSecAttrSynchronizable] = @NO;
    
    OSStatus status = SecItemDelete((__bridge CFDictionaryRef)searchDictionary);
    if (status != noErr)
    {
        //        //NSLog(@"Keychain插入错误!");
    }
}

@end
