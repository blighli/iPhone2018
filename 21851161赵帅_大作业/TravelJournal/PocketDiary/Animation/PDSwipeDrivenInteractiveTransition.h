//
//  PDSwipeDrivenInteractiveTransition.h
//  PocketDiary
//
//  Created by 赵帅 on 2018/11/23.
//  Copyright © 2018 赵帅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PDSwipeDrivenInteractiveTransition : UIPercentDrivenInteractiveTransition

@property (nonatomic, assign) BOOL interacting;

- (void)wireToViewController:(UIViewController*)viewController;

@end
