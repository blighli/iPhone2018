//
//  JITTableViewController.m
//  JITTaskList
//
//  Created by JuicyITer on 31/10/2018.
//  Copyright © 2018 JuicyITer. All rights reserved.
//

#import "JITTableViewController.h"
#import "JITTaskStore.h"
#import <UserNotifications/UserNotifications.h>

@interface JITTableViewController ()
@property (nonatomic, strong)IBOutlet UIView *headerView;
@property (nonatomic, strong)IBOutlet UITextField *textInput;
@property (nonatomic, strong)IBOutlet UIButton *addButton;
@property (nonatomic, strong)IBOutlet UIButton *editButton;
@end

@implementation JITTableViewController

- (void)message
{
    NSString *identifier = @"test";
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    content.title = [NSString localizedUserNotificationStringForKey:@"Cheers!"
                                                          arguments:nil];
    content.sound = [UNNotificationSound defaultSound];
    content.body = @"Thanks for using me 😘";
    UNTimeIntervalNotificationTrigger *trigger =
    [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:1
                                                       repeats:NO];
    
    
    UNNotificationRequest *request = [UNNotificationRequest
                                      requestWithIdentifier:identifier
                                      content:content
                                      trigger:trigger];
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    [center addNotificationRequest:request
             withCompletionHandler:^(NSError * _Nullable error) {
                 if (error != nil) {
                     NSLog(@"Something went wrong: %@",error);
                 }
             }];
}
- (UIView *)headerView
{
    if(!_headerView){
        [[NSBundle mainBundle] loadNibNamed:@"headerView"
                                      owner:self
                                    options:nil];
    }
    return _headerView;
}

- (IBAction)toggleEditMode:(id)sender
{
    if(self.isEditing){
        [sender setTitle:@"Edit" forState:UIControlStateNormal];
        
        [self setEditing:NO animated:YES];
    }
    else{
        
        [sender setTitle:@"OK" forState:UIControlStateNormal];
        
        [self setEditing:YES animated:YES];
        
    }
}
- (IBAction)buttonTapped:(id)sender
{
   
    self.textInput.enabled = NO;
    NSString *name = self.textInput.text;
    if([name length] > 0){
        JITTaskItem *item = [[JITTaskStore sharedStore] createItemWithName:name];
        NSInteger lastRow = [[[JITTaskStore sharedStore] allTasks] indexOfObject:item];
    
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:lastRow inSection:0];
        
        [self.tableView insertRowsAtIndexPaths:@[indexPath]
                              withRowAnimation:UITableViewRowAnimationTop];
        self.textInput.placeholder = @"Tap Me and Add";
        self.textInput.layer.borderWidth = 0;
    }
    else{
        self.textInput.placeholder = @"Here is empty!";
        self.textInput.layer.borderColor = [[UIColor redColor] CGColor];
        self.textInput.layer.borderWidth = 1.0;
    }
    
    self.textInput.text = nil;
    self.addButton.enabled = NO;
    self.textInput.enabled = YES;
    if([[JITTaskStore sharedStore].allTasks count] > 0)
        self.editButton.enabled = YES;
}

- (IBAction)textFieldTapped:(id)sender
{
    self.textInput.layer.borderColor = [[UIColor blueColor] CGColor];
    
    self.textInput.layer.borderWidth = 1.0;
    
    self.textInput.clearButtonMode = YES;
    
    self.addButton.enabled = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard:)];
    
    [self.tableView addGestureRecognizer:tap];
    
}

- (void)hideKeyboard:(UITapGestureRecognizer *)tap
{
    [tap.view endEditing:YES];
    self.textInput.layer.borderWidth = 0;
    if([self.textInput.text length] == 0)
        self.addButton.enabled = NO;
    else
        self.addButton.enabled = YES;
    [self.tableView removeGestureRecognizer:tap];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class]
           forCellReuseIdentifier:@"UITableViewCell"];
    UIView *header = self.headerView;
    self.textInput.placeholder = @"Tap Me and Add";
    self.textInput.returnKeyType = UIReturnKeyDone;
    self.textInput.clearButtonMode = NO;
    self.textInput.borderStyle = UITextBorderStyleRoundedRect;
    self.textInput.keyboardAppearance = UIKeyboardAppearanceDefault;
    self.addButton.enabled = NO;
    if([[JITTaskStore sharedStore].allTasks count] > 0)
        self.editButton.enabled = YES;
    else
        self.editButton.enabled = NO;
    [self.tableView setTableHeaderView:header];
    self.tableView.keyboardDismissMode = (UIScrollViewKeyboardDismissModeInteractive | UIScrollViewKeyboardDismissModeOnDrag);
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [[JITTaskStore sharedStore] allTasks].count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"
//                                                            forIndexPath:indexPath];
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                                   reuseIdentifier:@"UITableViewCell"];
    NSArray *items = [[JITTaskStore sharedStore] allTasks];
    JITTaskItem *item = items[indexPath.row];
    cell.textLabel.text = item.itemName;
    cell.detailTextLabel.text = [item detail];
    // Configure the cell...
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        NSArray *items = [[JITTaskStore sharedStore] allTasks];
        JITTaskItem *item = items[indexPath.row];
        [[JITTaskStore sharedStore] removeItem:item];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        if([[JITTaskStore sharedStore].allTasks count] == 0){
            self.editButton.enabled = NO;
            [self.editButton setTitle:@"Edit" forState:UIControlStateNormal];
            [self setEditing:NO animated:YES];
        }
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}



// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
    [[JITTaskStore sharedStore] moveItemAtIndex:fromIndexPath.row
                                        toIndex:toIndexPath.row];
}


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
