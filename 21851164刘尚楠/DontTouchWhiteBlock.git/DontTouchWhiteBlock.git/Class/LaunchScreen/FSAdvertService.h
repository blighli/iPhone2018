//
//  FSAdvertService.h
//  Nitrogen
//
//  Created by czy on 2018/12/2.
//  Copyright © 2018年 czy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FSLaunchScreenView.h"

@app_package(FSAdvertService, advert);

@interface FSAdvertService : NSObject

@singleton(FSAdvertService);

- (FSLaunchScreenView *)setUpLaunchScreenView;

@end
