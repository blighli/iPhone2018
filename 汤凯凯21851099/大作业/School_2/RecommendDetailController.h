//
//  RecommendDetailController.h
//  游园
//
//  Created by Ray on 15/12/11.
//  Copyright © 2015年 Ray. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "MyRecommendViewController.h"
@interface RecommendDetailController : UIViewController<UIImagePickerControllerDelegate,UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextField *wordTextField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *kindSegmentControl;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end
