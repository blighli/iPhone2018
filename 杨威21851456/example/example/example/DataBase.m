//
//  DataBase.m
//  在线学习平台
//
//  Created by Xia Wei on 17/5/7.
//  Copyright © 2017年 Xia Wei. All rights reserved.
//

#import "DataBase.h"
#import "FMDB.h"
static DataBase *_DBSingleton = nil;

enum AccountState{
    Account_Inexistent = -1,
    Password_incorrect = -2,
};

@interface DataBase(){
    FMDatabase  *_db;
}

@end


@implementation DataBase
+(instancetype)sharedDataBase{
    
    if (_DBSingleton == nil) {
        
        _DBSingleton = [[DataBase alloc] init];
        
        [_DBSingleton initDataBase];
        
    }
    
    return _DBSingleton;
    
}

-(void)initDataBase{
    // 获得Documents目录路径
    
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    // 文件路径
    
    NSString *filePath = [documentsPath stringByAppendingPathComponent:@"model.sqlite"];
    
    // 实例化FMDataBase对象
    
    _db = [FMDatabase databaseWithPath:filePath];
    
    [_db open];
    
    // 初始化数据表
    NSString *userSql = @"CREATE TABLE IF NOT EXISTS 'user' ('user_id' INTEGER PRIMARY KEY AUTOINCREMENT  NOT NULL ,'user_name' VARCHAR(255),'password' VARCHAR(255),'nickName' VARCHAR(255)) ";//用户表
    
    BOOL userRes = [_db executeUpdate:userSql];
    if (userRes)
    {
        NSLog(@"用户表创建成功");
    }
    
    [_db close];
    
}

//增添用户
- (void)addUser:(UserModel *)user{
    [_db open];
    
    NSNumber *maxID = @(0);
    
    FMResultSet *res = [_db executeQuery:@"SELECT * FROM user "];
    //获取数据库中最大的ID
    while ([res next]) {
        if ([maxID integerValue] < [[res stringForColumn:@"user_id"] integerValue]) {
            maxID = @([[res stringForColumn:@"user_id"] integerValue] ) ;
        }
        
    }
    maxID = @([maxID integerValue] + 1);
    BOOL result = [_db executeUpdate:@"INSERT INTO user(user_id,user_name,password,nickName)VALUES(?,?,?,?)",maxID,user.userName,user.password,user.nickName];
    if (result)
    {
        NSLog(@"注册成功成功");
    }
    [_db close];
}

//删除用户
- (void)deleteUser:(UserModel *)user{
    [_db open];
    
    [_db executeUpdate:@"DELETE FROM user WHERE user_id = ?",user.userID];
    
    [_db close];
}


- (void)printSqlUserTable{
    [_db open];
    FMResultSet *res = [_db executeQuery:[NSString stringWithFormat:@"SELECT * FROM user"]];
    while ([res next]) {
        NSLog(@"%@ %@ %@ %@",[res stringForColumn:@"user_id"],[res stringForColumn:@"user_name"],[res stringForColumn:@"password"],[res stringForColumn:@"nickName"]);
    }
    [_db close];
}

//删除表格内容
- (void)deleteAllFromTable:(NSString*)tablename{
    [_db open];
    BOOL res = [_db executeUpdate:[NSString stringWithFormat:@"DELETE FROM %@",tablename]];
    if (res) {
        NSLog(@"删除表格内容成功");
    }
    [_db close];
}

//删除表格
- (void)deleteTable:(NSString*)tablename{
    [_db open];
    BOOL res = [_db executeUpdate:[NSString stringWithFormat:@"DROP TABLE '%@'",tablename]];
    if (res) {
        NSLog(@"删除表格成功");
    }
    [_db close];
}

- (NSString *)getUserNickName:(NSInteger)ID{
    [_db open];
    FMResultSet *res = [_db executeQuery:[NSString stringWithFormat:@"SELECT nickName FROM user where user_id = %ld",(long)ID]];
    if ([res next]) {
        return [res stringForColumn:@"nickName"];
    }
    [_db close];
    return @"随风游世界";
}

//验证用户是否存在
- (NSInteger)checkUser:(UserModel *)user{
    [_db open];
    FMResultSet *res = [_db executeQuery:[NSString stringWithFormat:@"SELECT * FROM user where user_name = '%@'",user.userName]];
    //先判断用户名是否存在
    if ([res next]) {
        user.userID = [[res stringForColumn:@"user_id"]integerValue];
        //密码不正确
        if (![user.password isEqualToString:[res stringForColumn:@"password"]]) {
            return Password_incorrect;
        }
        else
            return user.userID;
    }
    else{
        return Account_Inexistent;
    }
}

@end
