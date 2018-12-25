//
//  CZChangePwdTwoVC.m
//  91VPN
//
//  Created by weichengzong on 2017/8/20.
//  Copyright © 2017年 weichengzong. All rights reserved.
//

#import "CZChangePwdTwoVC.h"
#import "CZRegistDataModel.h"

#import "UIButton+CZEdgeInsets.h"
#import "CZServiceViewController.h"

@interface CZChangePwdTwoVC ()

@property (nonatomic ,strong)UITextField *phoneTextField;
@property (nonatomic ,strong)UITextField *codeTextField;
@property (nonatomic ,strong)CZRegistDataModel *changerModel;
@end

@implementation CZChangePwdTwoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改密码";
}

- (void)uiConfig{
    
    UIView *bgView = [[UIView alloc] init];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(10);
        make.height.mas_equalTo(140);
    }];
    
    _phoneTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 30, SCREEN_WIDTH-40, 30)];
    _phoneTextField.placeholder = @"请输入新密码";
    _phoneTextField.font = [UIFont systemFontOfSize:16];
    [_phoneTextField addTarget:self action:@selector(pwdFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [_phoneTextField becomeFirstResponder];
    _phoneTextField.secureTextEntry = YES;
    _phoneTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [_phoneTextField addBottomBorderWithColor:[UIColor colorWithHexString:@"#f3f3f3"] andWidth:1];
    [bgView addSubview:_phoneTextField];
    
    _codeTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 80, SCREEN_WIDTH-40, 30)];
    _codeTextField.placeholder = @"请再输入新密码";
    _codeTextField.font = [UIFont systemFontOfSize:16];
    [_codeTextField addTarget:self action:@selector(twoFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [_codeTextField becomeFirstResponder];
    _codeTextField.secureTextEntry = YES;
    _codeTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [_codeTextField addBottomBorderWithColor:[UIColor colorWithHexString:@"#f3f3f3"] andWidth:1];
    [bgView addSubview:_codeTextField];
    
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchBtn setBackgroundColor:[UIColor colorWithHexString:@"#00cbff"]];
    [searchBtn setTitle:@"确认修改" forState:UIControlStateNormal];
    searchBtn.layer.cornerRadius = 10;
    searchBtn.layer.masksToBounds = YES;
    [searchBtn addTarget:self action:@selector(searchAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:searchBtn];
    [searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(40);
        make.right.equalTo(self.view).offset(-40);
        make.top.equalTo(bgView.mas_bottom).offset(22);
        make.height.mas_equalTo(44);
    }];
    UIButton *serverBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    serverBtn.frame = CGRectMake(0, SCREEN_HEIGHT-50, SCREEN_WIDTH, 40);
    [serverBtn setTitle:@"点击联系客服" forState:UIControlStateNormal];
    [serverBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [serverBtn setImage:[UIImage imageNamed:@"servertop"] forState:UIControlStateNormal];
    [serverBtn czButtonWithEdgeInsetsStyle:CZButtonEdgeInsetsStyleImageBottom imageTitlespace:0];
    serverBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [serverBtn addTarget:self action:@selector(serverAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:serverBtn];
    
    
}
- (void)pwdFieldDidChange:(UITextField *)theTextField{
    
    if (theTextField.text.length >30) {
        theTextField.text = [theTextField.text substringToIndex:30];
        return;
    }
}
- (void)twoFieldDidChange:(UITextField *)theTextField{
    
    if (theTextField.text.length >30) {
        theTextField.text = [theTextField.text substringToIndex:30];
        return;
    }
}
- (void)serverAction{
    CZServiceViewController *serverVc = [[CZServiceViewController alloc] init];
    [self.navigationController pushViewController:serverVc animated:YES];
}
-(void)requestData{
    _changerModel = [[CZRegistDataModel alloc] init];
}

- (void)searchAction{
    if (_phoneTextField.text.length>=6) {
        
        if(_phoneTextField.text.length>30){
        [self showTopMessage:@"密码长度不能大于30位" topBarConfig:nil mode:TopBarMessageModeOverlay dismissDelay:2 withTapBlock:nil];
            return;
        }
        
        if ([_codeTextField.text isEqualToString:_phoneTextField.text]) {
         
        [_changerModel xiugaimima:self.userphone pwd:_phoneTextField.text re_pwd:_codeTextField.text complete:^(CZRegistDataModel *result) {
            if (result.status.integerValue==0000) {
                if (_isMY) {
                    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:[MyUserInfo getUserInfo]];
                    [dic setObject:_phoneTextField.text forKey:@"user_pwd"];
                    [MyUserInfo saveUserInfo:dic];
                    [self showTopMessage:@"密码修改成功" topBarConfig:nil mode:TopBarMessageModeOverlay dismissDelay:ShowTime withTapBlock:nil];
                    [NSThread sleepForTimeInterval:ShowTime];
                    [self.navigationController popToRootViewControllerAnimated:YES];
                    }else{
                //修改成功
                [self showTopMessage:@"重置密码成功，请使用新密码登录" topBarConfig:nil mode:TopBarMessageModeOverlay dismissDelay:ShowTime withTapBlock:nil];
                
                [self.navigationController popToRootViewControllerAnimated:YES];
            }

            }else{
                [self showTopMessage:result.msg topBarConfig:nil mode:TopBarMessageModeOverlay dismissDelay:ShowTime withTapBlock:nil];
            }
        }];
        }else{
            [self showTopMessage:@"两次输入的密码不一致" topBarConfig:nil mode:TopBarMessageModeOverlay dismissDelay:ShowTime withTapBlock:nil];
        }
    }else{
        [self showTopMessage:@"密码长度不足6位" topBarConfig:nil mode:TopBarMessageModeOverlay dismissDelay:ShowTime withTapBlock:nil];
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

@end
