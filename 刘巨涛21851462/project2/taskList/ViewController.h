//
//  ViewController.h
//  taskList
//
//  Created by Jutao on 2018/11/2.
//  Copyright © 2018 Jutao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

- (void)saveTask;
- (void)loadTask;

@end

