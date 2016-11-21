
//
//  ReadConfigureManger.swift
//  Reader
//
//  Created by 千锋 on 16/11/1.
//  Copyright © 2016年 heyang. All rights reserved.
//



/// 阅读配置 KeyedArchiver 文件名
private let ReadConfigure:String = "ReadConfigure"

/// 颜色数组
let ReadColors:[UIColor] = [Color_8,Color_9,Color_10,Color_11,Color_12,Color_13]

/// 阅读最小阅读字体大小
let ReadMinFontSize:Int = 12

/// 阅读最大阅读字体大小
let ReadMaxFontSize:Int = 25

/// 阅读当前默认字体大小
let ReadDefaultFontSize:Int = 16

/// 字体颜色
let ReadTextColor:UIColor = RGB(68, g: 68, b: 68)

import UIKit

class ReadConfigureManger: NSObject{
    
    // MARK: -- 属性
    
    // MARK: -- 设置 - 颜色属性
    
    /// 当前的阅读颜色
    var readColorInex:NSNumber = 5 {
        
        didSet{
            
            updateKeyedArchiver()
        }
    }
    
    // MARK: -- 阅读翻书效果
    
    /// 记录阅读翻书效果 不建议使用该值
    var flipEffectNumber:NSNumber! = 1 {
        
        didSet{
            
            updateKeyedArchiver()
        }
    }
    
    /// 阅读翻书效果
    var flipEffect:ReadFlipEffect! {
        
        get{
            
            return ReadFlipEffect(rawValue: flipEffectNumber.integerValue) ?? ReadFlipEffect(rawValue: 1)
        }
        set{
            
            flipEffectNumber = newValue.rawValue
        }
    }
    
    
    // MARK: -- 字号
    
    /// 阅读字号
    var readFontSize:NSNumber! = ReadDefaultFontSize {
        
        didSet{
            
            updateKeyedArchiver()
        }
    }
    
    /// 分隔间距
    var readSpaceLineH:CGFloat = 10
    
    // MARK: -- 阅读字体
    
    /// 阅读字体颜色
    var textColor:UIColor! = ReadTextColor
    
    /// 记录 阅读字体 不建议使用该值
    var readFontNumber:NSNumber! = 0 {
        
        didSet{
            
            updateKeyedArchiver()
        }
    }
    
    ///  阅读字体
    var readFont:ReadFont! {
        
        get{
            
            return ReadFont(rawValue: readFontNumber.integerValue) ?? ReadFont(rawValue: 0)
        }
        set{
            
            readFontNumber = newValue.rawValue
        }
    }
    
    
    // MARK: -- 亮度属性
    
    /// 记录阅读亮度模式 不建议使用该值
    var lightTypeNumber:NSNumber! = 0 {
        
        didSet{
            
            updateKeyedArchiver()
        }
    }
    
    /// 阅读亮度模式
    var lightType:ReadLightType! {
        
        get{
            
            return ReadLightType(rawValue: lightTypeNumber.integerValue) ?? ReadLightType(rawValue: 0)
        }
        set{
            
            lightTypeNumber = newValue.rawValue
        }
    }
    
    // MARK: -- 刷新缓存
    
    /**
     刷新 KeyedArchiver
     */
    func updateKeyedArchiver() {
        
        KeyedArchiver(ReadConfigure, object: self)
    }
    
    
    // MARK: --  对象相关
    
    // 获取单利对象
    class var shareManager : ReadConfigureManger {
        
        struct Static {
            
            static let instance : ReadConfigureManger = ReadConfigureManger.GetManager()
        }
        
        return Static.instance
    }
    
    /**
     获取配置对象
     
     - returns: 配置对象
     */
    private class func GetManager() ->ReadConfigureManger {
        
        var manager:ReadConfigureManger? = KeyedUnarchiver(ReadConfigure) as? ReadConfigureManger
        
        if manager == nil {
            
            manager = ReadConfigureManger()
        }
        
        return manager!
    }
    
    override init() {
        
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init()
        
        readColorInex = aDecoder.decodeObjectForKey("readColorInex") as! NSNumber
        
        flipEffectNumber = aDecoder.decodeObjectForKey("flipEffectNumber") as! NSNumber
        
        readFontSize = aDecoder.decodeObjectForKey("readFontSize") as! NSNumber
        
        readFontNumber = aDecoder.decodeObjectForKey("readFontNumber") as! NSNumber
        
        lightTypeNumber = aDecoder.decodeObjectForKey("lightTypeNumber") as! NSNumber
    }
    
    override func encodeWithCoder(aCoder: NSCoder) {
        
        aCoder.encodeObject(readColorInex, forKey: "readColorInex")
        
        aCoder.encodeObject(flipEffectNumber, forKey: "flipEffectNumber")
        
        aCoder.encodeObject(readFontSize, forKey: "readFontSize")
        
        aCoder.encodeObject(readFontNumber, forKey: "readFontNumber")
        
        aCoder.encodeObject(lightTypeNumber, forKey: "lightTypeNumber")
        
    }
}

