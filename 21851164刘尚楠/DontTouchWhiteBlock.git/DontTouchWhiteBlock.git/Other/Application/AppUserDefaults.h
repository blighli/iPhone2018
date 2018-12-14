//
//  AppUserDefaults.h
//  Nitrogen-mac
//
//  Created by czy on 12/11/2018.
//  Copyright © 2018 czy. All rights reserved.
//

#import <Foundation/Foundation.h>

@app_package(AppUserDefaults, defaults);

@interface AppUserDefaults : NSObject

@singleton(AppUserDefaults);

@property (nonatomic, copy) NSString *classScore;
@property (nonatomic, copy) NSString *jiejiScore;

@end
