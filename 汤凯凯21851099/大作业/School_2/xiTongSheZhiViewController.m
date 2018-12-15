//
//  XiTongSheZhiViewController.m
//  School_2
//
//  Created by 汤凯凯 on 15/12/12.
//  Copyright © 2015年 TomKK All rights reserved.
//

#import "XiTongSheZhiViewController.h"
#import "MBProgressHUD.h"

@interface XiTongSheZhiViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation XiTongSheZhiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)quit:(id)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提醒" message:@"真的要退出" preferredStyle: UIAlertControllerStyleAlert];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        MBProgressHUD *spiningActivity = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        spiningActivity.labelText = @"正在退出";
        spiningActivity.detailsLabelText = @"稍等片刻马上就好";
        spiningActivity.userInteractionEnabled = NO;
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"user_name"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [PFUser logOutInBackgroundWithBlock:^(NSError *error){
            spiningActivity.hidden = YES;
            UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            UIViewController *ViewPage = [storyBoard instantiateViewControllerWithIdentifier:@"ViewController"];
            UINavigationController *ViewPageNav =[[UINavigationController alloc]initWithRootViewController:ViewPage];
            [ViewPage.navigationController setNavigationBarHidden:YES animated:YES];
            
            
            AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
            appDelegate.window.rootViewController = ViewPageNav;
        }];
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleDestructive handler:nil];
    [alert addAction:action1];
    [alert addAction:action2];
    [self presentViewController:alert animated:true completion:nil];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *id = @"cell";
    NSArray *list = [NSArray  arrayWithObjects:@"消息通知",@"导航设置",@"修改密码",@"系统版本",@"关于我们", nil];
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:id];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:id];
    }
    NSInteger section = [indexPath section];
    cell.textLabel.text = [list objectAtIndex:section];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger section = [indexPath section];
    switch (section) {
        case 0:{
            UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            UIViewController *vw = [storyBoard instantiateViewControllerWithIdentifier:@"xiaoXiTongZhi"];
            [self.navigationController pushViewController:vw animated:true];
            vw.title = @"消息通知";
            
        }
            break;
        case 1:{
            UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            UIViewController *vw = [storyBoard instantiateViewControllerWithIdentifier:@"daoHangSheZhi"];
            
            //            [self pushViewController:vw animated:true completion:nil];
            [self.navigationController pushViewController:vw animated:YES];
            vw.title = @"导航设置";
            break;
            
        }
        case 2 :{
            UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            UIViewController *vw = [storyBoard instantiateViewControllerWithIdentifier:@"ChangePasswordsViewController"];
            //            [self pushViewController:vw animated:true completion:nil];
            [self.navigationController pushViewController:vw animated:YES];
            vw.title = @"修改密码";
            break;
        }
        case 3 :{
            UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            UIViewController *vw = [storyBoard instantiateViewControllerWithIdentifier:@"gongNengJieShao"];
            //            [self pushViewController:vw animated:true completion:nil];
            [self.navigationController pushViewController:vw animated:YES];
            vw.title = @"系统版本";
            break;
        }
        case 4:{
            UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            UITableViewController *vw = [storyBoard instantiateViewControllerWithIdentifier:@"guanYuWoMen"];
            //            [self pushViewController:vw animated:true completion:nil];
            [self.navigationController pushViewController:vw animated:YES];
            vw.title = @"关于我们";
            break;
        }
        default:
            break;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:true];
}
//设置section之间的差距
/*-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
 return 20;
 }
 */
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}
//设置索引
//-(NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{

//}
@end
