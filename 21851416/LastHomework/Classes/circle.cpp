//
//  circle.cpp
//  MoveBall
//
//  Created by 贺晨韬 on 2018/12/15.
//

#include "circle.hpp"

bool circle::init(){
    
    Shape::init("Circle.png");
    
    r = 12;
    
    return true;
    
}


void circle::crash(){
}

float circle::getInfo(){
    return r;
}

