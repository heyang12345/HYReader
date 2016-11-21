//
//  ReadModel.swift
//  Reader
//
//  Created by 千锋 on 16/11/1.
//  Copyright © 2016年 heyang. All rights reserved.
//


import UIKit

class ReadModel: NSObject {
    
    /// 当前的小说ID (本地小说的话 bookID就是bookName)
    var bookID:String!
    
    /// 章节列表数组
    var readChapterListModels:[ReadChapterListModel]!
    
    /// 阅读记录
    var readRecord:ReadRecord!
    
    /// 是否为本地小说
    var isLocalBook:NSNumber! = 0
    
    /// 本地小说使用 解析获得的整本字符串
    //    var content:String! = ""
    
    /// 本地小说使用 来源地址 路径
    var resource:NSURL?
    
    // MARK: -- 构造方法
    
    /// 初始化大字符串文本
    convenience init(bookID:String,content:String) {
        self.init()
        
        //        self.content = content
        
        self.bookID = bookID
        
        readChapterListModels = ReadParser.separateContent(bookID, content: content)
        
        if !readChapterListModels.isEmpty {
            
            readRecord.readChapterListModel = readChapterListModels.first
            
            readRecord.chapterIndex = 0
            
            readRecord.chapterCount = readChapterListModels.count
        }
    }
    
    override init() {
        super.init()
        
        readChapterListModels = [ReadChapterListModel]()
        
        readRecord = ReadRecord()
    }
    
    /// 初始化本地URL小说地址
    class func readModelWithLocalBook(url:NSURL) ->ReadModel {
        
        // 本地小说 bookID 也是 bookName
        let bookID = ReadParser.GetBookName(url)
        
        var model = ReadKeyedUnarchiver(bookID, fileName: bookID) as? ReadModel
        
        // 没有缓存
        if model == nil {
            
            if url.path!.lastPathComponent().pathExtension() == "txt" {  // text 格式
                
                model = ReadModel(bookID: bookID,content: ReadParser.encodeURL(url))
                model!.resource = url
                model!.isLocalBook = 1
                ReadModel.updateReadModel(model!)
                
                return model!
                
            }else{
                
                print("格式错误!")
            }
        }
        
        return model!
    }
    
    /// 传入Key 获取对应阅读模型
    class func readModelWithFileName(booID:String) ->ReadModel? {
        
        return ReadKeyedUnarchiver(booID, fileName: booID) as? ReadModel
        
    }
    
    // MARK: -- 刷新缓存数据
    
    class func updateReadModel(readModel:ReadModel) {
        
        ReadKeyedArchiver(readModel.bookID, fileName: readModel.bookID, object: readModel)
    }
    
    // MARK: -- aDecoder
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init()
        
        bookID = aDecoder.decodeObjectForKey("bookID") as! String
        
        readChapterListModels = aDecoder.decodeObjectForKey("readChapterListModels") as! [ReadChapterListModel]
        
        readRecord = aDecoder.decodeObjectForKey("readRecord") as! ReadRecord
        
        isLocalBook = aDecoder.decodeObjectForKey("isLocalBook") as! NSNumber
        
        resource = aDecoder.decodeObjectForKey("resource") as? NSURL
    }
    
    override func encodeWithCoder(aCoder: NSCoder) {
        
        aCoder.encodeObject(bookID, forKey: "bookID")
        
        aCoder.encodeObject(readChapterListModels, forKey: "readChapterListModels")
        
        aCoder.encodeObject(readRecord, forKey: "readRecord")
        
        aCoder.encodeObject(isLocalBook, forKey: "isLocalBook")
        
        aCoder.encodeObject(resource, forKey: "resource")
    }
}
