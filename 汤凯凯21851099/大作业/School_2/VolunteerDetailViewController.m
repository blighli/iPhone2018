//
//  VolunteerDetailViewController.m
//  School_2
//
//  Created by Ray on 15/12/14.
//  Copyright © 2015年 TomKK All rights reserved.
//

#import "VolunteerDetailViewController.h"

@implementation VolunteerDetailViewController

-(void)viewDidLoad
{    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    _headImage.image = app.headImage;
    _nameLabel.text = app.name;
    _wordLabel.text = app.words;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [_headImage.layer setMasksToBounds:YES];
    [_headImage.layer setCornerRadius:46];
    //[self.view bringSubviewToFront:_touxiang];
    
    
    //杨靖
    if ([_nameLabel.text  isEqual: @"杨靖"]) {
        _hobby.text = @"吃";
        _personality.text = @"温柔";
    }
    else if([_nameLabel.text  isEqual: @"陈枭磊"])
    {
        _hobby.text = @"Clash of clans";
        _personality.text = @"狂躁";
    }
    
    //添加通话按钮
    UIBarButtonItem *btn = [[UIBarButtonItem alloc]initWithTitle:@"呼叫志愿者" style:UIBarButtonItemStylePlain target:self action:@selector(btnTap)];
    self.navigationItem.rightBarButtonItem = btn;
    self.navigationItem.title = @"呼叫志愿者";
}

-(void)btnTap
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"是否呼叫志愿者" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"tel://123456789"]];
        [[UIApplication sharedApplication] openURL:URL];
        
        //延时执行
        [self performSelector:@selector(evaluateVolunteer) withObject:nil afterDelay:3];
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleDestructive handler:nil];
    [alert addAction:action];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)evaluateVolunteer
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"是否预约成功" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //呼叫成功要做什么
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleDestructive handler:nil];
    [alert addAction:action];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *VolunteerDetailTableCell = @"VolunteerDetailTableCell";
    VolunteerDetialTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:VolunteerDetailTableCell];
    
    if (cell == nil) {
        cell = [[VolunteerDetialTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:VolunteerDetailTableCell];
    }
    if ([_nameLabel.text  isEqual: @"杨靖"]) {
        cell.imageView2.image = [UIImage imageNamed:@"曹凯强"];
        cell.star1.image = [UIImage imageNamed:@"实心星"];
        cell.star2.image = [UIImage imageNamed:@"实心星"];
        cell.star3.image = [UIImage imageNamed:@"实心星"];
        cell.star4.image = [UIImage imageNamed:@"实心星"];
        cell.star5.image = [UIImage imageNamed:@"空心星"];
        cell.commitLabel.text = @"好!";
    }
    else{
        cell.imageView2.image = [UIImage imageNamed:@"汤凯凯"];
        cell.star1.image = [UIImage imageNamed:@"实心星"];
        cell.star2.image = [UIImage imageNamed:@"实心星"];
        cell.star3.image = [UIImage imageNamed:@"实心星"];
        cell.star4.image = [UIImage imageNamed:@"实心星"];
        cell.star5.image = [UIImage imageNamed:@"空心星"];
        cell.commitLabel.text = @"很棒！";
    }

    [cell.imageView2.layer setMasksToBounds:YES];
    [cell.imageView2.layer setCornerRadius:42.5];
    //[self.view bringSubviewToFront:_touxiang];
    
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:true];
}

@end
