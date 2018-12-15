//
//  MyRecommendViewController.m
//  游园
//
//  Created by Ray on 15/12/11.
//  Copyright © 2015年 Ray. All rights reserved.
//

#import "MyRecommendViewController.h"

@implementation MyRecommendViewController

-(void)loadPhoto
{
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    app.images = [[NSMutableArray alloc]initWithObjects:[UIImage imageNamed:@"校门"],[UIImage imageNamed:@"恕园1号楼"], nil];
    app.kind = [[NSMutableArray alloc]initWithObjects:@"校门",@"恕园1号楼", nil];
    app.detail = [[NSMutableArray alloc]initWithObjects:@"细节1",@"细节2", nil];
}
-(void)viewDidLoad
{
    [self loadPhoto];
    _recommendTableView.delegate = self;
    _recommendTableView.dataSource = self;
}

-(void)viewDidAppear:(BOOL)animated
{
    [self.recommendTableView reloadData];
}


//返回几节
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSLog(@"%d",app.images.count);
    return app.images.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    static NSString *recommendTableIdentifier = @"RecommendTableIdentifier";
    MyRecommendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:recommendTableIdentifier];
    
    if (cell == nil) {
        cell = [[MyRecommendTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:recommendTableIdentifier];
    }
    
    cell.imageView2.image = app.images[indexPath.row];
    cell.labelForKind.text = app.kind[indexPath.row];
    cell.labelForDetail.text = app.detail[indexPath.row];
    
    [cell.imageView2.layer setMasksToBounds:YES];
    [cell.imageView2.layer setCornerRadius:10.0];
    
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_recommendTableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
