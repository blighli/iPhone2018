

#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import "Model.h"

@interface DateOperateController : NSObject{
    sqlite3 *db;
};
- (void)openSqlite;
- (void)createTable;
- (void)addItem:(NSListItem*)nsli;
- (void)delete:(NSListItem*)nsli;
- (void)deleteall;
- (void)updataWithItem:(NSListItem*)nsli;
- (NSMutableArray*)selectWithAll;
- (NSInteger*)selectCounts;
- (void)closeSqlite;
@end
