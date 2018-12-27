//
//  ViewController.swift
//  解锁项目（Swift）
//
//  Created by ding on 18/12/20.
//  Copyright (c) 2018年 ding. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //在swift中，新建ViewController实例，默认 没有关联xib，一定要开发者指定xib的名字
    let _drawVC = DrawViewController(nibName: "DrawViewController", bundle: nil) //声明一个全局属性
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    //按钮响应的方法
    @IBAction func btnClicked(sender: UIButton) {
        //发送通知,清空按钮
        NSNotificationCenter.defaultCenter().postNotificationName("whClean", object: nil)
        switch sender.tag{
        case 100: //设置密码
            _drawVC.whTag = 100
            break;
        case 101: //验证密码
            _drawVC.whTag = 101
            break;
        case 102: //修改密码
            _drawVC.whTag = 102
            break;
        default:
            break;
        }
        self.presentViewController(_drawVC, animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

