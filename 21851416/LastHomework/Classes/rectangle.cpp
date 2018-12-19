//
//  rectangle.cpp
//  MoveBall
//
//  Created by 贺晨韬 on 2018/12/15.
//

#include "rectangle.hpp"

bool rectangle::init(){
    
    Shape::init("Rectangle.png");
    
    l = 24;
    
    return true;
    
}

void rectangle::crash(){
    
}

float rectangle::getInfo(){
    return l;
}
