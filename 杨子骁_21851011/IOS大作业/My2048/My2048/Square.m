//
//  Square.m
//  My2048
//
//  Created by yang on 2018/11/17.
//  Copyright © 2018 yang. All rights reserved.
//

#import "Square.h"

@implementation Square {
    // Private instance variables
    int value;
    bool init; // see's if this block is a new block, show appear animation
}

/*-(id)initWithCoder:(NSCoder *)aDecoder{
 self = [super initWithCoder:aDecoder];
 if(self){
 
 }
 return self;
 }*/
- (id)init {
    if (!(self = [super init]))
        return nil;
    init = NO;
    value = -1;
    return self;
}

-(void)initValue {
    int r = arc4random() % 100;
    value = r > 60 ? 4: 2; //init to 4 or 2
    init = YES;
}

-(int)getValue{return value;}

-(void)setVal:(int)inVal{
    value = inVal;
    init = NO;
}

-(bool)getInit{return init;}

@end
