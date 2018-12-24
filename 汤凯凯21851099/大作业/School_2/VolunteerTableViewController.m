//
//  VolunteerTableViewController.m
//  School_2
//
//  Created by Ray on 15/12/14.
//  Copyright © 2015年 TomKK All rights reserved.
//

#import "VolunteerTableViewController.h"

@implementation VolunteerTableViewController
-(void)viewDidLoad
{
    images = [[NSMutableArray alloc]initWithObjects:[UIImage imageNamed:@"杨靖"],[UIImage imageNamed:@"陈枭磊"], nil];
    names = [[NSMutableArray alloc]initWithObjects:@"杨靖",@"陈枭磊", nil];
    words = [[NSMutableArray alloc]initWithObjects:@"Year",@"Volunteer for free", nil];
    
    self.navigationItem.title = @"You游志愿者";
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 85;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return images.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *VolunteerCellIdentifier = @"VolunteerCellIdentifier";
    MyRecommendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:VolunteerCellIdentifier];
    
    if (cell == nil) {
        cell = [[MyRecommendTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:VolunteerCellIdentifier];
    }
    
    cell.imageView2.image = images[indexPath.row];
    cell.labelForKind.text = names[indexPath.row];
    cell.labelForDetail.text = words[indexPath.row];
    
    [cell.imageView2.layer setMasksToBounds:YES];
    [cell.imageView2.layer setCornerRadius:36];
    //[self.view bringSubviewToFront:_touxiang];
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    VolunteerDetailViewController *nextController = [mainStoryboard instantiateViewControllerWithIdentifier:@"VolunteerDetail"];
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    app.headImage = images[indexPath.row];
    app.name = names[indexPath.row];
    app.words = words[indexPath.row];
    [self.tableView deselectRowAtIndexPath:indexPath animated:true];
    [self.navigationController pushViewController:nextController animated:YES];
}

@end
