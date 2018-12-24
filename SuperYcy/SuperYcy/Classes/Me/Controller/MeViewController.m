//
//  MeViewController.m
//  SuperYcy
//
//  Created by 叶晨宇 on 2018/11/22.
//  Copyright © 2018 叶晨宇. All rights reserved.
//

#import "MeViewController.h"
#import "SettingTableViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "SquareItem.h"
#import <MJExtension/MJExtension.h>
#import "SquareViewCell.h"
#import <SafariServices/SafariServices.h>

static NSString * const ID = @"cell";
static NSInteger const cols = 5;
static CGFloat const margin = 1;

@interface MeViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property(strong,nonatomic)NSArray *squareItems;
@property(weak,nonatomic)UICollectionView *collectionView;

@end

@implementation MeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置NavigationBar
    [self setupNavigationBar];
    
    //设置tableview底部视图
    [self setUpFootView];
    
    //请求数据
    [self loadData];
}

-(void)loadData{
    
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];

    NSMutableDictionary *parameters=[NSMutableDictionary dictionary];
    
    parameters[@"a"]=@"square";
    parameters[@"c"]=@"topic";
    
    //http请求
    [mgr GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        NSArray *dictArr=responseObject[@"square_list"];
        self.squareItems=[SquareItem mj_objectArrayWithKeyValuesArray:dictArr];
       
        [self.collectionView reloadData];
    }
        failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}

- (void) setUpFootView{
    //UICollectionView
    
    //创建一个layout
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
    
    //设置cell尺寸
    NSInteger itemWH = ([UIScreen mainScreen].bounds.size.width - (cols - 1) * margin) / cols;
    layout.itemSize = CGSizeMake(itemWH, itemWH);
    layout.minimumInteritemSpacing = margin;
    layout.minimumLineSpacing = margin;
    
    //创建UICollectionView
    UICollectionView *collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0,  0, 0, 300) collectionViewLayout:layout];
    
    _collectionView=collectionView;

    collectionView.backgroundColor = self.tableView.backgroundColor;

    //添加到tableView的底部视图
    self.tableView.tableFooterView=collectionView;
    
    collectionView.dataSource=self;
    collectionView.delegate = self;

    //注册cell
    [collectionView registerClass:[UICollectionViewCell class]forCellWithReuseIdentifier:ID];
    [collectionView registerNib:[UINib nibWithNibName:@"SquareViewCell" bundle:nil] forCellWithReuseIdentifier:ID];
    
}

- (void) setupNavigationBar{
    //a button "settings"
    UIButton *btnSettings=[UIButton buttonWithType:UIButtonTypeCustom];
    [btnSettings setImage:[UIImage imageNamed:@"mine-setting-icon"]
             forState:UIControlStateNormal];
    [btnSettings setImage:[UIImage imageNamed:@"mine-setting-icon-click"]          forState:UIControlStateHighlighted];
    //click on setting button
    [btnSettings addTarget:self action:@selector(setting) forControlEvents:UIControlEventTouchUpInside];

    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:btnSettings];

    self.navigationItem.title=@"我的";
}

- (void)setting {
    //跳转到setting页面
    SettingTableViewController *settingVC=[[SettingTableViewController alloc]init];
    //隐藏底部button
    settingVC.hidesBottomBarWhenPushed=YES;
    
    [self.navigationController pushViewController:settingVC animated:YES];
    
    
}

#pragma mark -UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.squareItems.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 从缓存池取
    SquareViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.item=self.squareItems[indexPath.item];
    return cell;
}

#pragma mark UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //点击cell跳转到网页
    SquareItem *item = self.squareItems[indexPath.row];
    if (![item.url containsString:@"http"]) return;
    
    NSURL *url = [NSURL URLWithString:item.url];
    
    SFSafariViewController *safariVc = [[SFSafariViewController alloc] initWithURL:url];

    [self presentViewController:safariVc animated:YES completion:nil];
    
}

@end
