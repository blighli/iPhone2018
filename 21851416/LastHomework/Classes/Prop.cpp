//
//  Prop.cpp
//  MoveBall
//
//  Created by 贺晨韬 on 2018/12/19.
//

#include "Prop.hpp"

bool Prop::init(){
    
    Shape::init("AddNumber.png");
    
    r = 22;
    
    return true;
    
}

void Prop::display(){
    
}

void Prop::crash(){
}

float Prop::getInfo(){
    return r;
}

