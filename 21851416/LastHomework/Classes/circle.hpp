//
//  circle.hpp
//  MoveBall
//
//  Created by 贺晨韬 on 2018/12/15.
//

#ifndef circle_hpp
#define circle_hpp

#include <stdio.h>
#include "cocos2d.h"
#include "Shape.hpp"
#include "Ball.hpp"

USING_NS_CC;

class circle:public Shape{
public:
    virtual bool init();
    void crash();
    float getInfo();
    
    CREATE_FUNC(circle);
private:
    float r;
    
};

#endif /* circle_hpp */
