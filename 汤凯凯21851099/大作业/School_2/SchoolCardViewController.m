//
//  SchoolCardViewController.m
//  School_2
//
//  Created by Ray on 15/12/16.
//  Copyright © 2015年 TomKK All rights reserved.
//

#import "SchoolCardViewController.h"

@implementation SchoolCardViewController
{
    int money;
    int addMoney;
    int deleteMoney;
    __weak IBOutlet UIImageView *cardImage;
    __weak IBOutlet UIButton *moneyOutButton;
    __weak IBOutlet UIButton *moneyInButton;
}
-(void)viewDidLoad
{
    money = 100;
    _moneyLabel.text = @"100";
    
    [cardImage.layer setMasksToBounds:YES];
    //按钮加圆角
    [cardImage.layer setCornerRadius:10];
    
    [moneyOutButton.layer setCornerRadius:10];
    [moneyInButton.layer setCornerRadius:10];
    
}

- (IBAction)moneyIn:(UIButton *)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请输入充值金额" message:nil preferredStyle: UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        money += addMoney;
        _moneyLabel.text = [NSString stringWithFormat:@"%d", money];
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleDestructive handler:nil];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"充值金额";
        textField.keyboardType = UIKeyboardTypeNumberPad;
        [textField addTarget:self action:@selector(addMoneyTextField:) forControlEvents:UIControlEventEditingChanged];
    }];
    action.enabled = NO;
    [alert addAction:action];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)addMoneyTextField:(UITextField *)addMoneyTextField
{
    UIAlertController *alertController = (UIAlertController *)self.presentedViewController;
    UIAlertAction *doneAction = alertController.actions[0];
    if (addMoneyTextField.text.length >= 1) {
        doneAction.enabled = YES;
        addMoney = [addMoneyTextField.text intValue];
    }
    else{
        doneAction.enabled = NO;
    }
}

- (IBAction)moneyOut:(UIButton *)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请输入提现金额" message:nil preferredStyle: UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if (money - deleteMoney < 0)
        {
            UIAlertController *canNot = [UIAlertController alertControllerWithTitle:@"不能提现" message:@"提现的金额大于余额" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *yes = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:nil];
            [canNot addAction:yes];
            
            [self presentViewController:canNot animated:yes completion:nil];
        }
        else
        {
            money -= deleteMoney;
            _moneyLabel.text = [NSString stringWithFormat:@"%d", money];
        }
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleDestructive handler:nil];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"提现金额";
        textField.keyboardType = UIKeyboardTypeNumberPad;
        [textField addTarget:self action:@selector(deleteMoneyTextField:) forControlEvents:UIControlEventEditingChanged];
    }];
    action.enabled = NO;
    [alert addAction:action];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)deleteMoneyTextField:(UITextField *)deleteMoneyTextField
{
    UIAlertController *alertController = (UIAlertController *)self.presentedViewController;
    UIAlertAction *doneAction = alertController.actions[0];
    if (deleteMoneyTextField.text.length >= 1) {
        doneAction.enabled = YES;
        deleteMoney = [deleteMoneyTextField.text intValue];
    }
    else{
        doneAction.enabled = NO;
    }
}


@end
