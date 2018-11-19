//
//  Store.h
//  tasklist
//
//  Created by dxy on 2018/10/31.
//  Copyright © 2018年 dxy. All rights reserved.
//

#ifndef Store_h
#define Store_h

@interface Store : NSObject
{
    NSString *plistName;
}

-(id)initWithName:(NSString*)name;

-(NSString*)getPlistPath;
-(NSMutableArray*)readPlist;
-(void)savePlist:(NSMutableArray*)data;

@end

#endif /* Store_h */
