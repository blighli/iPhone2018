//
//  triangle.cpp
//  MoveBall
//
//  Created by 贺晨韬 on 2018/12/15.
//

#include "triangle.hpp"

bool triangle::init(){
    
    Shape::init("triangle.png");
    
    l = 24;
    
    return true;
    
}

void triangle::crash(){
    
}

float triangle::getInfo(){
    return l;
}

void triangle::getPointList(Vec2 point[]){
    
    point[0] = Vec2(getPositionX(),getPositionY()+l/pow(3, 0.5));
    point[1] = Vec2(getPositionX()+l/2,getPositionY()+l/pow(3, 0.5));
    point[2] = Vec2(getPositionX()-l/2,getPositionY()+l/pow(3, 0.5));
    
    return ;
}
