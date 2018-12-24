//
//  UserSingleton.m
//  在线学习平台
//
//  Created by Xia Wei on 17/5/7.
//  Copyright © 2017年 Xia Wei. All rights reserved.
//

#import "UserSingleton.h"
#import "UserModel.h"
#import "DataBase.h"

static UserSingleton* _userSingleton = nil;

@implementation UserSingleton

+(instancetype)sharedUser{
    
    if (_userSingleton == nil) {
        
        _userSingleton = [[UserSingleton alloc] init];
                
    }
    return _userSingleton;
}

- (void)setUser:(UserModel*)user{
    self.nickName = [[DataBase sharedDataBase]getUserNickName:user.userID];
    self.user_id = user.userID;
    self.user_name = user.userName;
    self.password = user.password;
}



@end
