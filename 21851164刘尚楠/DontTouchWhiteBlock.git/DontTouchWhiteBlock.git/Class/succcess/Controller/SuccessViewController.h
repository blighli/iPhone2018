//
//  SuccessViewController.h
//  DontTouchWhiteBlock
//
//  Created by Marveliu on 18/11/20.
//  Copyright © 2018年 Marveliu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SuccessViewController : UIViewController
/** block回调 */
@property (copy, nonatomic) void (^buttonClick)(BOOL);

/** 标题 */
@property (copy, nonatomic) NSString *titleName;

/** 得分 */
@property (copy, nonatomic) NSString *score;


@end
