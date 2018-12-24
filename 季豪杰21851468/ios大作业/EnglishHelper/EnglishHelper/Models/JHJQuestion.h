//
//  JHJQuestion.h
//  EnglishHelper
//
//  Created by pc－jhj on 2018/12/13.
//  Copyright © 2018年 jhj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JHJQuestion : NSObject

@property (nonatomic,copy) NSString *answer;
@property (nonatomic,copy) NSString *icon;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,strong) NSString *options ;

-(instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype)questionWithDict:(NSDictionary *)dict;

@end
