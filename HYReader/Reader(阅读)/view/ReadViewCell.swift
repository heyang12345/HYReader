//
//  ReadViewCell.swift
//  Reader
//
//  Created by 千锋 on 16/11/2.
//  Copyright © 2016年 heyang. All rights reserved.
//


// 不要广告可注销
let AdvertisementButtonH:CGFloat = 70

import UIKit

class ReadViewCell: UITableViewCell {
    
    var readView:ReadView!
    
    /// 当前是否为这一章的最后一页
    var isLastPage:Bool = false
    
    // 章节数据
    var readChapterModel:ReadChapterModel?
    
    // 章节信息
    var readChapterListModel:ReadChapterListModel?
    
    // 只有在上下滚动的时候才用得到
    var contentH:CGFloat = 0
    
    // 广告按钮
    var advertisementButton:UIButton!
    
    var content:String? {
        
        didSet{
            
            if content != nil && !content!.isEmpty { // 字符串有值
                
                readView.hidden = false
                
                let redFrame = ReadParser.GetReadViewFrame()
                
                if ReadConfigureManger.shareManager.flipEffect == ReadFlipEffect.UpAndDown { // 上下滚动
                    
                    readView.frameRef = ReadParser.parserRead(content!, configure: ReadConfigureManger.shareManager, bounds: CGRectMake(0, 0, redFrame.width, contentH))
                    
                }else{
                    
                    readView.frameRef = ReadParser.parserRead(content!, configure: ReadConfigureManger.shareManager, bounds: CGRectMake(0, 0, redFrame.width, redFrame.height))
                }
                
                setNeedsLayout()
            }
        }
    }
    
    
    class func cellWithTableView(tableView:UITableView) ->ReadViewCell {
        
        let ID = "ReadViewCell"
        
        var cell = tableView.dequeueReusableCellWithIdentifier(ID) as? ReadViewCell
        
        cell?.readView.hidden = true
        
        cell?.readChapterModel = nil
        
        cell?.readChapterListModel = nil
        
        cell?.content = nil
        
        cell?.advertisementButton.hidden = true
        
        if (cell == nil) {
            
            cell = ReadViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: ID);
        }
        
        return cell!
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = UIColor.clearColor()
        
        selectionStyle = UITableViewCellSelectionStyle.None
        
        addSubViews()
    }
    
    func addSubViews() {
        
        readView = ReadView()
        readView.backgroundColor = UIColor.clearColor()
        contentView.addSubview(readView)
        
        // 不要广告可注销
        advertisementButton = UIButton(type:UIButtonType.Custom)
        advertisementButton.setImage(UIImage(named: "advertisementIon")!, forState: .Normal)
        advertisementButton.hidden = true
        advertisementButton.backgroundColor = UIColor.redColor()
        contentView.addSubview(advertisementButton)
        advertisementButton.addTarget(self, action: #selector(ReadViewCell.clickAdvertisementButton), forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    /// 点击广告
    func clickAdvertisementButton() {
        
        //MBProgressHUD.showSuccess("点击了章节广告")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // 不要广告的写法 取掉 AdvertisementButton 相关的  搜索 "不要广告可注销"
        //        if HJReadConfigureManger.shareManager.flipEffect == HJReadFlipEffect.UpAndDown { // 上下滚动
        //
        //            let redFrame = HJReadParser.GetReadViewFrame()
        //
        //            readView.frame = CGRectMake(redFrame.origin.x, HJReadViewTopSpace, redFrame.size.width, contentH)
        //
        //        }else{
        //
        //            readView.frame = HJReadParser.GetReadViewFrame()
        //        }
        
        // 不要广告可注销  下面全部代码
        if ReadConfigureManger.shareManager.flipEffect == ReadFlipEffect.UpAndDown { // 上下滚动
            
            let redFrame = ReadParser.GetReadViewFrame()
            
            readView.frame = CGRectMake(redFrame.origin.x, ReadViewTopSpace, redFrame.size.width, contentH)
            
            advertisementButton.frame = CGRectMake(SpaceTwo, height - AdvertisementButtonH, ScreenWidth - 2*SpaceTwo, AdvertisementButtonH)
            
            advertisementButton.hidden = false
            
        }else{
            
            readView.frame = ReadParser.GetReadViewFrame()
            
            if isLastPage && content != nil && content!.length < 250 {
                
                advertisementButton.frame = CGRectMake(SpaceTwo, height - AdvertisementButtonH - 30, ScreenWidth - 2*SpaceTwo, AdvertisementButtonH)
                
                advertisementButton.hidden = false
                
            }else{
                
                advertisementButton.hidden = true
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
