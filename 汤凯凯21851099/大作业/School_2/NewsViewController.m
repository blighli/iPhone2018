//
//  NewsViewController.m
//  School_2
//
//  Created by 汤凯凯 on 15/12/15.
//  Copyright © 2015年 TomKK All rights reserved.
//

#import "NewsViewController.h"
#import "DetailNewsViewController.h"
@interface NewsViewController ()
{
        NSInteger width;
        NSInteger height;
        NSInteger index;
    }
@property (weak, nonatomic) IBOutlet UIScrollView *srcollview;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *Title;

@end

@implementation NewsViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.Title.layer.borderWidth = 1.0;
    width =  self.srcollview.frame.size.width;
    height = self.srcollview.frame.size.height;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.srcollview.delegate = self;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Tap:)];
    [self.srcollview addGestureRecognizer:tap];
    for(int i = 1;i<=4;i++) {
        NSString *name = [NSString stringWithFormat:@"news%d",i];
        UIImageView *imageview = [[UIImageView alloc]initWithImage:[UIImage imageNamed:name]];
        [imageview setFrame:CGRectMake((i-1)*width, 0, width, height)];
        [self.srcollview addSubview:imageview];
    }
    [self.srcollview setContentSize:CGSizeMake(width * 4, height)];
    [self.srcollview setBounces:NO];
    [self.srcollview setShowsHorizontalScrollIndicator:NO];
    [self.srcollview setShowsVerticalScrollIndicator:NO];
    [self.srcollview setPagingEnabled:YES];
    [self.pageControl setBackgroundColor:[UIColor blackColor]];
    self.pageControl.currentPage = 0;
    self.pageControl.numberOfPages = 4;
    [self.pageControl addTarget:self action:@selector(click) forControlEvents:UIControlEventValueChanged];
    self.Title.text = @"  学校召开搬迁工作会议";
}
-(void)click{
    NSLog(@"xxx");
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    index = scrollView.contentOffset.x/ width;
    [self.pageControl setCurrentPage:index];
    switch (index) {
        case 0:
            self.Title.text = @"  学校召开搬迁工作会议";
            break;
        case 1:
            self.Title.text = @"  我校位列自然出版指数（NPI）中国大学百强榜";
            break;
        case 2:
            self.Title.text = @"  学校召开离退休老同志情况通报会暨离退休工作先进表彰会";
            break;
        case 3:
            self.Title.text = @"  日本大学生代表团来访我校";
            break;
        default:
            break;
    }
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
-(void)Tap:(UITapGestureRecognizer *)sender{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    DetailNewsViewController *vc = [sb instantiateViewControllerWithIdentifier:@"tableNews"];
    vc.index = index;
    [self.navigationController pushViewController:vc animated:true];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *id = @"id";
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:id];
    NSArray *list = [NSArray arrayWithObjects:@"学校召开搬迁工作会议",@"我校位列自然出版指数（NPI）中国大学百强榜",@"学校召开离退休老同志情况通报会暨离退休工作先进表彰会",@"日本大学生代表团来访我校",@"我校科技园通过浙江省科技企业孵化器评审",@"我校参加第十届孔子学院大会", nil];
  
    cell.imageView.image = [UIImage imageNamed:@"箭头"];
    cell.textLabel.text = [list objectAtIndex:indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.layer.borderColor = (__bridge CGColorRef _Nullable)([UIColor grayColor]);
    cell.layer.borderWidth = 3.0;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    DetailNewsViewController *vc = [sb instantiateViewControllerWithIdentifier:@"tableNews"];
    vc.index = indexPath.row;
    [self.navigationController pushViewController:vc animated:true];
    [self.tableView deselectRowAtIndexPath:indexPath animated:true];
    vc.title = @"师大新闻";
}
@end
