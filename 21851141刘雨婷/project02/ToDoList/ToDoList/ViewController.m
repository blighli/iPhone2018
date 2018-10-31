//
//  ViewController.m
//  ToDoList
//
//  Created by abby on 2018/10/30.
//  Copyright © 2018 abby. All rights reserved.
//

#import "ViewController.h"

NSString *SaveToPath()
{
    NSArray *path_list =NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory,NSUserDomainMask,YES);
    return [[path_list objectAtIndex:0]stringByAppendingPathComponent:@"data.txt"];
}
@interface ViewController ()

@end

@implementation ViewController


-(void)AddTask:(id)sender
{
    NSString *text = [task_field text];
    if([text isEqualToString:@""])
    {
        return;
    }
    [tasks addObject:text];
    [task_table reloadData];
    [task_field setText:@""];
    [task_field resignFirstResponder];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if([tasks count]==0)
    {
        [tasks addObject:@"吃饭"];
        [tasks addObject:@"睡觉"];
        [tasks addObject:@"写代码"];
    }
    return [tasks count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [task_table dequeueReusableCellWithIdentifier:@"cell"];
    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:@"Cell"];
    }
    NSString *item = [tasks objectAtIndex:[indexPath row]];
    [[cell textLabel] setText:item];
    return cell;
}


- (void)viewDidLoad {
    NSArray *plist = [NSArray arrayWithContentsOfFile:SaveToPath()];
    if(plist)
    {
        tasks = [plist mutableCopy];
    }
    else
    {
        tasks = [[NSMutableArray alloc]init];
    }
    CGRect table_frame = CGRectMake(0, 80, 320, 380);
    CGRect field_frame = CGRectMake(20, 40, 200, 31);
    CGRect button_frame =CGRectMake(228, 40, 72, 31);
    task_table = [[UITableView alloc]initWithFrame:table_frame
                                             style:UITableViewStylePlain];
    [task_table setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [task_table setDataSource:self];
    task_field = [[UITextField alloc]initWithFrame:field_frame];
    [task_field setBorderStyle:UITextBorderStyleRoundedRect];
    [task_field setPlaceholder:@"今天想做..."];
    insert_button= [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [insert_button setFrame:button_frame];
    [insert_button setTitle:@"增加" forState:UIControlStateNormal];
    [insert_button addTarget:self action:@selector(AddTask:) forControlEvents:UIControlEventTouchUpInside];
    [[self view] addSubview:task_table];
    [[self view] addSubview:task_field];
    [[self view] addSubview:insert_button];
    [[self view] setBackgroundColor:[UIColor whiteColor]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
