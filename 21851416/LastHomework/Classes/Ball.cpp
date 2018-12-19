//
//  Ball.cpp
//  MoveBall
//
//  Created by 贺晨韬 on 2018/12/13.
//

#include "Ball.hpp"

bool Ball::init(){
    
    Sprite::initWithFile("ball2.png");
    
    
    speedX = CCRANDOM_0_1()*200-100;
    speedY = CCRANDOM_0_1()*200-50;
    
    visibleSize = Director::getInstance()->getVisibleSize();
    
    setAnchorPoint(Vec2(0.5,0.5));
    r = getContentSize().width/2;
    
    return true;
}

void Ball::move(){
    setPositionX(getPositionX()+speedX);
    setPositionY(getPositionY()+speedY);
    
    
    if (getPositionX()>visibleSize.width-getContentSize().width/2){
        speedX = -fabs(speedX);
    }else if (getPositionX()<getContentSize().width/2){
        speedX = fabs(speedX);
    }else if (getPositionY()>visibleSize.height-getContentSize().height/2){
        speedY = -fabs(speedY);
    }else if (getPositionY()<getContentSize().height/2){
        speedY = fabs(speedY);
    }
}

void Ball::setSpeed(Vec2 speed){
    speedX = speed.x;
    speedY = speed.y;
}

Vec2 Ball::getSpeed(){
    return Vec2(speedX,speedY);
}

int Ball::getR(){
    return r;
}
