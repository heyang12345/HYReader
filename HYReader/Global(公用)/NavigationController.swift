//
//  NavigationController.swift
//  Reader
//
//  Created by 千锋 on 16/11/1.
//  Copyright © 2016年 heyang. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {

    override class func initialize(){
        
        // 重载导航条属性
            NavigationController.setupNavBarTheme()
        
    }
        
    
    /// 设置导航栏
    class func setupNavBarTheme(){
        
        // 取出appearance对象
        let navBar:UINavigationBar = UINavigationBar.appearance()
        
                
        // 设置标题属性
        let textAttrs:NSDictionary = [NSForegroundColorAttributeName:Color_4,NSFontAttributeName:UIFont.systemFontOfSize(18)]
        
        navBar.titleTextAttributes = textAttrs as? [String : AnyObject]
       
    }
   
    
    
    /// 设置Item属性
    class func setupBarButtonItemTheme() {
        
        let item = UIBarButtonItem.appearance()
        
        // 设置文字属性
        let textAttrs = [NSForegroundColorAttributeName:UIColor.blackColor(),NSFontAttributeName:UIFont.systemFontOfSize(18)]
        
        item.setTitleTextAttributes(textAttrs, forState: UIControlState.Normal)
    }
    
    // MARK: -- 拦截Push
    override func pushViewController(viewController: UIViewController, animated: Bool) {
        
        if viewControllers.count > 0 {
            
            viewController.hidesBottomBarWhenPushed = true
            
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem.AppNavigationBarBackItemOne(UIEdgeInsetsMake(0, 0, 0, 0), target: self, action: #selector(NavigationController.clickBack))
        }
        
        super.pushViewController(viewController, animated: animated)
    }
    
    /// 点击返回方法
    func clickBack() {
        popViewControllerAnimated(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
