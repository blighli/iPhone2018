//
//  rectangle.hpp
//  MoveBall
//
//  Created by 贺晨韬 on 2018/12/15.
//

#ifndef rectangle_hpp
#define rectangle_hpp

#include <stdio.h>
#include "cocos2d.h"
#include "Shape.hpp"
#include "Ball.hpp"

USING_NS_CC;

class rectangle:public Shape{
public:
    virtual bool init();
    void crash();
    float getInfo();
    
    
    CREATE_FUNC(rectangle);
    
private:
    float l;
    
};

#endif /* rectangle_hpp */
