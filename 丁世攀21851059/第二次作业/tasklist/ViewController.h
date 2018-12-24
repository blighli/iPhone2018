//
//  ViewController.h
//  tasklist
//
//  Created by ding on 2018/10/29.
//  Copyright © 2018年 ding. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITextField *taskTextField;
@property (weak, nonatomic) IBOutlet UITableView *taskTableView;

@property (strong, nonatomic) NSMutableArray* tasks;
- (NSString *)getFilePath;
- (void) saveData : (NSNotification* ) notification;
@end

