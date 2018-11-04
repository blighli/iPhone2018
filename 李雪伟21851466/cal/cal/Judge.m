//
//  Judge.m
//  cal
//
//  Created by M David on 18-10-20.
//  Copyright (c) 2018年 M David. All rights reserved.
//

#import "Judge.h"

@implementation Judge

+(bool)yearJudge:(int) year{
    if(year <10000&&year>0){
        return  true;
    }else{
        return false;
    }
}

+(bool)monthJudge:(int) month{
    if(month>0&&month<13){
        return true;
    }else{
        return false;
    }
}



@end
