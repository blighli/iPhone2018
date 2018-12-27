//
//  DrawView.swift
//  解锁项目（Swift）
//
//  Created by ding on 18/12/20.
//  Copyright (c) 2018年 ding. All rights reserved.

import UIKit
//声明一个协议
@objc protocol drawViewDelegate{
    func lockViewDidFinish(drawV:DrawView,path:NSString) //传递路径
}
class DrawView: UIView {
    //设置代理
    @IBOutlet weak var lockDelegate:(drawViewDelegate)!
    var btnSelectArr:NSMutableArray=[] //用来保存获取到的按钮集合(选中的按钮)
    //storyBoard、XIB关联，必须实现此方法
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //接收通知
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "cleanBtns", name: "whClean", object: nil)
        createButton() //加载
    }
    //清空按钮，并重绘
    func cleanBtns(){
        self.btnSelectArr.removeAllObjects()
        self.setNeedsDisplay()
    }
    //自定义方法：创建九宫格
    func createButton(){
        var secret = 0
        for row in 0...2{
            for col in 0...2{
                //设置9个按钮的位置和Image
                let buttonDistance = 100 //间距
                let firstBtnPointX = 44 //第一个按钮的X
                let firstBtnPointY = 24 //第一个按钮的Y
                var tempX:(CGFloat) = CGFloat(firstBtnPointX + col*buttonDistance)
                var tempY:(CGFloat) = CGFloat(firstBtnPointY + row*buttonDistance)
                //声明按钮
                var btn:(UIButton) = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
                btn.userInteractionEnabled = false //关闭用户交互
                btn.frame=CGRectMake(tempX, tempY, 100, 100)
                btn.setImage(UIImage(named: "gesture_node_normal"), forState: UIControlState.Normal) //默认
                btn.setImage(UIImage(named: "gesture_node_highlighted"), forState: UIControlState.Selected) //选中
                btn.tag = secret++ //用来当做密码
                self.addSubview(btn)
            }
        }
    }
    //抽代码：返回获取到的触摸点
    func pointWithTouches(touches:NSSet) -> CGPoint{
        var touch: AnyObject? = touches.anyObject() //任意对象anyObject
        //获取位置
        var pos:(CGPoint) = touch!.locationInView(touch!.view) //解包touch!
        return pos
    }
    //抽代码：获取触摸到的按钮
    func buttonWithPoint(point:CGPoint) -> UIButton?{
        for btn in self.subviews //遍历当前VIEW的子视图
        {
            if CGRectContainsPoint(btn.frame, point){
                //表示触摸的点在按钮上
                return btn as? UIButton
            }
        }
        return nil
    }
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        //取出触摸点
        var pos:(CGPoint) = self.pointWithTouches(touches)
        //获取触摸到的按钮
        var btn:(UIButton)? = self.buttonWithPoint(pos)
        if self.btnSelectArr.containsObject(btn!)==false{
            //表示触摸到的按钮并没有在集合中
            addBtn(btn)
        }
        //刷新
        self.setNeedsDisplay()
    }
    func addBtn(btn:UIButton!){
        btn!.selected = true //让按钮选中
        //加载到可变数组
        self.btnSelectArr.addObject(btn!)
    }
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        var pos:(CGPoint) = self.pointWithTouches(touches)
        var btn:(UIButton)?=self.buttonWithPoint(pos)
        //按钮未被选中，并且按钮不为空
        if((btn != nil)&&(btn?.selected == false)){
            addBtn(btn)
        }
        //刷新
        self.setNeedsDisplay()
    }
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        //判断有无代理
        if lockDelegate != nil{
            var str:(NSMutableString) = NSMutableString()
            if self.btnSelectArr.count > 0{
                //遍历
                for index in 0...self.btnSelectArr.count-1{
                    var btn:(UIButton) = self.btnSelectArr.objectAtIndex(index) as! UIButton
                    //把按钮的tag值拼接到可变字符串
                    str.appendFormat("%ld", btn.tag)
                }
                if str.length > 0{
                    //发送消息
                    lockDelegate.lockViewDidFinish(self, path: str)
                }
            }
        }
        //把选中的按钮设为默认状态
        if self.btnSelectArr.count > 0{
            //遍历数组
            for index in 0...self.btnSelectArr.count-1{
                var btn:(UIButton) = self.btnSelectArr.objectAtIndex(index) as! UIButton
                btn.selected=false
            }
        }
        self.btnSelectArr.removeAllObjects() //清空数组
        self.setNeedsDisplay() //界面重绘
    }
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        //有没有按钮
        if self.btnSelectArr.count == 0{
            return //没有选中按钮直接返回
        }
        //有按钮，则绘制
        var path:(UIBezierPath) = UIBezierPath(); //创建路径
        for index in 0...self.btnSelectArr.count-1{
            var btn:(UIButton)=self.btnSelectArr.objectAtIndex(index) as! (UIButton)
            //第一个按钮（每次绘制的起点）
            if index==0{
                path.moveToPoint(btn.center)
            }
            else{
                path.addLineToPoint(btn.center) //连接
            }
        }
        path.lineWidth = 8 //线宽
        UIColor.blueColor().set() //颜色
        path.stroke()
    }

}
