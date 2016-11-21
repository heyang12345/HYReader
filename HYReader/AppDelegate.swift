//
//  AppDelegate.swift
//  HYReader
//
//  Created by 千锋 on 16/10/26.
//  Copyright © 2016年 heyang. All rights reserved.
//

import UIKit
import MMDrawerController
import FDFullscreenPopGesture
import OpenShare
@objc protocol HYAppDelegate:NSObjectProtocol{
    //程序即将退出
    optional func applicationWillTermainte(application:UIApplication)
    //内存警告可能要终止程序
    optional func applicationDidReceiveMemoryWarning(application:UIApplication)
}
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var delegate:HYAppDelegate?
    
    var window: UIWindow?

    var mmDrawerVC: MMDrawerController?
    var bgView  = UIView.init()
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        //允许获取电量
        UIDevice.currentDevice().batteryMonitoringEnabled = true
        //显示状态栏
        application.setStatusBarHidden(false, withAnimation: UIStatusBarAnimation.Fade)
        //封装一个window跟控制器
        configureRootVC()
        //封装3DTouch
        setupShortCutItem()
        // 配置极光推送
        setupJPush(launchOptions)
        //上报appId给微信
        OpenShare.connectWeixinWithAppId("wxb0bc3dc898cc0298")
        
//        
//        let window = UIApplication.sharedApplication().keyWindow
//       
//        bgView.backgroundColor = UIColor.blackColor()
//        bgView.frame = UIScreen.mainScreen().bounds
//        bgView.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.5)
//        bgView.userInteractionEnabled = false
//        window?.addSubview(bgView)
//        
        self.window?.hidden = true
        return true
    }
    // 配置极光推送
    func setupJPush(launchOptions: [NSObject: AnyObject]?) {
        // 上传 appKey
        JPUSHService.setupWithOption(launchOptions, appKey: JPushAppKey, channel: "iOS", apsForProduction: false)
        // 申请远程推送权限
        JPUSHService.registerForRemoteNotificationTypes(UIUserNotificationType.Alert.rawValue | UIUserNotificationType.Sound.rawValue | UIUserNotificationType.Badge.rawValue, categories: nil)
    }
    func setAlias(alias: String) {
        JPUSHService.setTags(nil, alias: alias) { (retCode, tags, alias) in
            print("\(retCode), \(tags), \(alias)")
        }
        
    }
    // 上传手机的 device Token
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        JPUSHService.registerDeviceToken(deviceToken)
      
    }
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject], fetchCompletionHandler completionHandler: (UIBackgroundFetchResult) -> Void) {
        // 上报 Jpush 我们收到推送了
        JPUSHService.handleRemoteNotification(userInfo)
        
        // 取出推送的消息，可以有附加字段。
        let vcClass = NSClassFromString((userInfo as! [String: AnyObject])["class"] as! String)
        let pushVC = (vcClass as! ViewController.Type).init()
        
        dispatch_async(dispatch_get_main_queue()) {
            // 跳转到相应的控制器
            ((self.window?.rootViewController as! MainTabBarController).selectedViewController as! UINavigationController).pushViewController(pushVC, animated: true)
        }
        
        // 上报系统，已经完成处理
        completionHandler(UIBackgroundFetchResult.NewData)
    }


    
    //封装一个window跟控制器
    func configureRootVC(){
        
        
        
        //设置侧滑视图
        let leftVC = MenuViewController()
        let centerVC = BookrackViewController()
        let rightVC = MainTabBarController()
        let centerNav = UINavigationController(rootViewController: centerVC)
        
        mmDrawerVC = MMDrawerController.init(centerViewController: centerNav, leftDrawerViewController: leftVC, rightDrawerViewController: rightVC)
        
        //打开关闭抽屉手势
        
        mmDrawerVC!.openDrawerGestureModeMask = MMOpenDrawerGestureMode.All
        mmDrawerVC!.closeDrawerGestureModeMask = MMCloseDrawerGestureMode.All
        //抽屉打开尺度
        mmDrawerVC!.maximumLeftDrawerWidth = UIScreen.mainScreen().bounds.width-80
        mmDrawerVC!.maximumRightDrawerWidth = UIScreen.mainScreen().bounds.width
        let mmDrawerNVC = UINavigationController(rootViewController: mmDrawerVC!)
        mmDrawerVC?.fd_prefersNavigationBarHidden = true

        window = UIWindow.init(frame: UIScreen.mainScreen().bounds)
        window?.rootViewController = mmDrawerNVC
        window?.makeKeyAndVisible() 
    }
   
    //封装3DTouch
    func setupShortCutItem() {
        //		UIApplication.sharedApplication().shortcutItems
        
        let scanIcon = UIApplicationShortcutIcon.init(type: UIApplicationShortcutIconType.CapturePhoto)
        // type: 类型，可以用这个参数去区分某个快捷键
        // title: 大标题
        // subtitle: 副标题
        // userInfo: 附加信息
        let scanItem = UIApplicationShortcutItem.init(type: "scan", localizedTitle: "扫一扫", localizedSubtitle: "添加好友", icon: scanIcon, userInfo: nil)
        
        let shareIcon = UIApplicationShortcutIcon.init(type: UIApplicationShortcutIconType.Share)
        let shareItem = UIApplicationShortcutItem.init(type: "share", localizedTitle: "分享", localizedSubtitle: nil, icon: shareIcon, userInfo: nil)
        
        UIApplication.sharedApplication().shortcutItems = [scanItem, shareItem]
        
        // 也可以使用静态方式创建快捷键
        // 在 plist 文件中添加 UIApplicationShortcutItems 字段，即可添加默认的快捷键
        // 这样当用户刚下载我们的 app，即使没有打开，也有快捷键。
    }
    // 从 3D Touch 快捷键点入
    func application(application: UIApplication, performActionForShortcutItem shortcutItem: UIApplicationShortcutItem, completionHandler: (Bool) -> Void) {
        // 先判断，从哪个按钮点的
        if shortcutItem.type == "scan" {
            // 跳转到扫一扫控制器
  
            (mmDrawerVC?.centerViewController as! UINavigationController).pushViewController(ScanViewController(), animated: true)
            
         }else if shortcutItem.type == "share"{
            let message = OSMessage.init()
            message.title = "书山有路勤为径"
            message.desc = "学海无涯苦作舟"
            OpenShare.shareToWeixinSession(message, success: { (msmessage) in
                print(msmessage)
                }, fail: { (msmessage, error) in
                    if error != nil {
                        print(error)
                    }else{
                        print(msmessage)
                    }
            })

            
        }
        
    }
    

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    //应用已经进入前台
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        application.applicationIconBadgeNumber = 0
    }
    //程序即将退出
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        delegate?.applicationWillTermainte!(application)
    }
    //内存警告可能要终止程序
    func applicationDidReceiveMemoryWarning(application: UIApplication) {
        delegate?.applicationDidReceiveMemoryWarning!(application)
        
    }
    //iOS处理应用传值的方法(如果用户从别的 app 跳转回来，可以在这个方法中处理)
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        
        return OpenShare.handleOpenURL(url)
    }



}

