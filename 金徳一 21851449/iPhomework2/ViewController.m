//
//  ViewController.m
//  iPhomework2
//
//  Created by 金徳一 on 2018/10/31.
//  Copyright © 2018 Jdy. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDataSource>
{
    NSMutableArray *tasks;
}
@property (strong, nonatomic) IBOutlet UITextField *textIn;
@property (strong, nonatomic) IBOutlet UITableView *textOut;
- (IBAction)insert:(id)sender;
@end


@implementation ViewController

NSString *docPath(){
    NSArray *pathlist=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [[pathlist objectAtIndex:0]stringByAppendingPathComponent:@"tasks.txt"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.textIn setPlaceholder:@"please insert.."];
    NSArray *plist=[NSArray arrayWithContentsOfFile:docPath()];
    if(plist){
        tasks=[plist mutableCopy];
    }
    else {
        tasks=[[NSMutableArray alloc] init];
    }
    [self.textOut setDataSource:self];
}

-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

-(IBAction)insert:(id)sender{
    NSString *input= [self.textIn text];
    [tasks addObject:input];
    [self.textOut reloadData];
    [tasks writeToFile:docPath() atomically:YES];
    [self.textIn setText:@""];
    [self.textIn resignFirstResponder];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cellId";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell==nil){
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.backgroundColor=[UIColor colorWithRed:0 green:10 blue:0 alpha:0.1];
    NSString *word=[tasks objectAtIndex:[indexPath row]]; //读取文件
    [[cell textLabel] setText:word]; //显示
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [tasks count];
}

@end
