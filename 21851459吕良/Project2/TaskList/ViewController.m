//
//  ViewController.m
//  TaskList
//
//  Created by macos on 2018/10/28.
//  Copyright © 2018 macos. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *taskField;
@property (weak, nonatomic) IBOutlet UITableView *taskTable;
@property(strong,nonatomic) NSMutableArray *taskArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.taskArray = [[NSMutableArray alloc] init];
    [self.taskArray addObject:@"Walk the dog"];
    [self.taskArray addObject:@"Get oil changed"];
    [self.taskArray addObject:@"Wrangle some cows"];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.taskArray.count;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    NSString *item = [self.taskArray objectAtIndex: [indexPath row]];
    [[cell  textLabel] setText:item];
    return cell ;
}

-(IBAction)addTask:(id)sender
{
    NSString *text = [self.taskField text];
    if([text isEqualToString:@""])
    {
        return;
    }
    [self.taskArray addObject:text];
    [self.taskTable reloadData];
    [self.taskField setText:@""];
    [self.taskField resignFirstResponder];
    
}

@end
