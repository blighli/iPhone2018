//
//  PopAlertDialog.cpp
//  MoveBall
//
//  Created by 贺晨韬 on 2018/12/18.
//

#include "PopAlertDialog.hpp"

PopAlertDialog::PopAlertDialog():m__pMenu(NULL)
,m_contentPadding(0)
,m_contentPaddingTop(0)
,m_callbackListener(NULL)
,m_callback(NULL)
,m__sfBackGround(NULL)
,m__s9BackGround(NULL)
,m__ltContentText(NULL)
,m__ltTitle(NULL)
{
}



PopAlertDialog::~PopAlertDialog(){
    
    CC_SAFE_RELEASE(m__pMenu);
    
    CC_SAFE_RELEASE(m__sfBackGround);
    
    CC_SAFE_RELEASE(m__s9BackGround);
    
    CC_SAFE_RELEASE(m__ltContentText);
    
    CC_SAFE_RELEASE(m__ltTitle);
    
}



bool PopAlertDialog::init(){
    
    if (!CCLayerColor::init()) {
        
        return false;
        
    }
    
    
    
    Menu* menu=Menu::create();
    
    menu->setPosition(CCPointZero);
    
    setMenuButton(menu);
    
    
    
    
    
    auto listener=EventListenerTouchOneByOne::create();
    
    listener->setSwallowTouches(true);
    
    listener->onTouchBegan=CC_CALLBACK_2(PopAlertDialog::onTouchBegan, this);
    
    listener->onTouchMoved=CC_CALLBACK_2(PopAlertDialog::onTouchMoved, this);
    
    listener->onTouchEnded=CC_CALLBACK_2(PopAlertDialog::onTouchEnded, this);
    
    auto dispatcher=Director::getInstance()->getEventDispatcher();
    
    dispatcher->addEventListenerWithSceneGraphPriority(listener, this);
    
    //设置弹出层的颜色，指定为淡灰色
    
    setColor(Color3B::GRAY);
    
    setOpacity(128);
    
    
    
    return true;
    
}



bool PopAlertDialog::onTouchBegan(Touch* touch,Event* event){
    
    return true;
    
}



void PopAlertDialog::onTouchMoved(Touch* touch,Event* event){
    
    
    
}





void PopAlertDialog::onTouchEnded(Touch* touch,Event* event){
    
    
    
}





PopAlertDialog* PopAlertDialog::create(const char* backgoundImage,Size dialogSize){
    
    //创建弹出对话框，指定背景图和大小。
    
    PopAlertDialog* layer=PopAlertDialog::create();
    
    //layer->setSpriteBackGround(Sprite::create(backgoundImage));
    
    layer->setSprite9BackGround(Scale9Sprite::create(backgoundImage));
    
    
    
    layer->m_dialogContentSize=dialogSize;
    
    return layer;
    
}







void PopAlertDialog::setTitle(const char* title,int fontsize /*=20*/){
    
    LabelTTF* label=LabelTTF::create(title, "", fontsize);
    
    label->setColor(Color3B::RED);
    
    setLabelTitle(label);
    
}



void PopAlertDialog::setContentText(const char* text,int fontsize,int padding,int paddingTop){
    
    LabelTTF* ltf=LabelTTF::create(text, "", fontsize);
    
    ltf->setColor(Color3B::BLUE);
    
    setLabelContentText(ltf);
    
    m_contentPadding=padding;
    
    m_contentPaddingTop=paddingTop;
    
}



void PopAlertDialog::setCallBackFunc(Ref*target, SEL_CallFuncN callfun){
    
    m_callbackListener=target;
    
    m_callback=callfun;
    
}



bool PopAlertDialog::addButton(const char *normalImage, const char *selectedImage,const char* title,int tag){
    
    Size winSize=Director::getInstance()->getWinSize();
    
    Point center_point=Point(winSize.width/2,winSize.height/2);
    
    auto menuImage=MenuItemImage::create(
                                         
                                         normalImage,
                                         
                                         selectedImage,
                                         
                                         CC_CALLBACK_1(PopAlertDialog::buttonCallBack,this) );
    
    menuImage->setTag(tag);
    
    menuImage->setPosition(center_point);
    
    
    
    Size menuSize=menuImage->getContentSize();
    
    Label* labelttf=Label::createWithTTF(title, "fonts/arial.ttf", 15);
    
    labelttf->setColor(Color3B(Color3B::BLACK));
    
    labelttf->setPosition(Point(menuSize.width/2,menuSize.height/2));
    
    menuImage->addChild(labelttf);
    
    getMenuButton()->addChild(menuImage);
    
    return true;
    
}



void PopAlertDialog::buttonCallBack(Ref* pSender){
    
    Node* node=dynamic_cast<Node*>(pSender);
    
    //log("[========PopAlertDialog:buttonCallBack=======]touch tag:%d",node->getTag());
    
    if (m_callback&&m_callbackListener) {
        
        (m_callbackListener->*m_callback)(node);
        
    }
    
    this->removeFromParentAndCleanup(true);
    
}



void  PopAlertDialog::onEnter(){
    
    //log("PopAlertDialog::onEnter is loading");
    
    
    
    LayerColor::onEnter();
    
    Size winSize=Director::getInstance()->getWinSize();
    
    Point center=Point(winSize.width/2,winSize.height/2);
    
    
    
    //Sprite* background=getSpriteBackGround();
    
    Scale9Sprite* background=getSprite9BackGround();
    
    background->setContentSize(m_dialogContentSize);//指定对话框大小
    
    background->setPosition(Point(winSize.width/2,winSize.height/2));
    
    this->addChild(background,0,0);
    
    Action* popupActions=Sequence::create(                                                                                       ScaleTo::create(0.0, 0.0),ScaleTo::create(0.06, 1.05),ScaleTo::create(0.08, 0.95),ScaleTo::create(0.08,1.0),CallFunc::create(CC_CALLBACK_0(PopAlertDialog::backgroundFinish, this)), NULL);
    
    background->runAction(popupActions);
    
}





void PopAlertDialog::backgroundFinish(){
    
    Size winSize=Director::getInstance()->getWinSize();
    
    Point pCenter=Point(winSize.width/2,winSize.height/2);
    
    this->addChild(getMenuButton());
    
    float btnWidth=m_dialogContentSize.width/(getMenuButton()->getChildrenCount()+1);
    
    Vector<Node*> vector=getMenuButton()->getChildren();
    
    Ref* pObj=NULL;
    
    int i=0;
    
    for (Node*pObj:vector){
        
        Node* node=dynamic_cast<Node*>(pObj);
        
        node->setPosition(Point(winSize.width/2-m_dialogContentSize.width/2+btnWidth*(i+1),winSize.height/2-m_dialogContentSize.height/3));
        
        i++;
        
    }
    
    if (getLabelTitle()) {
        
        getLabelTitle()->setPosition(ccpAdd(pCenter, ccp(0,m_dialogContentSize.height/2-35.0f)));
        
        this->addChild(getLabelTitle());
        
    }
    
    if (getLabelContentText()) {
        
        CCLabelTTF* ltf=getLabelContentText();
        
        ltf->setPosition(ccp(winSize.width/2,winSize.height/2));
        
        ltf->setDimensions(CCSizeMake(m_dialogContentSize.width-m_contentPadding*2, m_dialogContentSize.height-m_contentPaddingTop));
        
        ltf->setHorizontalAlignment(kCCTextAlignmentLeft);
        
        this->addChild(ltf);
        
    }
    
    
    
}



void PopAlertDialog::onExit(){
    
    log("PopAlertDialog onExit");
    
    CCLayerColor::onExit();
    
}
