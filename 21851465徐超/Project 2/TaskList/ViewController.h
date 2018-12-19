//
//  ViewController.h
//  TaskList
//
//  Created by 徐超 on 2018/10/28.
//  Copyright © 2018 徐超. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITextField *inputTextField;
@property (weak, nonatomic) IBOutlet UITableView *listTableView;
- (IBAction)addButton:(UIButton *)sender;

@property (strong, nonatomic) NSMutableArray *listArr;

@end
