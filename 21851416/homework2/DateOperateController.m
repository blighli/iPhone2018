
#import <Foundation/Foundation.h>
#import "DateOperateController.h"
#import <sqlite3.h>
#import "Model.h"


@implementation DateOperateController

- (void)openSqlite {
    if(db != nil) {
        NSLog(@"数据库已经打开");
        return;
    }
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *strPath = [doc stringByAppendingPathComponent:@"my.sqlite"];


    int result = sqlite3_open([strPath UTF8String], &db);
    if (result == SQLITE_OK){
        NSLog(@"OK");
    }
    else {
        NSLog(@"NOT ERROR %d", result);
    }
}

- (void)createTable {
    
    NSString *sqlite = [NSString stringWithFormat:@"create table if not exists 'Item' ('number' integer primary key autoincrement not null,'name' text)"];
    
    char *error = NULL;
    int result = sqlite3_exec(db, [sqlite UTF8String], nil, nil, &error);
    
    if (result == SQLITE_OK) {
        NSLog(@"OK");
    }
    else {
        NSLog(@"NOT ERROR %d", result);
    }
}


- (void)addItem:(NSListItem*)nsli {
    
    NSString *sqlite = [NSString stringWithFormat:@"insert into Item(name) values ('%@')",nsli.itemName];
    
    char *error = NULL;
    int result = sqlite3_exec(db, [sqlite UTF8String], nil, nil, &error);
    if (result == SQLITE_OK) {
        NSLog(@"添加数据成功");
    } else {
        NSLog(@"添加数据失败");
    }
}

- (void)delete:(NSListItem*)nsli {
    NSString *sqlite = [NSString stringWithFormat:@"delete from Item where number = '%ld'",nsli.itemId];
    char *error = NULL;
    int result = sqlite3_exec(db, [sqlite UTF8String], nil, nil, &error);
    if (result == SQLITE_OK) {
        NSLog(@"删除数据成功");
    } else {
        NSLog(@"删除数据失败%s",error);
    }
}

- (void)deleteall{
    NSString *sqlite = [NSString stringWithFormat:@"delete from Item"];
    char *error = NULL;
    int result = sqlite3_exec(db, [sqlite UTF8String], nil, nil, &error);
    if (result == SQLITE_OK) {
        NSLog(@"删除数据成功");
    } else {
        NSLog(@"删除数据失败%s",error);
    }
    
}

- (void)updataWithItem:(NSListItem*)nsli {
    NSString *sqlite = [NSString stringWithFormat:@"update Item set name = '%@' where number = '%ld'",nsli.itemName,nsli.itemId];
    char *error = NULL;
    int result = sqlite3_exec(db, [sqlite UTF8String], nil, nil, &error);
    if (result == SQLITE_OK) {
        NSLog(@"修改数据成功");
    } else {
        NSLog(@"修改数据失败");
    }
}

- (int)selectCounts{
    
    int counts = 0;
    NSString *sqlite = [NSString stringWithFormat:@"select * from Item"];
    sqlite3_stmt *stmt = NULL;
    int result = sqlite3_prepare(db, sqlite.UTF8String, -1, &stmt, NULL);
    while (sqlite3_step(stmt) == SQLITE_ROW) {
        counts++;
    }
    
    sqlite3_finalize(stmt);
    NSLog(@"%ld",counts);
    return counts;
    
}

//查询所有数据
- (NSMutableArray*)selectWithAll {
    NSMutableArray *array = [[NSMutableArray alloc] init];
    //1.准备sqlite语句
    NSString *sqlite = [NSString stringWithFormat:@"select * from Item"];
    //2.伴随指针
    sqlite3_stmt *stmt = NULL;
    //3.预执行sqlite语句
    int result = sqlite3_prepare(db, sqlite.UTF8String, -1, &stmt, NULL);//第4个参数是一次性返回所有的参数,就用-1
    if (result == SQLITE_OK) {
        NSLog(@"查询成功");
        //4.执行n次
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            NSListItem *nsli = [[NSListItem alloc] init];
            //从伴随指针获取数据,第0列
            nsli.itemId = sqlite3_column_int(stmt, 0);
            //从伴随指针获取数据,第1列
            nsli.itemName = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 1)] ;

            [array addObject:nsli.itemName];
        }
        
    } else {
        NSLog(@"查询失败");
    }
    //5.关闭伴随指针
    sqlite3_finalize(stmt);
    return array;
}

- (void)closeSqlite {
    
    int result = sqlite3_close(db);
    if (result == SQLITE_OK) {
        NSLog(@"数据库关闭成功");
    } else {
        NSLog(@"数据库关闭失败");
    }
}
@end
