//
//  Store.m
//  tasklist
//
//  Created by dxy on 2018/10/31.
//  Copyright © 2018年 dxy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Store.h"

@implementation Store

-(id)initWithName:(NSString*)name{
    self->plistName = [name copy];
    return self;
};

-(NSString*)getPlistPath{
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [path objectAtIndex:0];
    NSString *fileName = [NSString stringWithFormat:@"%@.plist", self->plistName];
    NSString *plistPath = [documentsPath stringByAppendingPathComponent:fileName];
    return plistPath;
};

-(NSMutableArray*)readPlist{
    NSString *path = [self getPlistPath];
    NSMutableArray *data = [[NSMutableArray alloc] initWithContentsOfFile:path];
    return data;
};
-(void)savePlist:(NSMutableArray*)data{
    NSString *path = [self getPlistPath];
    [data writeToFile:path atomically:YES];
};

@end
