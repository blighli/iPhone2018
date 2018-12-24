//
//  UserModel.m
//  在线学习平台
//
//  Created by Xia Wei on 17/5/7.
//  Copyright © 2017年 Xia Wei. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

- (id)init:(NSString *)userName password:(NSString *)password{
    self = [super init];
    if (self) {
        self.userName = userName;
        self.password = password;
    }
    return self;
}

@end
