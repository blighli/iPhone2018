//
//  Square.h
//  My2048
//
//  Created by yang on 2018/11/17.
//  Copyright © 2018 yang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Square : UIView {
    
}
-(void)initValue;
-(int)getValue;
-(void)setVal:(int)inVal;
-(bool)getInit;


@end
NS_ASSUME_NONNULL_END
