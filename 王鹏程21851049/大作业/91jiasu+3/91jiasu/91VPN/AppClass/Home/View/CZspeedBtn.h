//
//  CZspeedBtn.h
//  91加速
//
//  Created by weichengzong on 2017/8/18.
//  Copyright © 2017年 weichengzong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FLAnimatedImageView.h"

typedef NS_ENUM(NSUInteger,Btnstate){
    btndefaultstate,
    btnstartstate,
    btnsuccessstate
};
typedef void(^btnAction)();

@interface CZspeedBtn : UIView

@property (nonatomic ,strong)FLAnimatedImageView *imageView;
@property (nonatomic ,assign)Btnstate state;
@property (nonatomic ,copy)btnAction action;

- (void)btndefault;
- (void)start;
- (void)btnsuccess;

@end
