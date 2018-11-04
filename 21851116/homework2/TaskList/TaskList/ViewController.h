//
//  ViewController.h
//  TaskList
//
//  Created by 张若静 on 2018/10/31.
//  Copyright © 2018年 zhangruojing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITextField *taskField;
@property (weak, nonatomic) IBOutlet UIButton *taskButton;
@property (strong, nonatomic) IBOutlet UITableView *tableview;
@end

