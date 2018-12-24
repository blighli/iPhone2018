//
//  triangle.hpp
//  MoveBall
//
//  Created by 贺晨韬 on 2018/12/15.
//

#ifndef triangle_hpp
#define triangle_hpp

#include <stdio.h>
#include "cocos2d.h"
#include "Shape.hpp"
#include "Ball.hpp"

USING_NS_CC;

class triangle:public Shape{
public:
    virtual bool init();
    void crash();
    float getInfo();
    void getPointList(Vec2 point[]);
    
    CREATE_FUNC(triangle);
private:
    float l;
};

#endif /* triangle_hpp */
