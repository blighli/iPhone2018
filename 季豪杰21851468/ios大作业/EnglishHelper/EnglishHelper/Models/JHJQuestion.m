//
//  JHJQuestion.m
//  EnglishHelper
//
//  Created by pc－jhj on 2018/12/13.
//  Copyright © 2018年 jhj. All rights reserved.
//

#import "JHJQuestion.h"

@implementation JHJQuestion

-(instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.answer = dict[@"answer"];
        self.title = dict[@"title"];
        self.icon = dict[@"icon"];
        self.options = dict[@"options"];
    }
    
    return self;
}


+(instancetype)questionWithDict:(NSDictionary *)dict
{
    return [[self alloc]initWithDict:dict];
}
@end
