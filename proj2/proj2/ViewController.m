//
//  ViewController.m
//  proj2
//
//  Created by 叶晨宇 on 2018/10/30.
//  Copyright © 2018 叶晨宇. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (nonatomic)NSMutableArray *array;
@end

@implementation ViewController
@synthesize textField;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.textField.borderStyle=UITextBorderStyleRoundedRect;
    self.textField.placeholder=@"Type a task,tap to insert...";
    self.array=[[NSMutableArray alloc]init];
    self.btn.layer.borderWidth=2.0f;
    self.btn.layer.cornerRadius=5.0;
    
}

- (IBAction)Insert:(id)sender {
    NSString *s=textField.text;
    NSString *__s= [s stringByReplacingOccurrencesOfString:@" " withString:@""];
    if(s.length!=0&&__s.length!=0){
        [self.array addObject:s];
        [self.table reloadData];
        self.textField.text=@"";
    }
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.array count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
    if(cell==nil){
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.textLabel.text=_array[indexPath.row];
    return cell;
}

@end
