//
//  PersonalinformationViewController.m
//  School_2
//
//  Created by 汤凯凯 on 15/12/10.
//  Copyright © 2015年 TomKK All rights reserved.
//

#import "PersonalinformationViewController.h"
#import "MBProgressHUD.h"


@interface PersonalinformationViewController ()
@property (weak, nonatomic) IBOutlet UITextField *lianXi;
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *job;
@property (weak, nonatomic) IBOutlet UITextField *telephone;
@property (weak, nonatomic) IBOutlet UITextView *geqian;

@property (weak, nonatomic) IBOutlet UIImageView *touXiang;
@property (weak, nonatomic) IBOutlet UITextField *techang;
@property (weak, nonatomic) IBOutlet UITextField *aihao;
@property CGFloat width;
@property CGFloat height;
@end

@implementation PersonalinformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString *Name = [[PFUser currentUser] objectForKey:@"Name"];
    
    NSString *job = [[PFUser currentUser] objectForKey:@"job"];
    NSString *telephone = [[PFUser currentUser] objectForKey:@"telephone"];
    NSString *geqian = [[PFUser currentUser] objectForKey:@"geqian"];
    NSString *techang = [[PFUser currentUser] objectForKey:@"techang"];
    NSString *aihao = [[PFUser currentUser] objectForKey:@"aihao"];
    self.techang.text = techang;
    self.aihao.text = aihao;
    self.name.text = Name;
    self.job.text = job;
    self.telephone.text = telephone;
    self.geqian.text = geqian;
    self.width = self.view.frame.size.width;
    self.height = self.view.frame.size.height;
    self.geqian.delegate = self;
    self.lianXi.delegate = self;
    PFFile *ImageFile = [[PFUser currentUser] objectForKey:@"picture"];
    
    [ImageFile getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
        if (!error) {
            [self.touXiang setImage:[UIImage imageWithData:data]];
        }
        else
        {
            [self.touXiang setImage:[UIImage imageNamed:@"1"]];
        }
    }];
    
    
   
    [_touXiang.layer setMasksToBounds:YES];
    [_touXiang.layer setCornerRadius:50.0];
    //[self.view bringSubviewToFront:_touxiang];
    
    
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


- (IBAction)img:(id)sender {
    UIImagePickerController *picker = [ [UIImagePickerController alloc]init];
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:true completion:nil];
    
    
}

- (IBAction)tapImage:(UITapGestureRecognizer *)sender {
    
    UIImagePickerController *picker = [ [UIImagePickerController alloc]init];
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:true completion:nil];
    
}


-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    self.touXiang.image = info[UIImagePickerControllerOriginalImage];
    [self dismissViewControllerAnimated:true
                             completion:nil];
}

- (IBAction)save:(id)sender {
    
    [self viewback:sender];
    
    NSString *techang =  self.techang.text;
    NSString *aihao =  self.aihao.text;
    NSString *name =  self.name.text;
    NSString *job =  self.job.text;
    NSString *telephone =  self.telephone.text;
    NSString *geqian =   self.geqian.text;
    NSData *ImageData = UIImageJPEGRepresentation(self.touXiang.image, 1);

    
    PFUser *user = [PFUser currentUser];
    [user setObject:techang forKey:@"techang"];
    [user setObject:aihao forKey:@"aihao"];
    if (![name isEqualToString:@""]) {
        [user setObject:name forKey:@"Name"];
    }
    [user setObject:job forKey:@"job"];
    [user setObject:telephone forKey:@"telephone"];
    [user setObject:geqian forKey:@"geqian"];
    if (ImageData != nil) {
        PFFile *ImageFile = [PFFile fileWithData:ImageData];
        [user setObject:ImageFile forKey:@"picture"];
    }
    MBProgressHUD *spiningActivity = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    spiningActivity.labelText = @"正在保存";
    spiningActivity.detailsLabelText = @"稍等片刻马上就好";
    spiningActivity.userInteractionEnabled = NO;

    
    [user saveInBackgroundWithBlock:^(BOOL succeeded,NSError *error){
        spiningActivity.hidden = YES;
        
        NSString *errorMessage = @"保存成功";
        if (error) {
            errorMessage = @"保存失败请重试！";
        }
        
        UIAlertController *myAlert = [UIAlertController alertControllerWithTitle:@"提示" message:errorMessage preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style: UIAlertActionStyleDefault handler: ^(UIAlertAction *okAction){
            
        }];
            [myAlert addAction: okAction];
            [self presentViewController:myAlert animated:YES completion:nil];


    }];
    
    
}
- (IBAction)viewback:(id)sender {
    [self.job resignFirstResponder];
    [self.techang resignFirstResponder];
    [self.aihao resignFirstResponder];
    [self.telephone resignFirstResponder];
    [self.name resignFirstResponder];
    [self.geqian resignFirstResponder];
    [UIView beginAnimations:@"transform" context:nil];
    
    [UIView setAnimationDuration:0.3];
    CGRect rect = CGRectMake(0, 0, self.width, self.height);
    self.view.frame = rect;
    [UIView commitAnimations];
}
-(void)textViewDidBeginEditing:(UITextView *)textView{
    [UIView beginAnimations:@"transform" context:nil];
   
    [UIView setAnimationDuration:0.3];
    CGRect rect = CGRectMake(0, -130, self.width, self.height);
    self.view.frame = rect;
    [UIView commitAnimations];
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    [UIView beginAnimations:@"transform" context:nil];
    
    [UIView setAnimationDuration:0.3];
    CGRect rect = CGRectMake(0, -130, self.width, self.height);
    self.view.frame = rect;
    [UIView commitAnimations];
}
@end
