//
//  MoveBalls.hpp
//  MoveBall
//
//  Created by 贺晨韬 on 2018/12/13.
//

#ifndef MoveBalls_hpp
#define MoveBalls_hpp

#include <stdio.h>
#include <unistd.h>
#include "cocos2d.h"
#include "cocos-ext.h"
#include "Ball.hpp"
#include "Shape.hpp"
#include "circle.hpp"
#include "triangle.hpp"
#include "rectangle.hpp"
#include "SimpleAudioEngine.h"
#include "sqlite3.h"

using namespace CocosDenshion;

USING_NS_CC;
USING_NS_CC_EXT;


class MoveBalls:public LayerColor{
public:
    virtual bool init();
    CREATE_FUNC(MoveBalls);
    
//    virtual void update(float dt);
    virtual void MyUpdate(float dt);
    static Scene * CreateScene();
    
private:
    Vector<Ball*> balls;
    Vector<Shape*> shapes;
    Vector<Shape*> deletedshapes;
    PhysicsWorld* m_world;
    Size visibleSize;
    Label* scorelabel;
    cocos2d::ui::Button* resbtn;
    cocos2d::ui::Button* retbtn;
    Vec2 TouchPos;
    int click;
    
    bool isContart;
    bool isRise;
    int score;
    int ballNum;
    int maxScore;
    
    bool addBall();
    void BallMove(Ball* ball, float x, float y, float force);
    bool addShape(int type, float x, float y);
    void setPhyWorld(cocos2d::PhysicsWorld* world);
    void showScore();
    void contact();
    void restart();
    void ShapeMove();
    void gameover();
    void touchEvent(Ref *pSender, cocos2d::ui::Widget::TouchEventType type);
    void returnmain(Ref *pSender, cocos2d::ui::Widget::TouchEventType type);
    int loadMaxScore();
    void saveMaxScore();
    void delayCall(float dt);
    
};

#endif /* MoveBalls_hpp */
