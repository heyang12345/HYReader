
//
//  FuncTwo.swift
//  Reader
//
//  Created by 千锋 on 16/11/1.
//  Copyright © 2016年 heyang. All rights reserved.
//

import Foundation
import UIKit
// MARK: -- 自动获取屏幕高度 -----------------------

/// 自动获取view的高度 自动判断 是否有 导航栏跟TabBar
func ViewHeight(controller:UIViewController) ->CGFloat {
    
    var navigationHidden = true
    
    var tabBarHidden = true
    
    if controller.navigationController != nil { // 有导航栏
        
        navigationHidden = controller.navigationController!.navigationBarHidden
    }
    
    if controller.tabBarController != nil { // 有tabBar
        
        tabBarHidden = controller.tabBarController!.tabBar.hidden
    }
    
    return ViewHeight(navigationHidden, tabBarHidden: tabBarHidden)
}

/// 自动判断 是否有 导航栏 手动设置 是否有 TabBar
func ViewHeight(controller:UIViewController,tabBarHidden:Bool) ->CGFloat {
    
    var navigationHidden = true
    
    if controller.navigationController != nil { // 有导航栏
        
        navigationHidden = controller.navigationController!.navigationBarHidden
    }
    
    return ViewHeight(navigationHidden, tabBarHidden: tabBarHidden)
}

/// 自定义计算View高 手动设置 是否有 导航栏跟TabBar
func ViewHeight(navigationHidden:Bool,tabBarHidden:Bool) -> CGFloat {
    
    var h = ScreenHeight
    
    if !navigationHidden { // 有导航栏
        
        h -= NavgationBarHeight
    }
    
    if !tabBarHidden { // 有tabBar
        
        h -= TabBarHeight
    }
    
    return h
}
// MARK: -- 时间 -----------------------

// MARK: - "yyyy-MM-dd HH:mm:ss" 格式 字符串转成NSDate

func DateWithString(str:String) ->NSDate {
    
    let format = NSDateFormatter()
    
    format.dateFormat = "yyyy-MM-dd HH:mm:ss"
    
    let timeDate = format.dateFromString(str)
    
    return timeDate!
}

// MARK: - 获取 "yyyy-MM-dd HH:mm:ss" 格式 的时间字符串

func DateString() ->String {
    
    let format = NSDateFormatter()
    
    format.dateFormat = "yyyy-MM-dd HH:mm:ss"
    
    let timeDate = NSDate()
    
    return format.stringFromDate(timeDate)
}

/**
 创建文件夹 如果存在则不创建
 
 - parameter filePath: 文件路径
 
 return 是否有文件夹存在
 */
func CreatFilePath(filePath:String) ->Bool {
    
    let fileManager = NSFileManager.defaultManager()
    
    // 文件夹是否存在
    if fileManager.fileExistsAtPath(filePath) {
        
        return true
    }
    
    do{
        try fileManager.createDirectoryAtPath(filePath, withIntermediateDirectories: true, attributes: nil)
        
        return true
        
    }catch{}
    
    return false
}

// MARK: -- view的手势禁用开启

/// 当前view的 Tap Enabled
func ViewTapGestureRecognizerEnabled(view:UIView,enabled:Bool) {
    
    if (view.gestureRecognizers != nil) {
        
        for ges in view.gestureRecognizers! {
            
            if ges.isKindOfClass(UITapGestureRecognizer.classForCoder()) {
                
                ges.enabled = enabled
            }
        }
    }
}

/// 当前view的 Pan Enabled
func ViewPanGestureRecognizerEnabled(view:UIView,enabled:Bool) {
    
    if (view.gestureRecognizers != nil) {
        
        for ges in view.gestureRecognizers! {
            
            if ges.isKindOfClass(UIPanGestureRecognizer.classForCoder()) {
                
                ges.enabled = enabled
            }
        }
    }
}

// MARK: -- 阅读页面获取文件方法 ----------------

/// 归档阅读文件文件
func ReadKeyedArchiver(folderName:String,fileName:String,object:AnyObject) {
    
    var path = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true).last?.stringByAppendingString("/DZMeBookRead/DZM\(folderName)")
    
    if (CreatFilePath(path!)) { // 创建文件夹成功或者文件夹存在
        
        path = path!.stringByAppendingString("/\(fileName)")
        
        NSKeyedArchiver.archiveRootObject(object, toFile: path!)
    }
}

/// 解档阅读文件文件
func ReadKeyedUnarchiver(folderName:String,fileName:String) ->AnyObject? {
    
    let path = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true).last?.stringByAppendingString("/DZMeBookRead/DZM\(folderName)").stringByAppendingString("/\(fileName)")
    
    return NSKeyedUnarchiver.unarchiveObjectWithFile(path!)
}

/// 删除阅读归档文件
func ReadKeyedRemoveArchiver(folderName:String,fileName:String) {
    
    let path = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true).last?.stringByAppendingString("/DZMeBookRead/DZM\(folderName)").stringByAppendingString("/\(fileName)")
    
    do{
        try NSFileManager.defaultManager().removeItemAtPath(path!)
    }catch{}
}

/// 是否存在了改归档文件
func ReadKeyedIsExistArchiver(folderName:String,fileName:String) ->Bool {
    
    let path = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true).last?.stringByAppendingString("/DZMeBookRead/DZM\(folderName)").stringByAppendingString("/\(fileName)")
    
    return NSFileManager.defaultManager().fileExistsAtPath(path!)
}
