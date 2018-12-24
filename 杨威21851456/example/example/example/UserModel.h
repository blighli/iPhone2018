//
//  UserModel.h
//  在线学习平台
//
//  Created by Xia Wei on 17/5/7.
//  Copyright © 2017年 Xia Wei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject

@property(nonatomic,strong)NSString* userName;
@property(nonatomic,strong)NSString* password;
@property(nonatomic,assign)NSInteger userID;
@property(nonatomic,strong)NSString* nickName;
    
- (id)init:(NSString *)userName password:(NSString *)password;

@end
