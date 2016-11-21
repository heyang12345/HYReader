
//
//  AttrTwo.swift
//  Reader
//
//  Created by 千锋 on 16/11/1.
//  Copyright © 2016年 heyang. All rights reserved.
//


import Foundation
import UIKit

// MARK: -- 常用字体存放

let Font_6:UIFont = UIFont.systemFontOfSize(6)
let Font_10:UIFont = UIFont.systemFontOfSize(10)
let Font_12:UIFont = UIFont.systemFontOfSize(12)
let Font_14:UIFont = UIFont.systemFontOfSize(14)
let Font_16:UIFont = UIFont.systemFontOfSize(16)
let Font_18:UIFont = UIFont.systemFontOfSize(18)
let Font_20:UIFont = UIFont.systemFontOfSize(20)
let Font_24:UIFont = UIFont.systemFontOfSize(24)
let Font_26:UIFont = UIFont.systemFontOfSize(26)

// MARK: -- 常用颜色存放 ---------------

let Color_1:UIColor = RGB(68, g: 68, b: 68)
let Color_2:UIColor = RGB(160, g: 160, b: 160)
let Color_3:UIColor = RGB(209, g: 209, b: 209)
let Color_4:UIColor = RGB(70,  g: 128, b: 227) // 主题蓝
let Color_5:UIColor = RGB(245,  g: 245, b: 245) // 背景
let Color_6:UIColor = RGB(240,  g: 240, b: 240) // 分割线颜色
let Color_7:UIColor = RGB(216, g: 216, b: 216)
// MARK: -- 阅读页面使用颜色
let Color_8:UIColor = RGB(229, g: 229, b: 229)
let Color_9:UIColor = RGB(85, g: 123, b: 205)
//let Color_10:UIColor = RGB(200, g: 231, b: 240)
let Color_10:UIColor = UIColor(patternImage: UIImage.init(named: "color2")!)
let Color_11:UIColor = RGB(245, g: 214, b: 214)
let Color_12:UIColor = RGB(251, g: 237, b: 199)
let Color_13:UIColor = RGB(251, g: 252, b: 255)
//let Color_8:UIColor = UIColor(patternImage: UIImage.init(named: "4")!)
//let Color_9:UIColor = UIColor(patternImage: UIImage.init(named: "1")!)



// MARK: -- 图书相关 ------------------

let bookWidth:CGFloat = (ScreenWidth-90)/3.0
let bookScale:CGFloat = 130.0/95.0
let bookHeight:CGFloat = bookWidth*bookScale


// MARK: -- 常用间距

/// 分割线高度
let SpaceLineHeight:CGFloat = 0.5

/// 间距 10
let SpaceOne:CGFloat = 10

/// 间距 15
let SpaceTwo:CGFloat = 15

/// 间距 5
let SpaceThree:CGFloat = 5