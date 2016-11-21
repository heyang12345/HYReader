//
//  ViewController.swift
//  Reader
//
//  Created by 千锋 on 16/10/31.
//  Copyright © 2016年 heyang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //返回手势
    var openInterativePopGestureRecognizer:Bool = true{
        didSet{
            navigationController?.interactivePopGestureRecognizer?.enabled = openInterativePopGestureRecognizer
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.backgroundColor = UIColor.whiteColor()
        //控件想要从状态栏00开始
        automaticallyAdjustsScrollViewInsets = false
        //添加子控件
        addSubviews()
        //初始化导航栏
        initNavigationBarSubviews()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //添加子控件
    func  addSubviews(){
        //返回手势
        navigationController?.interactivePopGestureRecognizer?.delegate = self as? UIGestureRecognizerDelegate
    }
    //初始化导航栏
    func initNavigationBarSubviews(){
    
    }
    //点击返回方法
    func clickBack(){
        navigationController?.popViewControllerAnimated(true)
    }
    override func viewWillAppear(animated: Bool) {
        //记录当前显示的控制器
        Manager.shareManager.displayController = self
        //删除系统自动生成的UITabarButton
        deleteItem()
    }
    //删除可能会出现的Item
    func deleteItem(){
        if self.tabBarController != nil {
            for child:UIView in (self.tabBarController?.tabBar.subviews)!{
                if child.isKindOfClass(UIControl){
                    child.removeFromSuperview()
                }
            }
        }
    }


}

