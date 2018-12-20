//
//  Shape.hpp
//  MoveBall
//
//  Created by 贺晨韬 on 2018/12/15.
//

#ifndef Shape_hpp
#define Shape_hpp

#include <stdio.h>

#include "cocos2d.h"
#include "Ball.hpp"

USING_NS_CC;

class Shape:public Sprite{
public:
    virtual bool init();
    virtual bool init(const std::string& filename);
    
    void rise();
    void crash();
    virtual float getInfo();
    void display();
    void display(const std::string& text);
    void getPointList(Vec2 point[]);
    float getDisgtance(Vec2 point);
    
    CREATE_FUNC(Shape);
    
    int counts;
    Label* lb;
    Size visibleSize;
    
};
#endif /* Shape_hpp */
