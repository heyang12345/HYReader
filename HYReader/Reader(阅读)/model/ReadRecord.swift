//
//  ReadRecord.swift
//  Reader
//
//  Created by 千锋 on 16/11/1.
//  Copyright © 2016年 heyang. All rights reserved.
//



import UIKit

class ReadRecord: NSObject {
    
    /// 只有在滚动模式下才使用别的都没有用
    var contentOffsetY:NSNumber?
    
    /// 当前阅读到的章节模型
    var readChapterListModel:ReadChapterListModel!
    
    /// 当前阅读到的章节模型
    var readChapterModel:ReadChapterModel?
    
    /// 当前阅读到章节的页码
    var page:NSNumber = 0
    
    /// 当前阅读到的章节索引
    var chapterIndex:NSNumber = 0
    
    /// 总章节数
    var chapterCount:NSNumber = 0
    
    override init() {
        
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init()
        
        contentOffsetY = aDecoder.decodeObjectForKey("contentOffsetY") as? NSNumber
        
        readChapterListModel = aDecoder.decodeObjectForKey("readChapterListModel") as? ReadChapterListModel
        
        readChapterModel = aDecoder.decodeObjectForKey("readChapterModel") as? ReadChapterModel
        
        page = aDecoder.decodeObjectForKey("page") as! NSNumber
        
        chapterIndex = aDecoder.decodeObjectForKey("chapterIndex") as! NSNumber
        
        chapterCount = aDecoder.decodeObjectForKey("chapterCount") as! NSNumber
    }
    
    override func encodeWithCoder(aCoder: NSCoder) {
        
        aCoder.encodeObject(contentOffsetY, forKey: "contentOffsetY")
        
        aCoder.encodeObject(readChapterListModel, forKey: "readChapterListModel")
        
        aCoder.encodeObject(readChapterModel, forKey: "readChapterModel")
        
        aCoder.encodeObject(page, forKey: "page")
        
        aCoder.encodeObject(chapterIndex, forKey: "chapterIndex")
        
        aCoder.encodeObject(chapterCount, forKey: "chapterCount")
    }
}
