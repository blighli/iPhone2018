//
//  CZMineViewController.m
//  91加速
//
//  Created by weichengzong on 2017/8/16.
//  Copyright © 2017年 weichengzong. All rights reserved.
//

#import "CZMineViewController.h"
#import "CZMineHeadView.h"
#import "CZLoginViewController.h"
#import "CZChangePwdVC.h"
#import "CZMessageVC.h"
#import "CZQuestionVC.h"

#import "CZWebVC.h"
#import "CZUMShare.h"
#import "CZVpnmanager16.h"
#import "CZHomeModel.h"

@interface CZMineViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong)UITableView    *tableView;
@property (nonatomic ,strong)NSArray        *titleArr;
@property (nonatomic ,strong)CZMineHeadView *headView;

@end

@implementation CZMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"个人中心";
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _headView.dataDic = [MyUserInfo getUserInfo];
}
-(NSArray *)titleArr{
    if ([[MyUserInfo getInfoForkey:@"youke"] isEqualToString:@"yes"]){
    return @[@[@"mine5",@"系统消息"],@[@"mine2",@"访问官网"],@[@"mine3",@"立即分享"],@[@"xiazai",@"证书下载"],@[@"mine6",@"常见问题"]];
//        return @[@[@"mine2",@"访问官网"],@[@"mine3",@"立即分享"],@[@"xiazai",@"证书下载"]];
//        return @[@[@"mine2",@"访问官网"],@[@"mine3",@"立即分享"],@[@"xiazai",@"证书下载"],@[@"mine6",@"常见问题"]];
    }else{
        return @[@[@"mine5",@"系统消息"],@[@"mine1",@"修改密码"],@[@"mine2",@"访问官网"],@[@"mine3",@"立即分享"],@[@"xiazai",@"证书下载"],@[@"mine6",@"常见问题"]];
//        return @[@[@"mine1",@"修改密码"],@[@"mine2",@"访问官网"],@[@"mine3",@"立即分享"],@[@"xiazai",@"证书下载"]];
//        return @[@[@"mine1",@"修改密码"],@[@"mine2",@"访问官网"],@[@"mine3",@"立即分享"],@[@"xiazai",@"证书下载"],@[@"mine6",@"常见问题"]];
    }
   

}

- (void)uiConfig{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [UIView new];
    _tableView.backgroundColor = CZColorHexString(#f3f3f3);
    [self.view addSubview:_tableView];
    
    _headView = [[CZMineHeadView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH*0.4)];
    _tableView.tableHeaderView = _headView;
}
-(void)requestData{
    _headView.dataDic = [MyUserInfo getUserInfo];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
      return self.titleArr.count;
    }
    return 1;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *mainID = @"mainID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:mainID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mainID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    if (indexPath.section==0) {
        cell.textLabel.text = [self.titleArr[indexPath.row] lastObject];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.imageView.image = [UIImage imageNamed:[self.titleArr[indexPath.row] firstObject]];
    }else if (indexPath.section==1){
        cell.textLabel.text = @"退出账号";
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.imageView.image = [UIImage imageNamed:@"mine4"];
    }

    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section==0) {
        switch (indexPath.row) {
            case 0:
            {
                CZMessageVC *messageVC = [[CZMessageVC alloc] init];
                [self.navigationController pushViewController:messageVC animated:YES];
            }
                break;
            case 1:
            {
                if ([[MyUserInfo getInfoForkey:@"youke"] isEqualToString:@"yes"]){
                    CZWebVC *guanwang = [[CZWebVC alloc] init];
                    if (kAppDelegate.isGUONEI) {
                        guanwang.URLString = GuanWang_baida;
                    }else{
                        guanwang.URLString = GuanWang_jiasu;
                    }
                    guanwang.title = @"91加速器PRO";
                    [self.navigationController pushViewController:guanwang animated:YES];
                }else{
                    CZChangePwdVC *changeVC = [[CZChangePwdVC alloc] init];
                    changeVC.isMY = YES;
                    [self.navigationController pushViewController:changeVC animated:YES];
                }
     
            }
                break;
            case 2:{
                if ([[MyUserInfo getInfoForkey:@"youke"] isEqualToString:@"yes"]){
                    NSString *contentStr = nil;
                    if ([[MyUserInfo getInfoForkey:@"youke"] isEqualToString:@"yes"]) {
                        contentStr = @"游客模式下分享应用而获得的奖励将被添加到公用的游客账号，建议先注册账号再分享应用！";
                        if (![[MyUserInfo getInfoForkey:@"youkesharefirst"] isEqualToString:@"yes"]) {
                            [MyUserInfo saveInfoForkey:@"youkesharefirst" value:@"yes"];
                            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:contentStr preferredStyle:UIAlertControllerStyleAlert];
                            
                            UIAlertAction *photography = [UIAlertAction actionWithTitle:@"继续分享" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                                [CZUMShare UMShare91:self];
                            }];
                            [alert addAction:photography];
                            
                            [self presentViewController:alert animated:YES completion:nil];
                        }else{
                            [CZUMShare UMShare91:self];
                        }
                    }else{
                        contentStr = @"通过您发出的分享链接每成功注册一个账号，您的账号就会累加一定免费使用时长";
                        if (![[MyUserInfo getInfoForkey:@"sharefirst"] isEqualToString:@"yes"]) {
                            [MyUserInfo saveInfoForkey:@"sharefirst" value:@"yes"];
                            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:contentStr preferredStyle:UIAlertControllerStyleAlert];
                            
                            UIAlertAction *photography = [UIAlertAction actionWithTitle:@"继续分享" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                                [CZUMShare UMShare91:self];
                            }];
                            [alert addAction:photography];
                            
                            [self presentViewController:alert animated:YES completion:nil];
                        }else{
                            [CZUMShare UMShare91:self];
                        }
                    }
                }else{
                    CZWebVC *guanwang = [[CZWebVC alloc] init];
                    if (kAppDelegate.isGUONEI) {
                        guanwang.URLString = GuanWang_baida;
                    }else{
                        guanwang.URLString = GuanWang_jiasu;
                    }
                    
                    guanwang.title = @"91加速器PRO";
                    [self.navigationController pushViewController:guanwang animated:YES];
                }

            }
                break;
            case 3:{
                if ([[MyUserInfo getInfoForkey:@"youke"] isEqualToString:@"yes"]){
                    CZHomeModel *homemodel = [[CZHomeModel alloc] init];
                    [homemodel getCertcomplete:^(NSDictionary *result) {
                        NSLog(@"证书地址--%@",result);
                        NSString *url = [result objectForKey:@"url"];
                        NSURL *requestURL = [NSURL URLWithString:url];
                        [[UIApplication sharedApplication ] openURL: requestURL ];
                    } error:^(NSDictionary *err) {
                        
                    }];
                }else{
                    NSString *contentStr = nil;
                    if ([[MyUserInfo getInfoForkey:@"youke"] isEqualToString:@"yes"]) {
                        contentStr = @"游客模式下分享应用而获得的奖励将被添加到公用的游客账号，建议先注册账号再分享应用！";
                        if (![[MyUserInfo getInfoForkey:@"youkesharefirst"] isEqualToString:@"yes"]) {
                            [MyUserInfo saveInfoForkey:@"youkesharefirst" value:@"yes"];
                            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:contentStr preferredStyle:UIAlertControllerStyleAlert];
                            
                            UIAlertAction *photography = [UIAlertAction actionWithTitle:@"继续分享" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                                [CZUMShare UMShare91:self];
                            }];
                            [alert addAction:photography];
                            
                            [self presentViewController:alert animated:YES completion:nil];
                        }else{
                            [CZUMShare UMShare91:self];
                        }
                    }else{
                        contentStr = @"通过您发出的分享链接每成功注册一个账号，您的账号就会累加一定免费使用时长";
                        if (![[MyUserInfo getInfoForkey:@"sharefirst"] isEqualToString:@"yes"]) {
                            [MyUserInfo saveInfoForkey:@"sharefirst" value:@"yes"];
                            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:contentStr preferredStyle:UIAlertControllerStyleAlert];
                            
                            UIAlertAction *photography = [UIAlertAction actionWithTitle:@"继续分享" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                                [CZUMShare UMShare91:self];
                            }];
                            [alert addAction:photography];
                            
                            [self presentViewController:alert animated:YES completion:nil];
                        }else{
                            [CZUMShare UMShare91:self];
                        }
                    }
                }
            }
                break;
            case 4:{
                if ([[MyUserInfo getInfoForkey:@"youke"] isEqualToString:@"yes"]){
                    CZQuestionVC *questionVC = [[CZQuestionVC alloc] init];
                    [self.navigationController pushViewController:questionVC animated:YES];

                }else{
                    CZHomeModel *homemodel = [[CZHomeModel alloc] init];
                    [homemodel getCertcomplete:^(NSDictionary *result) {
                        NSLog(@"证书地址--%@",result);
                        NSString *url = [result objectForKey:@"url"];
                        NSURL *requestURL = [NSURL URLWithString:url];
                        [[UIApplication sharedApplication ] openURL: requestURL ];
                    } error:^(NSDictionary *err) {

                    }];
                }
            }
                break;
            case 5:{
                CZQuestionVC *questionVC = [[CZQuestionVC alloc] init];
                [self.navigationController pushViewController:questionVC animated:YES];
            }
            break;
            default:
                break;
        }
    }else{
        [self tuichu];
        

    }


}
- (void)tuichu{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否确认退出？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    UIAlertAction *photography = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSString *token = [[MyUserInfo getUserInfo] objectForKey:@"token"];
        NSMutableDictionary *parames = [[NSMutableDictionary alloc] init];
        [parames setObject:token forKey:@"token"];
        [AFNetInterFaceManager Post:LogoutAPI hostUrl:A_Address parameters:nil success:^(NSDictionary *response, NSURLSessionDataTask *task) {
            
        } failure:nil];
        
        [MyUserInfo saveInfoForkey:@"youke" value:nil];
        [MyUserInfo clearUserInfo];
        [[CZVpnmanager16 shareManager] disconnectVPN];
        [kAppDelegate setupLoginViewController];
    }];
    [alert addAction:cancel];
    [alert addAction:photography];

    
    [self presentViewController:alert animated:YES completion:nil];

}
- (void)shareAPP{

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

@end
