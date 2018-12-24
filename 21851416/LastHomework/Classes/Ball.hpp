//
//  Ball.hpp
//  MoveBall
//
//  Created by 贺晨韬 on 2018/12/13.
//

#ifndef Ball_hpp
#define Ball_hpp

#include <stdio.h>
#include "cocos2d.h"

USING_NS_CC;

class Ball:public Sprite{
public:
    virtual bool init();
    void setSpeed(Vec2 speed);
    Vec2 getSpeed();
    int getR();
    void move();
    
    CREATE_FUNC(Ball);
private:
    float speedX;
    float speedY;
    int r;
    Size visibleSize;
};

#endif /* Ball_hpp */
