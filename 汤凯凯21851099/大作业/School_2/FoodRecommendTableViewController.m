//
//  FoodRecommendTableViewController.m
//  School_2
//
//  Created by Ray on 15/12/16.
//  Copyright © 2015年 TomKK All rights reserved.
//

#import "FoodRecommendTableViewController.h"

struct foods
{
    int top;
    __unsafe_unretained NSString *foodName;             //食物名称
    __unsafe_unretained NSString *foodLocation;
}foodInSchool[4] = {
    {1,@"牛肉", @"5号食堂"},
    {2,@"红烧排骨",@"2号食堂"},
    {3,@"东坡肉",@"4号食堂"},
    {4,@"大排饭",@"3号食堂"}
};

@implementation FoodRecommendTableViewController

-(void)viewDidLoad
{
    _foodTableView.delegate = self;
    _foodTableView.dataSource = self;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *foodTableIdentifier = @"foodRecommendTableViewCell";
    FoodRecommendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:foodTableIdentifier];
    
    if (cell == nil) {
        cell = [[FoodRecommendTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:foodTableIdentifier];
    }
    cell.foodImageView.image = [UIImage imageNamed:foodInSchool[indexPath.row].foodName];
    cell.topLabel.text = [NSString stringWithFormat:@"Top %d",foodInSchool[indexPath.row].top];
    cell.foodNameLabel.text = [NSString stringWithFormat:@"%@",foodInSchool[indexPath.row].foodName];
    cell.foodLocationLabel.text = [NSString stringWithFormat:@"%@",foodInSchool[indexPath.row].foodLocation];
    
    [cell.foodImageView.layer setMasksToBounds:YES];
    [cell.foodImageView.layer setCornerRadius:10.0];
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_foodTableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
