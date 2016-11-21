//
//  BookCityViewController.swift
//  HYReader
//
//  Created by 千锋 on 16/10/26.
//  Copyright © 2016年 heyang. All rights reserved.
//

import UIKit
import MBProgressHUD
import SafariServices
class StackViewController: UIViewController {
    
    var webView = UIWebView.init()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.backgroundColor = UIColor.whiteColor()

        //http://b.easou.comhttp:
        //http://book.2345.com
        let urlPath = "http://book.2345.com"
        
        webView.frame = self.view.bounds
        
        webView.scrollView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0)
        
        self.view.addSubview(webView)
        // 加载网页
        
        webView.loadRequest(NSURLRequest.init(URL: NSURL.init(string: urlPath)!))
        
        let backItem = UIBarButtonItem.init(image: UIImage.init(named: "后退"), style: UIBarButtonItemStyle.Plain, target: self, action: #selector(self.backPreUrl))
        
        let nextItem = UIBarButtonItem.init(image: UIImage.init(named: "前进"), style: UIBarButtonItemStyle.Plain, target: self, action: #selector(self.goNextUrl))
        
        let closeItem = UIBarButtonItem.init(title: "关闭", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(self.close))
        
        self.navigationItem.leftBarButtonItems = [backItem, nextItem, closeItem]
        
        let refreshItem = UIBarButtonItem.init(image: UIImage.init(named: "刷新"), style: UIBarButtonItemStyle.Plain, target: self, action: #selector(self.refresh))
        self.navigationItem.rightBarButtonItem = refreshItem
        
        
    }
    // 返回上一个网页
    func backPreUrl() {
        if webView.canGoBack == true {
            
            webView.goBack()
        }
        
    }
    // 去下一个网页
    func goNextUrl() {
        if webView.canGoForward {
            webView.goForward()
        }
        
    }
    // 刷新
    func refresh() {
        webView.reload()
        
    }
    // 返回上个控制器
    func close() {
        if mm_drawerController.openSide == .Right{
            
            self.mm_drawerController.closeDrawerAnimated(true) { (finished) in
                
                if finished {
                    print("关闭成功")
                }else{
                    print("关闭失败")
                }
            }
        }

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
