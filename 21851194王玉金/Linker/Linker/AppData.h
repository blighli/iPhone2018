//
//  AppData.h
//  Linker
//
//  Created by 王玉金 on 2018/12/1.
//  Copyright © 2018年 yujin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppData : NSObject

@property (strong) NSString* graphApiUrlString;
@property (strong) NSString* authority;
@property (strong) NSString* clientId;
@property (strong) NSString* resourceId;
@property (strong) NSString* redirectUriString;
@property (strong) NSString* apiversion;
@property (strong) NSString* tenant;
@property (strong) NSString* secret;

+(id) getInstance;

@end
