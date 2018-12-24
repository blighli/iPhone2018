//
//  Prop.hpp
//  MoveBall
//
//  Created by 贺晨韬 on 2018/12/19.
//

#ifndef Prop_hpp
#define Prop_hpp

#include <stdio.h>
#include "cocos2d.h"
#include "Shape.hpp"

USING_NS_CC;

class Prop:public Shape{
public:
    virtual bool init();
    void crash();
    float getInfo();
    void display();
    
    CREATE_FUNC(Prop);
private:
    float r;
};

#endif /* Prop_hpp */
