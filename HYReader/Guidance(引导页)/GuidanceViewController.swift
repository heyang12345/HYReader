//
//  ViewController.swift
//  美团
//
//  Created by 千锋 on 16/9/9.
//  Copyright © 2016年 heyang. All rights reserved.
//

import UIKit
import SnapKit
import JKCategories

class GuidanceViewController: UIViewController {
    
    let ScrollView = UIScrollView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        ScrollView.frame = UIScreen.mainScreen().bounds
        
        //创建跳转按钮
        let button = UIButton(type:.Custom)
        
        button.setTitle("进入", forState: .Normal)
        button.setTitleColor(UIColor ( red: 0.6893, green: 0.4684, blue: 0.1063, alpha: 1.0 ), forState: .Normal)
        button.jk_handleControlEvents(UIControlEvents.TouchUpInside) { (sender) in
            let tvc = MainTabBarController()
            self.presentViewController(tvc, animated: true, completion: nil)
        }
    
        for i in 0...2{
            let imageName = "引导页\(i+1)"
            let image = UIImage(named: imageName)
            let imageView = UIImageView()
            imageView.frame = CGRectMake(CGFloat(414*i), 0,self.view.bounds.size.width, self.view.bounds.height)
            
            imageView.image = image
            imageView.userInteractionEnabled = true
            imageView.addSubview(button)
            button.snp_makeConstraints { (make) in
                make.right.equalTo(-30)
                make.top.equalTo(80)
                make.height.equalTo(30)
                make.width.equalTo(50)
            }
            ScrollView.addSubview(imageView)
           
            
            
        }
        ScrollView.contentSize = CGSizeMake(CGFloat(3*self.view.bounds.size.width), 0)
        ScrollView.showsVerticalScrollIndicator = false
        ScrollView.showsHorizontalScrollIndicator = false
        ScrollView.pagingEnabled = true
        self.view.addSubview(ScrollView)
        
        
        
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
