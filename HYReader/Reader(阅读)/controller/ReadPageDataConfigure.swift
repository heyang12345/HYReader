//
//  ReadPageDataConfigure.swift
//  Reader
//
//  Created by 千锋 on 16/11/1.
//  Copyright © 2016年 heyang. All rights reserved.
//

import UIKit

class ReadPageDataConfigure: NSObject {
    
    /// 阅读控制器
    private weak var readPageController:ReadPageController!
    
    /// 临时记录值
    var changeReadChapterModel:ReadChapterModel!
    var changeReadChapterListModel:ReadChapterListModel!
    var changeLookPage:Int = 0
    var changeChapterID:Int = 0
    
    /// 阅读控制器配置
    class func setupWithReadController(readPageController:ReadPageController) ->ReadPageDataConfigure {
        
        let readPageDataConfigure = ReadPageDataConfigure()
        
        readPageDataConfigure.readPageController = readPageController
        
        return readPageDataConfigure
    }
    
    
    
    // MARK: -- 阅读控制器
    
    /**
     获取阅读控制器
     
     - parameter readChapterModel: 当前阅读的章节模型
     - parameter page:             当前章节阅读到page
     */
    func GetReadViewController(readChapterModel:ReadChapterModel,currentPage:Int) ->ReadViewController {
        
        let readVC = ReadViewController()
        
        readVC.readPageController = readPageController
        
        // 正对当前控制器的阅读记录
        let readRecord = ReadRecord()
        readRecord.readChapterListModel = changeReadChapterListModel
        readRecord.page = currentPage
        readRecord.chapterIndex = readPageController.readModel.readRecord.chapterIndex
        readVC.readChapterModel = readChapterModel
        readVC.readRecord = readRecord
        
        readVC.content = readChapterModel.stringOfPage(currentPage)
        
        return readVC
    }
    
    // MARK: -- 阅读指定章节
    
    /**
     跳转指定章节
     
     - parameter chapterID:            章节ID
     - parameter isInit:               是否为初始化true 还是跳转章节false
     - parameter chapterLookPageClear: 阅读到的章节页码是否清0
     - parameter transitionStyle:      PageController 样式
     - parameter result:               跳转结果
     */
    func GoToReadChapter(chapterID:String,chapterLookPageClear:Bool,result:((isOK:Bool)->Void)?) {
        
        if !readPageController.readModel.readChapterListModels.isEmpty {
            
            let readChapterModel = GetReadChapterModel(chapterID)
            
            if readChapterModel != nil { // 有这个章节
                
                GoToReadChapter(readChapterModel!, chapterLookPageClear: chapterLookPageClear, result: result)
                
            }else{ // 没有章节
                
                if readPageController.readModel.isLocalBook.boolValue { // 本地小说
                    
                    if result != nil {result!(isOK: false)}
                    
                }else{ // 网络小说
                    
                }
            }
        }
    }
    
    /**
     跳转指定章节
     
     - parameter readChapterModel:     章节模型
     - parameter isInit:               是否为初始化true 还是跳转章节false
     - parameter chapterLookPageClear: 阅读到的章节页码是否清0
     - parameter transitionStyle:      PageController 样式
     - parameter result:               跳转结果
     */
    private func GoToReadChapter(readChapterModel:ReadChapterModel, chapterLookPageClear:Bool,result:((isOK:Bool)->Void)?) {
        
        changeLookPage = readPageController.readModel.readRecord.page.integerValue
        
        if chapterLookPageClear {
            
            readPageController.readModel.readRecord.page = 0
            
            changeLookPage = 0
        }
        
        readPageController.creatPageController(GetReadViewController(readChapterModel, currentPage: readPageController.readModel.readRecord.page.integerValue))
        
        // 同步本地进度
        synchronizationChangeData()
        
        if result != nil {result!(isOK: true)}
    }
    
    // MARK: -- 通过章节ID 获取 数组索引
    
    func GetReadChapterListModel(chapterID:String) ->ReadChapterListModel? {
        
        let pre = NSPredicate(format: "chapterID == %@",chapterID)
        
        let results = (readPageController.readModel.readChapterListModels as NSArray).filteredArrayUsingPredicate(pre)
        
        return results.first as? ReadChapterListModel
    }
    
    
    // 通过章节ID获取章节模型 需要滚动到的 获取到阅读章节
    func GetReadChapterModel(chapterID:String) ->ReadChapterModel? {
        
        let pre = NSPredicate(format: "chapterID == %@",chapterID)
        
        let results = (readPageController.readModel.readChapterListModels as NSArray).filteredArrayUsingPredicate(pre)
        
        if !results.isEmpty { // 获取当前数组位置
            
            let readChapterListModel = results.first as! ReadChapterListModel
            
            // 获取阅读章节文件
            let readChapterModel = ReadKeyedUnarchiver(readPageController.readModel.bookID, fileName: readChapterListModel.chapterID) as? ReadChapterModel
            
            if readChapterModel != nil {
                
                changeReadChapterListModel = readChapterListModel
                
                changeReadChapterModel = readChapterModel
                
                // 刷新字体
                readPageController.readConfigure.updateReadRecordFont()
                
                readPageController.title = readChapterListModel.chapterName
                
                // 章节list 进行滚动
                let index = readPageController.readModel.readChapterListModels.indexOf(readChapterListModel)
                
                readPageController.readModel.readRecord.chapterIndex = index!
                
                readPageController.readSetup.readUI.leftView.scrollRow = index!
                
                readPageController.readSetup.readUI.bottomView.slider.value = Float(index!)
                
                return readChapterModel
            }
        }
        
        return nil
    }
    
    // MARK: -- 上一页
    
    func GetReadPreviousPage() ->ReadViewController? {
        
        changeChapterID = readPageController.readModel.readRecord.readChapterListModel.chapterID.integerValue()
        
        changeLookPage = readPageController.readModel.readRecord.page.integerValue
        
        changeReadChapterListModel = readPageController.readModel.readRecord.readChapterListModel
        
        if readPageController.readModel.isLocalBook.boolValue { // 本地小说
            
            if changeChapterID == 1 && changeLookPage == 0 {
                
                return nil
            }
            
            if changeLookPage == 0 { // 这一章到头部了
                
                changeChapterID -= 1
                
                let readChapterModel = GetReadChapterModel("\(changeChapterID)")
                
                if readChapterModel != nil { // 有上一张
                    
                    changeLookPage = changeReadChapterModel!.pageCount.integerValue - 1
                    
                }else{ // 没有上一章
                    
                    return nil
                }
                
                
            }else{
                
                changeLookPage -= 1
            }
            
        }else{ // 网络小说阅读
            
            
        }
        
        return GetReadViewController(changeReadChapterModel, currentPage: changeLookPage)
    }
    
    // MARK: -- 下一页
    
    func GetReadNextPage() ->ReadViewController? {
        
        changeChapterID = readPageController.readModel.readRecord.readChapterListModel.chapterID.integerValue()
        
        changeLookPage = readPageController.readModel.readRecord.page.integerValue
        
        changeReadChapterListModel = readPageController.readModel.readRecord.readChapterListModel
        
        if readPageController.readModel.isLocalBook.boolValue { // 本地小说
            
            if changeChapterID == readPageController.readModel.readChapterListModels.count && changeLookPage == (changeReadChapterModel.pageCount.integerValue - 1) {
                
                return nil
            }
            
            if changeLookPage == (changeReadChapterModel.pageCount.integerValue - 1) { // 这一章到尾部了
                
                changeChapterID += 1
                
                let chapterModel = GetReadChapterModel("\(changeChapterID)")
                
                if chapterModel != nil { // 有下一章
                    
                    changeLookPage = 0
                    
                }else{ // 没有下一章
                    
                    return nil
                }
                
            }else{
                
                changeLookPage += 1
            }
            
        }else{ // 网络小说阅读
            
            
        }
        
        return GetReadViewController(changeReadChapterModel, currentPage: changeLookPage)
    }
    
    // MARK: -- 刷新字体
    
    func updateReadRecordFont() {
        
        // 刷新字体
        changeReadChapterModel.updateFont()
        
        // 重新展示
        
        let oldPage:Int = readPageController.readModel.readRecord.page.integerValue
        
        let newPage = changeReadChapterModel.pageCount.integerValue
        
        readPageController.readModel.readRecord.page = (oldPage > (newPage - 1) ? (newPage - 1) : oldPage)
        
    }
    
    // MARK: -- 阅读记录
    
    /// 同步临时数据
    func synchronizationChangeData() {
        
        readPageController.readModel.readRecord.readChapterModel = changeReadChapterModel
        
        readPageController.readModel.readRecord.readChapterListModel = changeReadChapterListModel
        
        readPageController.readModel.readRecord.page = changeLookPage
    }
    
    /// 刷新保存阅读记录
    
    /**
     保存记录 默认是更具条件是否属于书架进行保存b
     */
    func updateReadRecord() {
        
        // 同步阅读记录
        ReadModel.updateReadModel(readPageController.readModel)
    }
}
