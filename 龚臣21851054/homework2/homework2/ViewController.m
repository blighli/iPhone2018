//
//  ViewController.m
//  homework2
//
//  Created by Gc on 2018/10/25.
//  Copyright © 2018年 Gc. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource>
@property (nonatomic,weak) IBOutlet UITableView *table;
@property (nonatomic,weak) IBOutlet UITextField *inputArea;
@property (nonatomic,weak) IBOutlet UIButton *button;
@property NSMutableArray *array;
//@property NSString *datPath;
@end

@implementation ViewController

-(instancetype)initWithNibName:(NSString *)nibNameOrNil
                        bundle:(nullable NSBundle *)nibBundleOrNil{
    self =[super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self){
        self.array=[NSMutableArray array];
    }
    return self;
}

-(IBAction)insert:(id)sender
{
    NSString *text=[_inputArea text];
    if([text isEqualToString:@""]){
        return;
    }

    [self.array addObject:text];
    [self.array writeToFile:@"/Users/gc/Desktop/xproject/data.txt" atomically:YES];
    //[self.array writeToFile:self.datPath atomically:YES];
    [self.table reloadData];
    _inputArea.text=@"";

}

-(NSInteger)tableView:(UITableView *)tableView
numberOfRowsInSection:(NSInteger)section{
    return [self.array count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView
cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"
                                                          forIndexPath:indexPath];
    cell.textLabel.text=(NSString *)[self.array objectAtIndex:[indexPath row]];
    return cell;
}


- (void)viewDidLoad {
    //NSBundle *bundle=[NSBundle mainBundle];
    //self.datPath=[bundle pathForResource:@"data" ofType:@"txt"];
    [super viewDidLoad];
    self.table.dataSource=self;
    [self.table registerClass:[UITableViewCell class]
       forCellReuseIdentifier:@"UITableViewCell"];
    self.array=[NSMutableArray arrayWithContentsOfFile:@"/Users/gc/Desktop/xproject/data.txt"];
    //self.array=[NSMutableArray arrayWithContentsOfFile:self.datPath];
    [self.table reloadData];
    // Do any additional setup after loading the view from its nib.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
