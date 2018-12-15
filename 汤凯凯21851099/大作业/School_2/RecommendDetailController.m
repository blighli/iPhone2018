//
//  RecommendDetailController.m
//  游园
//
//  Created by Ray on 15/12/11.
//  Copyright © 2015年 Ray. All rights reserved.
//

#import "RecommendDetailController.h"

@implementation RecommendDetailController
-(void)viewDidLoad
{
    _titleTextField.delegate = self;
    _wordTextField.delegate = self;
}

- (IBAction)cancelBtn:(UIButton *)sender {
    [_titleTextField resignFirstResponder];
    [_wordTextField resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)submitBtn:(UIButton *)sender {
    [_titleTextField resignFirstResponder];
    [_wordTextField resignFirstResponder];
    
    if (![_titleTextField.text  isEqual: @""] && ![_wordTextField.text  isEqual: @""] && _imageView.image != nil) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确认提交？" message:nil preferredStyle: UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
            
            AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
            [app.images addObject:_imageView.image];
            [app.kind addObject:_titleTextField.text];
            [app.detail addObject:_wordTextField.text];
            [self dismissViewControllerAnimated:YES completion:nil];
                                     
        }];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:action];
        [alert addAction:cancel];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else
    {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请填写完后提交" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

- (IBAction)choseImage:(UITapGestureRecognizer *)sender {
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
    imagePickerController.delegate = self;
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *selectedImage = info[UIImagePickerControllerOriginalImage];
    _imageView.image = selectedImage;
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)tapBackground:(UIControl *)sender {
    [_titleTextField resignFirstResponder];
    [_wordTextField resignFirstResponder];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_titleTextField resignFirstResponder];
    [_wordTextField resignFirstResponder];
    return YES;
}

@end
