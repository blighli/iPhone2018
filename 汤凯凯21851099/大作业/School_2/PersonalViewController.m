//
//  PersonalViewController.m
//  School_2
//
//  Created by 汤凯凯 on 15/12/9.
//  Copyright © 2015年 TomKK All rights reserved.
//

#import "PersonalViewController.h"
#import "MBProgressHUD.h"
#import "MediaPlayer/MediaPlayer.h"
#import <UIKit/UIKit.h>

@interface PersonalViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *touxiang;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation PersonalViewController

- (void)viewDidLoad {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.touxiang.layer.cornerRadius = self.touxiang.frame.size.width / 2;
    self.touxiang.layer.masksToBounds = true;
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    PFFile *ImageFile = [[PFUser currentUser] objectForKey:@"picture"];
    
    [ImageFile getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
        if (!error) {
            [self.touxiang setImage:[UIImage imageWithData:data]];
        }
        else
        {
            [self.touxiang setImage:[UIImage imageNamed:@"1"]];
        }
    }];
    
//    UIImage *touxiang = [UIImage imageWithData:ImageFile.getData ];
//    if (touxiang != nil) {
//        self.touxiang.image = touxiang;
//    }
//    
//    [_touxiang.layer setMasksToBounds:YES];
//    [_touxiang.layer setCornerRadius:50.0];
    //[self.view bringSubviewToFront:_touxiang];

    
}

-(void)viewDidAppear:(BOOL)animated{
    PFFile *ImageFile = [[PFUser currentUser] objectForKey:@"picture"];

    [ImageFile getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
        if (!error) {
            [self.touxiang setImage:[UIImage imageWithData:data]];
        }
        else
        {
            [self.touxiang setImage:[UIImage imageNamed:@"1"]];
        }
    }];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


//创建并设置每行的内容
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //设置每行的内容
    NSArray *array = [NSArray arrayWithObjects:@"商城",@"收件箱",@"我的推荐",@"收藏夹",@"通讯录",@"系统设置",nil];
    static NSString *cellIdentifer = @"cell";
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifer];
    //判断是否为空号
    if(cell == nil) {
        UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifer];
    }
    cell.layer.borderWidth = 0.5;
    NSInteger row = [indexPath row];
    cell.textLabel.text = [array objectAtIndex:row];
    cell.accessoryType =   UITableViewCellAccessoryDisclosureIndicator;
       cell.detailTextLabel.text = @"详细信息";
    return cell;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = [indexPath row];
    switch (row) {
        case 0:{
            UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            UIViewController *vw = [storyBoard instantiateViewControllerWithIdentifier:@"shangCheng"];
            [self.navigationController pushViewController:vw animated:true];
            vw.title = @"商城";
            
        }
            break;
        case 1:{
            UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            UIViewController *vw = [storyBoard instantiateViewControllerWithIdentifier:@"shouJianXiang"];
            
            //            [self pushViewController:vw animated:true completion:nil];
            [self.navigationController pushViewController:vw animated:YES];
            vw.title = @"收件箱";
            break;
        }
        case 2 :{
            UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            UIViewController *vw = [storyBoard instantiateViewControllerWithIdentifier:@"MyRecomendTableViewController"];
            //            [self pushViewController:vw animated:true completion:nil];
            [self.navigationController pushViewController:vw animated:YES];
            vw.title = @"个人推荐";
            break;
        }
        case 3 :{
            UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            UIViewController *vw = [storyBoard instantiateViewControllerWithIdentifier:@"shouCangJia"];
            //            [self pushViewController:vw animated:true completion:nil];
            [self.navigationController pushViewController:vw animated:YES];
            vw.title = @"收藏夹";
            break;
        }
        case 4:{
            UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            UIViewController *vw = [storyBoard instantiateViewControllerWithIdentifier:@"haoYou"];
            //            [self pushViewController:vw animated:true completion:nil];
            [self.navigationController pushViewController:vw animated:YES];
            vw.title = @"通讯录";
            break;

           
        }
        case 5:{
            UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            UITableViewController *vw = [storyBoard instantiateViewControllerWithIdentifier:@"xiTongSheZhi"];
            //            [self pushViewController:vw animated:true completion:nil];
            [self.navigationController pushViewController:vw animated:YES];
            vw.title = @"系统设置";
            break;
                    }
        default:
            break;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:true];
}

@end
