//
//  ViewController.h
//  tasklist
//
//  Created by dxy on 2018/10/28.
//  Copyright © 2018年 dxy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Store.h"

@interface ViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray  *taskList;
    Store *store;
}
@end

