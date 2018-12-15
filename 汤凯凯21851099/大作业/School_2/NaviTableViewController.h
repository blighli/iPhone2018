//
//  NaviTableViewController.h
//  游园
//
//  Created by Ray on 15/12/3.
//  Copyright © 2015年 Ray. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface NaviTableViewController : UITableViewController <UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *data;
    NSMutableArray *filterData;
    UISearchDisplayController *searchDisplayController;
    UISearchBar *searchBar;
}
@end
