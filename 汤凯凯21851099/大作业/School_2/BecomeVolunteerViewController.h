//
//  becomeVolunteerViewController.h
//  游园
//
//  Created by Ray on 15/12/8.
//  Copyright © 2015年 Ray. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BecomeVolunteerViewController : UIViewController<UITextFieldDelegate,UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *idTextField;
@property (weak, nonatomic) IBOutlet UITextField *majorTextField;

@property (weak, nonatomic) IBOutlet UITextField *yearTextField;

@property (weak, nonatomic) IBOutlet UITextField *specialityTextField;

@property (weak, nonatomic) IBOutlet UITextField *loveTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;

@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UIImageView *cardImage;

@property UIDatePicker *dataPicker;
@property UIView *backView;


@end
