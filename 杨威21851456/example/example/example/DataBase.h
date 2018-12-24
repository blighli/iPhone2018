//
//  DataBase.h
//  在线学习平台
//
//  Created by Xia Wei on 17/5/7.
//  Copyright © 2017年 Xia Wei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"

@interface DataBase : NSObject

+(instancetype)sharedDataBase;
- (void)deleteTable:(NSString*)tablename;
- (void)addUser:(UserModel *)user;
- (void)deleteUser:(UserModel *)user;
- (NSInteger)checkUser:(UserModel *)user;
- (void)printSqlUserTable;
- (void)deleteAllFromTable:(NSString*)tablename;
- (NSString *)getUserNickName:(NSInteger)ID;

@end
