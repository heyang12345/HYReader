//
//  ReadChapterModel.swift
//  Reader
//
//  Created by 千锋 on 16/11/1.
//  Copyright © 2016年 heyang. All rights reserved.
//

import UIKit
import CoreText

class ReadChapterModel: NSObject {
    
    var chapterID: String!                 // 章节ID
    var previousChapterId: String?         // 上一章ID
    var nextChapterId:String?              // 下一章ID
    var chapterName: String!               // 章节名称
    var volumeID: String!                  // 卷ID
    var chapterContent: String! = ""       // 章节内容
    
    var pageCount:NSNumber = 0             // 本章有多少页
    var pageLocationArray:[Int] = []       // 分页的起始位置
    
    /// 刷新字体
    func updateFont() {
        
        pageRangeWithBounds(ReadParser.GetReadViewFrame())
    }
    
    private func pageRangeWithBounds(bounds:CGRect) {
        
        pageLocationArray.removeAll()
        
        // 拼接字符串
        let attrString = NSMutableAttributedString(string: chapterContent,attributes: ReadParser.parserAttribute(ReadConfigureManger.shareManager))
        
        let frameSetter = CTFramesetterCreateWithAttributedString(attrString as CFAttributedString)
        
        let path = CGPathCreateWithRect(bounds, nil)
        
        var currentOffset = 0
        
        var currentInnerOffset = 0
        
        var hasMorePages:Bool = true
        
        // 防止死循环，如果在同一个位置获取CTFrame超过2次，则跳出循环
        let preventDeadLoopSign = currentOffset
        
        var samePlaceRepeatCount = 0
        
        while hasMorePages {
            
            if preventDeadLoopSign == currentOffset {
                
                samePlaceRepeatCount += 1
                
            }else{
                
                samePlaceRepeatCount = 0
            }
            
            if samePlaceRepeatCount > 1 {
                
                if pageLocationArray.count == 0 {
                    
                    pageLocationArray.append(currentOffset)
                    
                }else{
                    
                    let lastOffset = pageLocationArray.last
                    
                    if lastOffset != currentOffset {
                        
                        pageLocationArray.append(currentOffset)
                    }
                }
                
                break
            }
            
            pageLocationArray.append(currentOffset)
            
            let frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(currentInnerOffset, 0), path, nil)
            let range = CTFrameGetVisibleStringRange(frame)
            
            if (range.location + range.length) != attrString.length {
                
                currentOffset += range.length
                
                currentInnerOffset += range.length
                
            }else{
                
                // 已经分完，提示跳出循环
                
                hasMorePages = false
            }
            
            pageCount = pageLocationArray.count
        }
    }
    
    /**
     根据index 页码返回对应的字符串
     
     - parameter index: 页码索引
     */
    func stringOfPage(index:Int) ->String {
        
        let local = pageLocationArray[index]
        
        var length = 0
        
        if index < pageCount.integerValue - 1 {
            
            length = pageLocationArray[index + 1] - pageLocationArray[index]
            
        }else{
            
            length = chapterContent.length - pageLocationArray[index]
        }
        
        return chapterContent.substringWithRange(NSMakeRange(local, length))
    }
    
    // MARK: -- aDecoder
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init()
        
        chapterID = aDecoder.decodeObjectForKey("chapterID") as! String
        
        nextChapterId = aDecoder.decodeObjectForKey("nextChapterId") as? String
        
        previousChapterId = aDecoder.decodeObjectForKey("previousChapterId") as? String
        
        chapterName = aDecoder.decodeObjectForKey("chapterName") as! String
        
        volumeID = aDecoder.decodeObjectForKey("volumeID") as! String
        
        pageCount = aDecoder.decodeObjectForKey("pageCount") as! NSNumber
        
        pageLocationArray = aDecoder.decodeObjectForKey("pageLocationArray") as! [Int]
        
        chapterContent = aDecoder.decodeObjectForKey("chapterContent") as! String
    }
    
    override func encodeWithCoder(aCoder: NSCoder) {
        
        aCoder.encodeObject(chapterID, forKey: "chapterID")
        
        aCoder.encodeObject(nextChapterId, forKey: "nextChapterId")
        
        aCoder.encodeObject(previousChapterId, forKey: "previousChapterId")
        
        aCoder.encodeObject(chapterName, forKey: "chapterName")
        
        aCoder.encodeObject(volumeID, forKey: "volumeID")
        
        aCoder.encodeObject(pageCount, forKey: "pageCount")
        
        aCoder.encodeObject(pageLocationArray, forKey: "pageLocationArray")
        
        aCoder.encodeObject(chapterContent, forKey: "chapterContent")
    }
    
}
