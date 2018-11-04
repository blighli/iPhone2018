//
//  ViewController.h
//  ToDoList
//
//  Created by abby on 2018/10/30.
//  Copyright © 2018 abby. All rights reserved.
//

#import <UIKit/UIKit.h>
NSString *SaveToPath(void);
@interface ViewController : UIViewController
{
    
    UITableView *task_table;
    UITextField *task_field;
    UIButton *insert_button;
    NSMutableArray *tasks;
    
}
-(void)AddTask:(id)sender;
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:
(NSIndexPath *)indexPath;

@end
