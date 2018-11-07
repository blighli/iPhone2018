//
//  RootViewController.h
//  iostest02
//
//  Created by 贺晨韬 on 2018/10/31.
//  Copyright © 2018 贺晨韬. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import "DateOperateController.h"

NS_ASSUME_NONNULL_BEGIN

@interface RootViewController : UITableViewController<UITableViewDataSource,UITabBarDelegate,UISearchDisplayDelegate,UISearchBarDelegate>{
    NSMutableArray *NSArr;
    NSMutableArray *searchresultarr;
    NSMutableArray *AddedNewItem;
    
    DateOperateController *databaseconn;
    
    IBOutlet UITableView *tbview;
    IBOutlet UISearchBar *searchBar;
    IBOutlet UISearchDisplayController *searchDisplayController;
}
@end

NS_ASSUME_NONNULL_END
