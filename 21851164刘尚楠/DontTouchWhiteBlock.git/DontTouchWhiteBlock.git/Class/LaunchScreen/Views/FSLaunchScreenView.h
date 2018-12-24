//
//  FFLaunchScreenView.h
//  Nitrogen
//
//  Created by czy on 2018/12/2.
//  Copyright © 2018年 czy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^launchComplete)(NSString *skipUrlString);

@interface FSLaunchScreenView : UIView

@property (nonatomic, strong) launchComplete launchComplete;


@end
