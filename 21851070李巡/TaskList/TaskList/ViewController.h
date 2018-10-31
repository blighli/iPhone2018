//
//  ViewController.h
//  TaskList
//
//  Created by 之川 on 2018/10/27.
//  Copyright © 2018 LX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UIButton *addBtn;
@property (strong, nonatomic) IBOutlet UITextField *taskInput;
@property (strong, nonatomic) IBOutlet UITableView *taskList;

- (IBAction)add:(id)sender;

@end

