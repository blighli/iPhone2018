//
//  UserSingleton.h
//  在线学习平台
//
//  Created by Xia Wei on 17/5/7.
//  Copyright © 2017年 Xia Wei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"

@interface UserSingleton : NSObject
@property(nonatomic,assign)NSInteger user_id;
@property(nonatomic,strong)NSString* user_name;
@property(nonatomic,strong)NSString* password;
@property(nonatomic,strong)NSString* nickName;
+(instancetype)sharedUser;
- (void)setUser:(UserModel*)user;

@end
