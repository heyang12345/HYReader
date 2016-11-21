//
//  ReadPageController.swift
//  Reader
//
//  Created by 千锋 on 16/11/1.
//  Copyright © 2016年 heyang. All rights reserved.
//

import UIKit
//import FDFullscreenPopGesture
class ReadPageController: ViewController,UIPageViewControllerDelegate,UIPageViewControllerDataSource,HYAppDelegate,DZMCoverControllerDelegate {
    
    // 阅读主对象
    var readModel:ReadModel!
    
    /// 翻页控制器
    var pageViewController:UIPageViewController!
    var coverController:DZMCoverController!
    
    /// 阅读设置
    var readSetup:ReadSetup!
    var readConfigure:ReadPageDataConfigure!
    //隐藏状态栏
    override func prefersStatusBarHidden() -> Bool {
        if readSetup != nil{
            if readSetup.isRFHidden == false{
                return false
            }
        }
        
        return true
    }
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.fd_prefersNavigationBarHidden = true
        // 初始化
        readConfigure = ReadPageDataConfigure.setupWithReadController(self)
        readSetup = ReadSetup.setupWithReadController(self)
        
        // 刷新章节列表
        readSetup.readUI.leftView.dataArray = readModel.readChapterListModels
        readSetup.readUI.bottomView.slider.maximumValue = Float(readModel.readChapterListModels.count - 1)
        
        // 初始化翻页效果
        readSetup.setFlipEffect(ReadConfigureManger.shareManager.flipEffect,chapterLookPageClear: false)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // 设置回调代理
        (UIApplication.sharedApplication().delegate as! AppDelegate).delegate = self
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        
        
    }
  
    
    // MARK: -- PageController
    // MARK: -- PageController
    
    func creatPageController(displayController:UIViewController) {
        
        if pageViewController != nil {
            
            pageViewController.view.removeFromSuperview()
            
            pageViewController.removeFromParentViewController()
        }
        
        if coverController != nil {
            
            coverController.view.removeFromSuperview()
            
            coverController.removeFromParentViewController()
        }
        
        if ReadConfigureManger.shareManager.flipEffect == ReadFlipEffect.Simulation {
            
            let options = [UIPageViewControllerOptionSpineLocationKey:NSNumber(long: UIPageViewControllerSpineLocation.Min.rawValue)]
            
            pageViewController = UIPageViewController(transitionStyle:UIPageViewControllerTransitionStyle.PageCurl,navigationOrientation:UIPageViewControllerNavigationOrientation.Horizontal,options: options)
            
            pageViewController.view.backgroundColor = UIColor.blackColor()
            
            pageViewController.delegate = self
            
            pageViewController.dataSource = self
            
            view.insertSubview(pageViewController.view, atIndex: 0)
            
            addChildViewController(pageViewController)
            
            pageViewController.setViewControllers([displayController], direction: UIPageViewControllerNavigationDirection.Forward, animated: true, completion: nil)
            
        }else{
            
            coverController = DZMCoverController()
            
            coverController.delegate = self
            
            view.insertSubview(coverController.view, atIndex: 0)
            
            addChildViewController(coverController)
            
            coverController.setController(displayController)
            
            if ReadConfigureManger.shareManager.flipEffect == ReadFlipEffect.None {
                
                coverController.openAnimate = false
                
            }else if (ReadConfigureManger.shareManager.flipEffect == ReadFlipEffect.UpAndDown){
                
                coverController.openAnimate = false
                
                coverController.gestureRecognizerEnabled = false
            }
            
        }
    }
    
    // MARK: -- DZMCoverControllerDelegate
    
    func coverController(coverController: DZMCoverController, currentController: UIViewController?, finish isFinish: Bool) {
        
        if !isFinish {
            
            // 重置阅读记录
            
            if currentController != nil {
                
                let vc  = currentController as! ReadViewController
                
                synchronizationPageViewControllerData(vc)
            }
            
        }else{
            
            // 刷新阅读记录
            readConfigure.synchronizationChangeData()
        }
    }
    
    func coverController(coverController: DZMCoverController, getAboveControllerWithCurrentController currentController: UIViewController?) -> UIViewController? {
        
        return readConfigure.GetReadPreviousPage()
    }
    
    func coverController(coverController: DZMCoverController, getBelowControllerWithCurrentController currentController: UIViewController?) -> UIViewController? {
        
        return readConfigure.GetReadNextPage()
    }
    
    // MARK: -- UIPageViewControllerDelegate
    
    func pageViewController(pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        if !completed {
            
            // 重置阅读记录
            let vc  = previousViewControllers.first as! ReadViewController
            
            synchronizationPageViewControllerData(vc)
            
        }else{
            
            // 刷新阅读记录
            readConfigure.synchronizationChangeData()
        }
    }
    
    func pageViewController(pageViewController: UIPageViewController, willTransitionToViewControllers pendingViewControllers: [UIViewController]) {
        
    }
    
    
    // MARK: -- UIPageViewControllerDataSource
    
    /// 获取上一页
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        return readConfigure.GetReadPreviousPage()
    }
    
    /// 获取下一页
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        return readConfigure.GetReadNextPage()
    }
    
    /// 同步PageViewController 当前显示的控制器的内容
    func synchronizationPageViewControllerData(viewController: UIViewController){
        
        let vc  = viewController as! ReadViewController
        readConfigure.changeReadChapterListModel = vc.readRecord.readChapterListModel
        readConfigure.changeReadChapterModel = vc.readChapterModel
        readConfigure.changeLookPage = vc.readRecord.page.integerValue
        readModel.readRecord.chapterIndex = vc.readRecord.chapterIndex
        title = vc.readChapterModel.chapterName
        
        // 刷新阅读记录
        readConfigure.synchronizationChangeData()
    }
    
    // MARK: -- 返回以及同步数据
    
    override func initNavigationBarSubviews() {
        super.initNavigationBarSubviews()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem.AppNavigationBarBackItemOne(UIEdgeInsetsMake(0, 0, 0, 0), target: self, action: #selector(NavigationController.clickBack))
    }
    
    
    // MARK: -- HJAppDelegate 保存阅读记录
    
    /// app 即将退出
    func applicationWillTerminate(application: UIApplication) {
        
        readConfigure.updateReadRecord()
    }
    
    /// app 内存警告可能要终止程序
    func applicationDidReceiveMemoryWarning(application: UIApplication) {
        
        readConfigure.updateReadRecord()
    }
    
    override func clickBack() {
        super.clickBack()
        
        // 保存记录
        readConfigure.updateReadRecord()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // 内存警告保存记录
        readConfigure.updateReadRecord()
    }
}
