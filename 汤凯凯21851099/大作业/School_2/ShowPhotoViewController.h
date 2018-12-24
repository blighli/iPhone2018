//
//  ShowPhotoViewController.h
//  游园
//
//  Created by Ray on 15/12/10.
//  Copyright © 2015年 Ray. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowPhotoViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *houseName;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;

//记录是那个楼的编号
@property NSInteger num;

@end
