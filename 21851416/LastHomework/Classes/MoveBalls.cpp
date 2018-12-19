//
//  MoveBalls.cpp
//  MoveBall
//
//  Created by 贺晨韬 on 2018/12/13.
//

#include "MoveBalls.hpp"

Scene * MoveBalls::CreateScene(){
    auto s = Scene::createWithPhysics();
    s->getPhysicsWorld()->setDebugDrawMask(PhysicsWorld::DEBUGDRAW_ALL);
    SimpleAudioEngine::getInstance()->preloadEffect("contrat.caf");
    
    auto l = MoveBalls::create();
    l->setColor(Color3B(67,110,238));
    l->setPhyWorld(s->getPhysicsWorld());
    
    s->addChild(l);
     
    return s;
}

void MoveBalls::setPhyWorld(cocos2d::PhysicsWorld* world){
    m_world = world;
    m_world->setGravity(Vec2(1000,0));
    
    
}

bool MoveBalls::init(){
    
    LayerColor::initWithColor(Color4B(255,255,255,255));
    visibleSize = Director::getInstance()->getVisibleSize();
    
    maxScore = loadMaxScore();
    
    //分数显示
    scorelabel = Label::createWithSystemFont("", "TimesNewRoman", 24);
    addChild(scorelabel);
    
    
    //设置重新开始按钮
    resbtn = cocos2d::ui::Button::create();
    resbtn->loadTextureNormal("btn_true.png");
    resbtn->setPressedActionEnabled(false);
    resbtn->setScale9Enabled(true);
    resbtn->setTitleText("重");     //设置按钮标题,还有其他函数可以设置颜色，字体大小
    
    resbtn->setOpacity(100); //继承自node，设置node透明度，0完全透明
    
    resbtn->addTouchEventListener(CC_CALLBACK_2(MoveBalls::touchEvent,this));
    resbtn->setContentSize(Size(40, 40));     //设置按钮大小，必须setScale9Enabled(true)，不然没有用
    resbtn->setPosition(Vec2(20, 20));
    this->addChild(resbtn);
    
    //设置返回主界面按钮
    retbtn = cocos2d::ui::Button::create();
    retbtn->loadTextureNormal("btn_true.png");
    retbtn->setPressedActionEnabled(false);
    retbtn->setScale9Enabled(true);
    retbtn->setTitleText("反");     //设置按钮标题,还有其他函数可以设置颜色，字体大小
    
    retbtn->setOpacity(100); //继承自node，设置node透明度，0完全透明
    
    retbtn->addTouchEventListener(CC_CALLBACK_2(MoveBalls::returnmain,this));
    retbtn->setContentSize(Size(40, 40));     //设置按钮大小，必须setScale9Enabled(true)，不然没有用
    retbtn->setPosition(Vec2(retbtn->getContentSize().width/2, visibleSize.height-retbtn->getContentSize().height/2));
    this->addChild(retbtn);
    
    
    //上左边框
    auto edgeTopLeft = Sprite::create();
//    edgeTopLeft->setTexture("timg.png");
    auto TopLeftbody = PhysicsBody::createEdgeSegment(Vec2(0,0),Vec2(0,0.35f*visibleSize.height),PHYSICSBODY_MATERIAL_DEFAULT);
//    edgeTopLeft->setPosition(Vec2(0,-edgeTopLeft->getContentSize().height/2));
    edgeTopLeft->setPosition(Vec2(0.1f*visibleSize.width,0.15f*visibleSize.height));
    edgeTopLeft->setPhysicsBody(TopLeftbody);
    this->addChild(edgeTopLeft);
    
    //上右边框
    auto edgeTopRight = Sprite::create();
    auto TopRightbody = PhysicsBody::createEdgeSegment(Vec2(0,0),Vec2(0,-0.35f*visibleSize.height));
    edgeTopRight->setPosition(Vec2(0.1f*visibleSize.width,0.85f*visibleSize.height));
    edgeTopRight->setPhysicsBody(TopRightbody);
//    edgeTopRight->setTexture("timg.png");
    this->addChild(edgeTopRight);
    
    //左边框
    auto edgeLeft = Sprite::create();
    auto LeftBody = PhysicsBody::createEdgeSegment(Vec2(0,0),Vec2(0.7f*visibleSize.width,0));
    edgeLeft->setPosition(Vec2(0.1f*visibleSize.width,0.15f*visibleSize.height));
    edgeLeft->setPhysicsBody(LeftBody);
    this->addChild(edgeLeft);
    
    //右边框
    auto edgeRight = Sprite::create();
    auto RightBody = PhysicsBody::createEdgeSegment(Vec2(0,0),Vec2(0.7f*visibleSize.width,0));
    edgeRight->setPosition(Vec2(0.1f*visibleSize.width,0.85f*visibleSize.height));
    edgeRight->setPhysicsBody(RightBody);
    this->addChild(edgeRight);
    
    
    //底部
    auto edgeEnd = Sprite::create();
    Vec2 point[3];
    point[0] = Vec2(0.3f*visibleSize.width,0.5f*visibleSize.height);
    point[1] = Vec2(0.3f*visibleSize.width,-0.5f*visibleSize.height);
    point[2] = Vec2(0,0);
    auto EndBody = PhysicsBody::createPolygon(point, 3, PhysicsMaterial(0.0f,1.0f,0.0f));
    EndBody->setDynamic(false);
    edgeEnd->setPosition(Vec2(0.7f*visibleSize.width,visibleSize.height/2));
    edgeEnd->setPhysicsBody(EndBody);
    edgeEnd->setTexture("EndTri.png");
    edgeEnd->setColor(Color3B(110,110,110));
    this->addChild(edgeEnd);
    
    auto listner = EventListenerTouchOneByOne::create();
    
    listner->onTouchBegan = [](Touch* touch,Event* ev){return true;};
    listner->onTouchEnded = [&](Touch* touch,Event* ev){
        if (isContart == false && isRise == false){
            float posX =touch->getLocation().x;
            float posY = touch->getLocation().y;
            if (posX<0.1f*visibleSize.width || fabs(posY - 0.5*visibleSize.height)>0.35*visibleSize.height)
                return ;
            TouchPos = Vec2(posX,posY);
            click = 0;
            schedule(schedule_selector(MoveBalls::delayCall),0.1f,CC_REPEAT_FOREVER,0.0f);
        }
    };
    _eventDispatcher->addEventListenerWithSceneGraphPriority(listner, this);
    
    restart();
    
    contact();
    schedule(schedule_selector(MoveBalls::MyUpdate));
    
    return true;
}

void MoveBalls::contact(){
    EventListenerPhysicsContact* evContact = EventListenerPhysicsContact::create();
    
    evContact->onContactBegin = [](PhysicsContact& contract){
        return true;
    };
    evContact->onContactSeparate = [=](PhysicsContact& contract)
    {
        auto bodyA = (Sprite*)(contract.getShapeA()->getBody()->getNode());
        auto bodyB = (Sprite*)(contract.getShapeB()->getBody()->getNode());
        if (!bodyA || !bodyB){
            return ;
        }
        SimpleAudioEngine::getInstance()->playEffect("contrat.caf");
        int tagA = bodyA->getTag();
        int tagB = bodyB->getTag();
        if (tagA==1 || tagA==2 ||tagA ==3){
            score++;
            auto shape = (Shape *)(contract.getShapeA()->getBody()->getNode());
            shape->crash();
            if (shape->counts<=0){
                deletedshapes.pushBack(shape);
                bodyA->removeFromParentAndCleanup(true);
            }
        }
        if (tagB==1 || tagB==2 ||tagB ==3){
            score++;
            auto shape = (Shape *)(contract.getShapeB()->getBody()->getNode());
            shape->crash();
            if (shape->counts<=0){
                deletedshapes.pushBack(shape);
                bodyB->removeFromParentAndCleanup(true);
            }
        }
    };
    _eventDispatcher->addEventListenerWithSceneGraphPriority(evContact, this);
}


bool MoveBalls::addBall(){
    
    Ball* ball = Ball::create();
    ball->setPosition(Vec2(0.2f*visibleSize.width/2,visibleSize.height/2));
    ball->setTag(0);
    
    addChild(ball);
    
    balls.pushBack(ball);
    return true;
}

void MoveBalls::BallMove(Ball* ball, float x, float y, float force){
    auto body = PhysicsBody::createCircle(12,PhysicsMaterial(0.0f,1.0f,0.0f));
    body->setContactTestBitmask(0xFFFFFFFF);
    //    Vect force = Vect(1000.0f,1000.0f);
    //    body->applyImpulse(force);
    Vec2 speedVec = Vec2(x-0.15f*visibleSize.width/2,y-visibleSize.height/2);
    //    Vec2 speedVec = Vec2(x,y);
    float Mode = speedVec.length();
    //    scorelabel->setString("x:"+std::to_string(speedVec.x)+";y:"+std::to_string(speedVec.y)+";M:"+std::to_string(Mode));
    body->setVelocity(500*speedVec/Mode);
    body->setGroup(-10);
    ball->setPhysicsBody(body);
}

bool MoveBalls::addShape(int type, float x, float y){
    Shape *shape;
    if (type == 1){
        shape = circle::create();
        shape->init("Circle.png");
        shape->setTag(1);
        PhysicsBody* body = PhysicsBody::createCircle(shape->getInfo(),PhysicsMaterial(0.0f,1.0f,0.0f));
        body->setDynamic(false);
        body->setContactTestBitmask(0x1);
        shape->setPhysicsBody(body);
        shape->setPosition(Vec2(x, y));
        shape->display();
    }else if(type==2){
        shape = rectangle::create();
        shape->init("Rectangle.png");
        shape->setTag(2);
        float l = shape->getInfo();
        Vec2 point[4];
        point[0] = Vec2(-l/2,l/2);
        point[1] = Vec2(l/2,l/2);
        point[2] = Vec2(l/2,-l/2);
        point[3] = Vec2(-l/2,-l/2);
        PhysicsBody* body = PhysicsBody::createPolygon(point,4,PhysicsMaterial(0.0f,1.0f,0.0f));
        body->setDynamic(false);
        body->setContactTestBitmask(0x1);
        shape->setPhysicsBody(body);
        shape->setPosition(Vec2(x, y));
        shape->display();
    }else if (type>=3){
        shape = triangle::create();
        shape->init("triangle.png");
        shape->setTag(3);
        Vec2 point[3];
        float l = shape->getInfo();
        float lro = l / pow(3, 0.5);
        point[0] = Vec2(0,lro);
        point[1] = Vec2(l/2,-lro/2);
        point[2] = Vec2(-l/2,-lro/2);
        PhysicsBody* body = PhysicsBody::createPolygon(point,3,PhysicsMaterial(0.0f,1.0f,0.0f));
        body->setDynamic(false);
        body->setContactTestBitmask(0x1);
        shape->setPhysicsBody(body);
        shape->setPosition(Vec2(x, y));
        shape->display();
    }
    addChild(shape);
    shapes.pushBack(shape);
    return true;
}


void MoveBalls::MyUpdate(float dt){
    if (isRise == true){
        this->ShapeMove();
        isRise = false;
        isContart = false;
    }
    if (balls.empty()){
        if (isContart == true)
            isRise = true;
        return ;
    }
    Vector<Ball*> deletedballs;
    for (auto it=balls.begin(); it!=balls.end(); it++){
        if ((*it)->getPositionY()<0 || (*it)->getPositionY()>visibleSize.height || (*it)->getPositionX()<0.1f*visibleSize.width || (*it)->getPositionX()>visibleSize.width){
            (*it)->removeFromParentAndCleanup(true);
            deletedballs.pushBack(*it);
        }
    }
//    if (ballNum < score/20){
//        ballNum = score;
//    }
    for (auto it=deletedballs.begin(); it!=deletedballs.end(); it++){
        balls.eraseObject(*it);
    }
    deletedballs.clear();
    
    for (auto it=deletedshapes.begin(); it!=deletedshapes.end(); it++){
        shapes.eraseObject(*it);
    }
    deletedshapes.clear();
    
    if (score > maxScore)
        maxScore = score;
    showScore();
}

void MoveBalls::showScore(){
    scorelabel->setString("分数:" + std::to_string(score));
}

void MoveBalls::restart(){
    
    //清除所有小球和Shape
    for (auto it=balls.begin(); it!=balls.end(); it++){
        (*it)->removeFromParentAndCleanup(true);
    }
    balls.clear();
    for (auto it=shapes.begin(); it!=shapes.end(); it++){
        (*it)->removeFromParentAndCleanup(true);
    }
    shapes.clear();
    //初始化
    score = 0;
    ballNum = 3;
    isContart = false;
    isRise = true;
    
    //分数显示初始化
    scorelabel->setPosition(Vec2(240,300));
    scorelabel->setTextColor(Color4B(0,0,0,255));
    
    showScore();
}

void MoveBalls::ShapeMove(){
    
    this->addShape(floor(CCRANDOM_0_1()*3)+1, 0.65*visibleSize.width, visibleSize.height*(CCRANDOM_0_1()*0.6+0.2));
    
    for (auto it=shapes.begin(); it!=shapes.end(); it++){
        (*it)->rise();
        if ((*it)->getPositionX()<0.3*visibleSize.width){
            this->gameover();
            break;
        }
    }
    for (int i=0; i<ballNum; i++){
        this->addBall();
    }
}

void MoveBalls::gameover(){
    this->saveMaxScore();
    this->restart();
}

void MoveBalls::touchEvent(Ref *pSender, cocos2d::ui::Widget::TouchEventType type)
{
    switch (type) {
        case cocos2d::ui::Widget::TouchEventType::ENDED:
            gameover();
            break;
        default:
            break;
    }
}

void MoveBalls::returnmain(Ref *pSender, cocos2d::ui::Widget::TouchEventType type)
{
    Director::getInstance()->popScene();
}

int MoveBalls::loadMaxScore(){
    
    //历史最高分数读取
    sqlite3* dbcon;
    int maxS = 0;
    int result = sqlite3_open("mysqlite.db", &dbcon);
    if (result != SQLITE_OK){
        sqlite3_close(dbcon);
        return -1;
    }
    
    //第一次启动创建表
    char *error = NULL;
    result = sqlite3_exec(dbcon, "create table if not exists 'Score' ('score' integer)", nullptr, nullptr, &error);
    if (result != SQLITE_OK){
        CCLOG("%s\n", error);
    }
    
    //查询
    int columns = 0, rows = 0;
    char** dbresult;
    result = sqlite3_get_table(dbcon, "select * from Score", &dbresult, &rows, &columns, &error);
    if (result == SQLITE_OK){
        if (rows == 0){
            sqlite3_close(dbcon);
            return 0;
        }
        maxS = int(*dbresult[1]);
    }
    else {
        sqlite3_close(dbcon);
        return -2;
    }
    
    //关闭
    result = sqlite3_close(dbcon);
    
    return maxS;
    
    
}


void MoveBalls::saveMaxScore(){
    
    //历史最高分数读取
    sqlite3* dbcon;
    int maxS = 0;
    int result = sqlite3_open("mysqlite.db", &dbcon);
    if (result != SQLITE_OK){
        sqlite3_close(dbcon);
        return ;
    }
    
    //查询
    char *error;
    int columns = 0, rows = 0;
    char** dbresult;
    result = sqlite3_get_table(dbcon, "select * from Score", &dbresult, &rows, &columns, &error);
    if (result == SQLITE_OK){
        if (rows == 0){
            std::string sql = "insert into Score(score) values ("+ std::to_string(maxScore) +")";
            
            result = sqlite3_exec(dbcon, sql.data(), nullptr, nullptr, &error);
            if (result != SQLITE_OK){
                CCLOG("%s\n", error);
            }
            
            result = sqlite3_close(dbcon);
            return ;
        }
        else{
            char* maxStr = dbresult[1];
            maxS = atof(maxStr);
        }
    }
    else {
        sqlite3_close(dbcon);
        return ;
    }
    
    if (maxS < maxScore){
//        CCLOG("<>%s<>%s\n",std::to_string(maxS).data(),std::to_string(maxScore).data());
        std::string sql = "update Score set score = "+ std::to_string(maxScore);
        
        result = sqlite3_exec(dbcon, sql.data(), nullptr, nullptr, &error);
        if (result != SQLITE_OK){
            CCLOG("%s\n", error);
        }
        
        result = sqlite3_close(dbcon);
        return ;
        
    }
    
    //关闭
    result = sqlite3_close(dbcon);
    
    return ;
    
    
}

void MoveBalls::delayCall(float dt){
    if(click >= ballNum){
        unschedule(schedule_selector(MoveBalls::delayCall));
        this->isContart = true;
    }
    else{
        this->BallMove(balls.at(click), TouchPos.x, TouchPos.y, 5);
        click++;
    }
}
