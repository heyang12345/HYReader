//
//  ReadViewController.swift
//  Reader
//
//  Created by 千锋 on 16/11/1.
//  Copyright © 2016年 heyang. All rights reserved.
//

import UIKit

private let ReadCellID:String = "ReadCellID"

class ReadViewController: TableViewController {
    
    
    weak var readPageController:ReadPageController!
    
    /// 当前阅读形式
    private var flipEffect:ReadFlipEffect!
    
    /// 当前是否为这一章的最后一页
    var isLastPage:Bool = false
    
    /// 单独模式的时候显示的内容
    var content:String!
    
    /// 当前章节阅读记录
    var readRecord:ReadRecord!
    
    /// 当前使用的阅读模型
    var readChapterModel:ReadChapterModel!
    
    /// 底部状态栏
    private var readBottomStatusView:ReadBottomStatusView!
    private var readTopStatusView:ReadTopStatusView!
    
    /// 当前滚动经过的indexPath   UpAndDown 模式使用
    private var currentIndexPath:NSIndexPath!
    
    /// 当前是往上滚还是往下滚 default: 往上
    private var isScrollTop:Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.view.backgroundColor = UIColor ( red: 0.2599, green: 1.0, blue: 0.1538, alpha: 1.0 )
        // 设置背景颜色
        changeBGColor()
        
        // 设置翻页方式
        changeFlipEffect()
        
        // 设置头部名字
        readTopStatusView.setLeftTitle(readChapterModel.chapterName)
        
        // 设置页码
        readBottomStatusView.setNumberPage(readRecord.page.integerValue, tatolPage: readChapterModel.pageCount.integerValue)
        
        // 通知在deinit 中会释放
        // 添加背景颜色改变通知
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ReadViewController.changeBGColor), name: ReadChangeBGColorKey, object: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func initTableView(style: UITableViewStyle) {
        super.initTableView(.Plain)
        
        tableView.backgroundColor = UIColor.clearColor()
        
        tableView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight - ReadBottomStatusViewH)
    }
    
    override func addSubviews() {
        super.addSubviews()
        
        readTopStatusView = ReadTopStatusView()
        readTopStatusView.frame = CGRectMake(0, 0, ScreenWidth, ReadTopStatusViewH)
        view.addSubview(readTopStatusView)
        
        readBottomStatusView = ReadBottomStatusView()
        readBottomStatusView.frame = CGRectMake(0, ScreenHeight - ReadBottomStatusViewH, ScreenWidth, ReadBottomStatusViewH)
        view.addSubview(readBottomStatusView)
    }
    
    // MARK: -- UITableViewDataSource
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        if flipEffect == ReadFlipEffect.None { // 无效果
            
            return 1
            
        }else if flipEffect == ReadFlipEffect.Translation { // 平滑
            
            return 1
            
        }else if flipEffect == ReadFlipEffect.Simulation { // 仿真
            
            return 1
            
        }else if flipEffect == ReadFlipEffect.UpAndDown { // 上下滚动
            
            return 1
            
        }else{}
        
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if flipEffect == ReadFlipEffect.None { // 无效果
            
            return 1
            
        }else if flipEffect == ReadFlipEffect.Translation { // 平滑
            
            return 1
            
        }else if flipEffect == ReadFlipEffect.Simulation { // 仿真
            
            return 1
            
        }else if flipEffect == ReadFlipEffect.UpAndDown { // 上下滚动
            
        }else{}
        
        return readPageController.readModel.readChapterListModels.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = ReadViewCell.cellWithTableView(tableView)
        
        cell.isLastPage = isLastPage
        
        if flipEffect == ReadFlipEffect.None { // 无效果
            
            cell.content = content
            
        }else if flipEffect == ReadFlipEffect.Translation { // 平滑
            
            cell.content = content
            
        }else if flipEffect == ReadFlipEffect.Simulation { // 仿真
            
            cell.content = content
            
        }else if flipEffect == ReadFlipEffect.UpAndDown { // 上下滚动
            
            currentIndexPath = indexPath
            
            let readChapterListModel = readPageController.readModel.readChapterListModels[indexPath.row]
            
            let tempReadChapterModel = GetReadChapterModel(readChapterListModel)
            
            cell.readChapterModel = tempReadChapterModel
            
            cell.readChapterListModel = readChapterListModel
            
            cell.contentH = CGFloat(readChapterListModel.chapterHeight.floatValue)
            
            cell.content = tempReadChapterModel.chapterContent
            
            readPageController.title = readChapterListModel.chapterName
            
            // 设置页码
            readBottomStatusView.setNumberPage(indexPath.row, tatolPage: readPageController.readModel.readChapterListModels.count)
            
        }else{}
        
        
        return cell
    }
    
    // MARK: -- UITableViewDelegate
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        readPageController.readModel.readRecord.contentOffsetY = scrollView.contentOffset.y
        
        // 判断是滚上还是滚下
        let translation = scrollView.panGestureRecognizer.translationInView(view)
        
        if translation.y > 0 {
            
            isScrollTop = true
            
        }else if translation.y < 0 {
            
            isScrollTop = false
        }
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        GetCurrentPage()
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        GetCurrentPage()
    }
    
    /**
     获取页码
     */
    func GetCurrentPage() {
        
        if flipEffect == ReadFlipEffect.UpAndDown { // 滚动模式
            
            if isScrollTop {
                
                currentIndexPath = tableView.minVisibleIndexPath()
                
            }else{
                
                currentIndexPath = tableView.maxVisibleIndexPath()
            }
            
            if  currentIndexPath != nil {
                
                let cell = tableView.cellForRowAtIndexPath(currentIndexPath) as? ReadViewCell
                
                if cell != nil {
                    
                    let spaceH = tableView.contentOffset.y - cell!.y
                    
                    let redFrame = ReadParser.GetReadViewFrame()
                    
                    let page = spaceH / redFrame.height
                    
                    readPageController.readModel.readRecord.page = (page + 0.5)
                    
                    readTopStatusView.setLeftTitle("\(cell!.readChapterListModel!.chapterName)")
                    
                    readPageController.readModel.readRecord.readChapterListModel = cell!.readChapterListModel
                }
            }
        }
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if flipEffect == ReadFlipEffect.None { // 无效果
            
        }else if flipEffect == ReadFlipEffect.Translation { // 平滑
            
        }else if flipEffect == ReadFlipEffect.Simulation { // 仿真
            
        }else if flipEffect == ReadFlipEffect.UpAndDown { // 上下滚动
            
            let readChapterListModel = readPageController.readModel.readChapterListModels[indexPath.row]
            
            if CGFloat(readChapterListModel.chapterHeight.floatValue) < ScreenHeight {
                
                return ScreenHeight
            }
            
            // 不要广告可注销 删除 后面 HJAdvertisementButtonH 广告高度
            return CGFloat(readChapterListModel.chapterHeight.floatValue) + ReadViewTopSpace + AdvertisementButtonH
            
        }else{}
        
        return ScreenHeight
    }
    
    // MARK: -- 通知
    
    /// 修改背景颜色
    func changeBGColor() {
        
        if ReadConfigureManger.shareManager.readColorInex.integerValue == ReadColors.indexOf(Color_12) { // 牛皮黄
            
            let color:UIColor = UIColor(patternImage:UIImage(named: "icon_read_bg_0")!)
            
            readTopStatusView.backgroundColor = color
            
            view.backgroundColor = color
            
        }else{
            
            let color = ReadColors[ReadConfigureManger.shareManager.readColorInex.integerValue]
            
            readTopStatusView.backgroundColor = color
            
            view.backgroundColor = color
        }
    }
    
    /// 修改阅读方式
    func changeFlipEffect() {
        
        flipEffect = ReadConfigureManger.shareManager.flipEffect
        
        if flipEffect == ReadFlipEffect.None { // 无效果
            
            tableView.scrollEnabled = false
            
        }else if flipEffect == ReadFlipEffect.Translation { // 平滑
            
            tableView.scrollEnabled = false
            
        }else if flipEffect == ReadFlipEffect.Simulation { // 仿真
            
            tableView.scrollEnabled = false
            
        }else if flipEffect == ReadFlipEffect.UpAndDown { // 上下滚动
            
            tableView.scrollEnabled = true
            
            // 获取当前章节
            let readChapterListModel = readPageController.readConfigure.GetReadChapterListModel(readRecord.readChapterListModel.chapterID)
            
            if (readChapterListModel != nil) { // 有章节
                
                // 刷新数据
                let index = readPageController.readModel.readChapterListModels.indexOf(readChapterListModel!)
                
                GetReadChapterModel(readChapterListModel!)
                
                if readPageController.readModel.readRecord.contentOffsetY != nil {
                    
                    tableView.setContentOffset(CGPointMake(tableView.contentOffset.x, CGFloat(readPageController.readModel.readRecord.contentOffsetY!.floatValue)), animated: false)
                    
                }else{
                    
                    // 滚到指定章节的cell
                    tableView.scrollToRowAtIndexPath(NSIndexPath(forRow: index!,inSection: 0), atScrollPosition: UITableViewScrollPosition.Top, animated: false)
                    
                    // 滚动到指定cell的指定位置
                    let redFrame = ReadParser.GetReadViewFrame()
                    
                    tableView.setContentOffset(CGPointMake(tableView.contentOffset.x, tableView.contentOffset.y + CGFloat(readPageController.readModel.readRecord.page.integerValue) * redFrame.height), animated: false)
                }
                
                // 获取准确页面
                GetCurrentPage()
            }
            
        }else{}
    }
    
    /**
     获取阅读章节模型
     */
    func GetReadChapterModel(readChapterListModel:ReadChapterListModel) ->ReadChapterModel {
        
        // 从缓存里面获取文件
        let tempReadChapterModel = ReadKeyedUnarchiver(readPageController.readModel.bookID, fileName: readChapterListModel.chapterID) as! ReadChapterModel
        
        // 更新字体
        tempReadChapterModel.updateFont()
        
        // 计算高度
        readChapterListModel.chapterHeight = ReadParser.parserReadContentHeight(tempReadChapterModel.chapterContent, configure: ReadConfigureManger.shareManager, width: ScreenWidth - ReadViewLeftSpace - ReadViewRightSpace)
        
        return tempReadChapterModel
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit{
        
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        readBottomStatusView.removeTimer()
    }
    
}
