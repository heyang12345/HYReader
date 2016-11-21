//
//  ReadSetup.swift
//  Reader
//
//  Created by 千锋 on 16/11/1.
//  Copyright © 2016年 heyang. All rights reserved.
//


/*
 
 主要存放阅读页面操作逻辑 UI
 
 */

/// 点击手势区分
private let TempW:CGFloat = ScreenWidth / 3

import UIKit

class ReadSetup: NSObject,UIGestureRecognizerDelegate,ReadSettingColorViewDelegate,ReadSettingFlipEffectViewDelegate,ReadSettingFontViewDelegate,ReadSettingFontSizeViewDelegate,ReadLeftViewDelegate {
    
    /// 阅读控制器
    private weak var readPageController:ReadPageController!
    
    /// UI 设置
    var readUI:ReadUI!
    
    /// 单击手势
    private var singleTap:UITapGestureRecognizer!
    
    // 当前功能view 显示状态 默认隐藏
    var isRFHidden:Bool = true
    
//    //隐藏状态栏
//    func prefersStatusBarHidden() -> Bool {
//        
//        return false
//    }

    
    
    /// 阅读控制器设置
    class func setupWithReadController(readPageController:ReadPageController) ->ReadSetup {
        
        let readSetup = ReadSetup()
        
        readSetup.readPageController = readPageController
        
        readSetup.readUI = ReadUI.readUIWithReadController(readPageController)
        
        readSetup.setupSubviews()
        
        return readSetup
    }

    
    
    /// 初始化子控件相关
    func setupSubviews() {
        
        // 添加手势
        singleTap = UITapGestureRecognizer(target: self, action:#selector(ReadSetup.singleTap(_:)))
        singleTap.numberOfTapsRequired = 1
        singleTap.delegate = self
        readPageController.view.addGestureRecognizer(singleTap)
        
        // 设置代理
        readUI.settingView.colorView.aDelegate = self
        readUI.settingView.flipEffectView.delegate = self
        readUI.settingView.fontView.delegate = self
        readUI.settingView.fontSizeView.delegate = self
        readUI.leftView.delegate = self
    }
    
    /// 单击手势
    func singleTap(tap:UITapGestureRecognizer) {
        
        let point = tap.locationInView(readPageController.view)
        
        // 无效果
        if (ReadConfigureManger.shareManager.flipEffect == ReadFlipEffect.None || ReadConfigureManger.shareManager.flipEffect == ReadFlipEffect.Translation) && isRFHidden  {
            
            if point.x < TempW { // 左边
                
                let previousPageVC = readPageController.readConfigure.GetReadPreviousPage()
                
                if previousPageVC != nil { // 有上一页
                    
                    readPageController.coverController.setController(previousPageVC!, animated: Bool(ReadConfigureManger.shareManager.flipEffect.rawValue), isAbove: true)
                    
                    // 记录
                    readPageController.readConfigure.synchronizationChangeData()
                }
                
            }else if point.x > (TempW * 2) { // 右边
                
                let nextPageVC = readPageController.readConfigure.GetReadNextPage()
                
                if nextPageVC != nil { // 有下一页
                    
                    readPageController.coverController.setController(nextPageVC!, animated: Bool(ReadConfigureManger.shareManager.flipEffect.rawValue), isAbove: false)
                    
                    // 记录
                    readPageController.readConfigure.synchronizationChangeData()
                }
                
            }else{ // 中间
                
                RFHidden(!isRFHidden)
            }
            
        }else{
            
            RFHidden(!isRFHidden)
        }
        
        
    }
    
    // MARK: -- UIGestureRecognizerDelegate
    
    // 点击这些view 不需要执行手势
    let ClassString:[String] = ["UISlider","Project.ReadSettingView","Project.ReadSettingColorView","Project.ReadSettingFlipEffectView","Project.ReadSettingFontView","Project.ReadSettingFontSizeView"]
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
        
        let classString = NSStringFromClass(touch.view!.classForCoder)
        
        if classString == "Project.HJReadView" || classString == "UITableViewCellContentView" { // 触摸到了阅读view
            
            if !isRFHidden {
                
                RFHidden(!isRFHidden)
                
                return false
            }
        }
        
        if ClassString.contains(classString) {
            
            return false
        }
        
        return true
    }
    
    // MARK: -- 设置方法
    
    /// 隐藏显示功能view
    func RFHidden(isHidden:Bool) {
        
        if (isRFHidden == isHidden) {return}
        
        isRFHidden = isHidden
        
        readUI.topView(isHidden, animated: true)
        
        readUI.bottomView(isHidden, animated: true, completion: nil)
        
        if !readUI.lightView.hidden { // 亮度view 显示着
            
            readUI.lightView(true, animated: true, completion: nil)
        }
        
        if !readUI.settingView.hidden { // 设置view 显示着
            
            readUI.settingView(true, animated: true, completion: nil)
        }
        
        if !readUI.leftView.hidden { // 设置view 显示着
            
            readUI.leftView.clickCoverButton()
        }
    }
    
    
    
    // MARK: -- HJReadLeftViewDelegate
    
    func readLeftView(readLeftView: ReadLeftView, clickReadChapterModel model: ReadChapterListModel) {
        
        setFlipEffect(ReadConfigureManger.shareManager.flipEffect,chapterID: model.chapterID,chapterLookPageClear: true,contentOffsetYClear: true)
        
        RFHidden(!isRFHidden)
    }
    
    // MARK: -- HJReadSettingColorViewDelegate
    
    func readSettingColorView(readSettingColorView: ReadSettingColorView, changeReadColor readColor: UIColor) {
        
        NSNotificationCenter.defaultCenter().postNotificationName(ReadChangeBGColorKey, object: nil)
    }
    
    // MARK: -- HJReadSettingFlipEffectViewDelegate
    
    func readSettingFlipEffectView(readSettingFlipEffectView: ReadSettingFlipEffectView, changeFlipEffect flipEffect: ReadFlipEffect) {
        
        setFlipEffect(flipEffect,chapterLookPageClear: false)
    }
    
    /// 设置翻页效果
    func setFlipEffect(flipEffect: ReadFlipEffect,chapterLookPageClear:Bool) {
        
        setFlipEffect(flipEffect, chapterID: readPageController.readModel.readRecord.readChapterListModel.chapterID,chapterLookPageClear:chapterLookPageClear, contentOffsetYClear: false)
    }
    
    /// 设置翻页效果
    func setFlipEffect(flipEffect: ReadFlipEffect,chapterID:String,chapterLookPageClear:Bool,contentOffsetYClear:Bool) {
        
        if flipEffect != ReadFlipEffect.UpAndDown || contentOffsetYClear { // 上下滚动
            
            readPageController.readModel.readRecord.contentOffsetY = nil
        }
        
        // 跳转章节
        readPageController.readConfigure.GoToReadChapter(chapterID, chapterLookPageClear: chapterLookPageClear, result: nil)
        
    }
    
    // MARK: -- HJReadSettingFontViewDelegate
    
    func readSettingFontView(readSettingFontView: ReadSettingFontView, changeFont font: ReadFont) {
        
        updateFont()
    }
    
    // MARK: -- HJReadSettingFontSizeViewDelegate
    
    func readSettingFontSizeView(readSettingFontSizeView: ReadSettingFontSizeView, changeFontSize fontSize: Int) {
        
        updateFont()
    }
    
    /// 刷新字体 字号
    func updateFont() {
        
        // 刷新字体
        readPageController.readConfigure.updateReadRecordFont()
        
        // 重新展示
        let previousPageVC = readPageController.readConfigure.GetReadViewController(readPageController.readModel.readRecord.readChapterModel!, currentPage: readPageController.readModel.readRecord.page.integerValue)
        
        if (ReadConfigureManger.shareManager.flipEffect == ReadFlipEffect.Simulation) { // 仿真
            
            readPageController.pageViewController.setViewControllers([previousPageVC], direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
            
        }else{
            
            readPageController.coverController.setController(previousPageVC, animated: false, isAbove: true)
        }
    }
}
