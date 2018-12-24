//
//  becomeVolunteerViewController.m
//  游园
//
//  Created by Ray on 15/12/8.
//  Copyright © 2015年 Ray. All rights reserved.
//

#import "BecomeVolunteerViewController.h"

@implementation BecomeVolunteerViewController
{
@private NSString *imageSrc;
}
-(void)viewDidLoad
{
    [self initTextField];
    [_cardImage.layer setMasksToBounds:YES];
    _cardImage.layer.borderWidth = 1.5;
    [_headImage.layer setMasksToBounds:YES];
    _headImage.layer.borderWidth = 1.5;
}

- (IBAction)cancelButton:(UIButton *)sender {
    [self tapBackground:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)yesButton:(UIButton *)sender {
    [self tapBackground:nil];
    if ([_nameTextField.text isEqual:@""] || [_idTextField.text isEqual:@""] || [_majorTextField.text isEqual:@""] || [_specialityTextField.text isEqual:@""] || [_loveTextField.text isEqual:@""] || [_phoneNumberTextField.text isEqual:@""] || [_yearTextField.text isEqual:@""] || _headImage.image == nil || _cardImage.image == nil)
    {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请完善信息后提交" message:nil preferredStyle: UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else
    {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"感谢您的提交" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
    }

}

- (IBAction)tapBackground:(id)sender {
    [_nameTextField resignFirstResponder];
    [_idTextField resignFirstResponder];
    [_majorTextField resignFirstResponder];
    [_specialityTextField resignFirstResponder];
    [_loveTextField resignFirstResponder];
    [_phoneNumberTextField resignFirstResponder];
    if (_dataPicker.superview)
    {
        [_dataPicker removeFromSuperview];
        [_backView removeFromSuperview];
    }
}

//初始化textField
- (void)initTextField
{
    _nameTextField.delegate = self;
    _idTextField.delegate = self;
    _majorTextField.delegate = self;
    _yearTextField.delegate = self;
    _specialityTextField.delegate = self;
    _loveTextField.delegate = self;
    _phoneNumberTextField.delegate = self;
    
    _yearTextField.tag = 1;
    
    _dataPicker = [[UIDatePicker alloc]init];
    _dataPicker.datePickerMode = UIDatePickerModeDate;
    [_dataPicker addTarget:self action:@selector(chooseDate:)forControlEvents:UIControlEventValueChanged];
    _backView = [[UIView alloc]initWithFrame:CGRectMake(0,[[UIScreen mainScreen] bounds].size.height-200, [[UIScreen mainScreen] bounds].size.width, 200)];
    _backView.backgroundColor = [UIColor grayColor];
}

- (void)chooseDate:(UIDatePicker *)sender
{
    NSDate *selectedDate = sender.date;
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyy-MM-dd";
    _dataPicker.maximumDate = [formatter dateFromString:@"2015-12-01"];
    NSString *dateString = [formatter stringFromDate:selectedDate];
    _yearTextField.text = dateString;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    //当返回YES时弹出键盘
    if (textField.tag != 1)
    {
        if (_dataPicker.superview)
        {
            [_dataPicker removeFromSuperview];
            [_backView removeFromSuperview];
        }
        return YES;
    }
    
    if (_dataPicker.superview == nil)
    {
        [_nameTextField resignFirstResponder];
        [_idTextField resignFirstResponder];
        [_majorTextField resignFirstResponder];
        [_specialityTextField resignFirstResponder];
        [_loveTextField resignFirstResponder];
        [_phoneNumberTextField resignFirstResponder];
        _dataPicker.frame = CGRectMake(0,[[UIScreen mainScreen] bounds].size.height-200, [[UIScreen mainScreen] bounds].size.width, 200);
        [self.view addSubview:self.backView];
        [self.view addSubview:self.dataPicker];
        
        
    }
    
    return NO;
}

- (IBAction)tapHeadImage:(UITapGestureRecognizer *)sender {
    [self tapBackground:nil];
    imageSrc = @"headImage";
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
    imagePickerController.delegate = self;
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:imagePickerController animated:YES completion:nil];
}
- (IBAction)tapCardImage:(UITapGestureRecognizer *)sender {
    [self tapBackground:nil];
    imageSrc = @"cardImage";
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
    imagePickerController.delegate = self;
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:imagePickerController animated:YES completion:nil];
}


-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *selectedImage = info[UIImagePickerControllerOriginalImage];
    if ([imageSrc  isEqual: @"headImage"]) {
        _headImage.image = selectedImage;
    }
    else if([imageSrc  isEqual: @"cardImage"])
    {
        _cardImage.image = selectedImage;
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end













