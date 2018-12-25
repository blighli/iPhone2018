//
//  CZUMShare.h
//  91VPN
//
//  Created by weichengzong on 2017/8/29.
//  Copyright © 2017年 weichengzong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CZUMShare : NSObject
+ (void)UMShare91:(UIViewController *)vc;
- (void)UMSharewithimg:(NSString *)img title:(NSString *)title content:(NSString *)content url:(NSString *)url;
@end
