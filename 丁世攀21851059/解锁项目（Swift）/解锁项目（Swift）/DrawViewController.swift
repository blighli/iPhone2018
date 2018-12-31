//
//  ViewController.swift
//  解锁项目（Swift）
//
//  Created by ding on 18/12/20.
//  Copyright (c) 2018年 ding. All rights reserved.
//

import UIKit

class DrawViewController: UIViewController ,drawViewDelegate //采用协议!
{
    //根据tag值在本视图进行不同加载
    var whTag:(Int) = 0
    //标题属性
    @IBOutlet weak var titleLable: UILabel!
    //动态显示绘制手势后的结果
    @IBOutlet weak var resultLable: UILabel!
    //忘记密码按钮执行的方法
    @IBAction func forgotSecret() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(animated: Bool) {
        resultLable.textColor=UIColor.orangeColor()
        switch whTag{
        case 100: //设置密码
            resultLable.text = "请设置新密码"
            titleLable.text = "设置密码"
            //每次应该先清空
            NSUserDefaults.standardUserDefaults().setObject(nil, forKey: "wh")
            break;
        case 101: //验证密码
            resultLable.text = "请滑动输入密码"
            titleLable.text = "手势解锁"
            break;
        case 102: //修改密码
            resultLable.text = "请先输入旧密码"
            titleLable.text = "修改密码"
            break;
        default:
            break;
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    var updateTag = 0 //修改的时候会用到
    //实现协议
    func lockViewDidFinish(drawV: DrawView, path: NSString) {
        if path.length<4{
            resultLable.text = "请至少连接4个点!"
            resultLable.textColor = UIColor.redColor()
        }
        else
        {
            if NSUserDefaults.standardUserDefaults().objectForKey("wh") == nil{
                resultLable.text = "请输入刚才的密码"
                resultLable.textColor=UIColor.orangeColor()
                //存入
                NSUserDefaults.standardUserDefaults().setObject(path, forKey: "wh")
            }
            else if(NSUserDefaults.standardUserDefaults().objectForKey("wh")?.isEqual(path) != true){
                resultLable.textColor = UIColor.redColor()
                if whTag == 100{
                    resultLable.text="密码不一致，请重新输入"
                }
                else if whTag == 101{
                    resultLable.text="验证失败!"
                }
                else {
                    if updateTag == 0{
                        resultLable.text = "旧密码输入错误"
                    }
                    else
                    {
                        resultLable.text="密码不一致，请重新输入新密码"
                    }
                }
            }
            else //两次密码一致
            {
                resultLable.textColor = UIColor.orangeColor()
                if whTag == 100{
                    resultLable.text = "密码设置成功!"
                    //自动返回
                    autoBack()
                }
                else if whTag == 101{
                    resultLable.text = "密码验证成功!"
                    //自动返回
                    autoBack()
                }
                else
                {
                    if updateTag == 0{
                        resultLable.text = "旧密码输入正确，请滑动设置新密码"
                        //改变tag值
                        updateTag=1
                        //先清空文件密码
                        NSUserDefaults.standardUserDefaults().setObject(nil, forKey: "wh")
                    }
                    else
                    {
                        resultLable.text = "新密码设置成功!"
                        //自动返回
                        autoBack()
                    }
                }
            }
        }
    }
    func autoBack() //自动返回
    {
        NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "forgotSecret", userInfo: nil, repeats: false)
    }
}
