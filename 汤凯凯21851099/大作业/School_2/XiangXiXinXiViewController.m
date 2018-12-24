//
//  XiangXiXinXiViewController.m
//  School_2
//
//  Created by 汤凯凯 on 15/12/12.
//  Copyright © 2015年 TomKK All rights reserved.
//

#import "XiangXiXinXiViewController.h"
#import "AppDelegate.h"
@interface XiangXiXinXiViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *touXiang;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UILabel *Name;
@property (weak, nonatomic) IBOutlet UITableViewCell *zhangHao;
@property (weak, nonatomic) IBOutlet UITableViewCell *LianXi;
@property (weak, nonatomic) IBOutlet UITableViewCell *geXingQianMing;

@end

@implementation XiangXiXinXiViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    self.touXiang.layer.cornerRadius = self.touXiang.frame.size.height / 2;
    self.touXiang.layer.masksToBounds = true;
    
    NSInteger a = app.i;
    switch (a) {
        case 0:
            self.touXiang.image = [UIImage imageNamed:@"曹凯强"];
            self.Name.text = @"曹凯强";
            self.zhangHao.textLabel.text = @"账号:1594";
            self.LianXi.textLabel.text = @"昵称:kobe_魂";
            self.geXingQianMing.textLabel.text = @"个性签名:坚持";
        break;
        case 1:
            self.touXiang.image = [UIImage imageNamed:@"陈枭磊"];
            self.Name.text = @"陈枭磊";
            
            self.zhangHao.textLabel.text = @"账号:798";
            self.LianXi.textLabel.text = @"昵称:Ray";
            self.geXingQianMing.textLabel.text = @"个性签名:- -";

            break;
        case 2:
            self.touXiang.image = [UIImage imageNamed:@"汤凯凯"];
            self.Name.text = @"汤凯凯";
            
            self.zhangHao.textLabel.text = @"账号:54";
            self.LianXi.textLabel.text = @"昵称:MYH";
            self.geXingQianMing.textLabel.text = @"个性签名:生日快乐";

            break;
         case 3:
            self.touXiang.image = [UIImage imageNamed:@"杨靖"];
            self.Name.text = @"杨靖";
          
            self.zhangHao.textLabel.text = @"账号:453";
            self.LianXi.textLabel.text = @"昵称:杨";
            self.geXingQianMing.textLabel.text = @"个性签名:一切皆有可能";

            break;
        case 4:
            self.touXiang.image = [UIImage imageNamed:@"林晓蕾"];
            self.Name.text = @"林晓蕾";
            
            self.zhangHao.textLabel.text = @"账号:54598";
            self.LianXi.textLabel.text = @"昵称:晓蕾";
            self.geXingQianMing.textLabel.text = @"个性签名:相信自己";

            break;
        default:
            break;
    }
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)faSongXiaoXi:(id)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"DuiHuaKuang"];
    vc.title = self.Name.text;
    [self.navigationController pushViewController:vc animated:true];
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
