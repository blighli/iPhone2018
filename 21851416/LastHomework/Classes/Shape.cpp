//
//  Shape.cpp
//  MoveBall
//
//  Created by 贺晨韬 on 2018/12/15.
//

#include "Shape.hpp"

bool Shape::init(){
    init("Circle.png");
    return true;
}

bool Shape::init(const std::string& filename){
    
    Sprite::initWithFile(filename);
    
    visibleSize = Director::getInstance()->getVisibleSize();
    
    counts = 10;
    
    lb = Label::createWithSystemFont("", "TimesNewRoman", 12);
    lb->setPosition(Vec2(12,12));
    lb->setTextColor(Color4B(0,0,0,255));
    addChild(lb);
    
    setAnchorPoint(Vec2(0.5f,0.5f));

    return true;
    
}

void Shape::rise(){
    int posX = getPositionX();
    
    setPositionX(posX-20);
}

void Shape::crash(){
    counts--;
    display();
}

float Shape::getInfo(){
    return 1.0f;
}

void Shape::display(){
    if (counts<=0)
        lb->cleanup();
    else lb->setString(std::to_string(counts));
}

void Shape::display(const std::string &text){
    lb->setString(text);
}

void Shape::getPointList(Vec2 point[]){
    return ;
}
