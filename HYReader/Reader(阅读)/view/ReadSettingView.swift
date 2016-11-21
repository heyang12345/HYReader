//
//  ReadSettingView.swift
//  Reader
//
//  Created by 千锋 on 16/11/2.
//  Copyright © 2016年 heyang. All rights reserved.
//


/// 阅读设置view 子控件的左右间距
let ReadSettingSpaceW:CGFloat = SA(25, other: 30)

import UIKit

class ReadSettingView: UIView {
    
    /// 分割线
    private var spaceLine:UIView!
    
    /// 颜色
    var colorView:ReadSettingColorView!
    
    // 翻页效果
    var flipEffectView:ReadSettingFlipEffectView!
    
    // 字体
    var fontView:ReadSettingFontView!
    
    // 字号
    var fontSizeView:ReadSettingFontSizeView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.whiteColor()
        
        addSubviews()
    }
    
    func addSubviews() {
        
        // 颜色
        colorView = ReadSettingColorView()
        addSubview(colorView)
        
        // 翻页效果
        flipEffectView = ReadSettingFlipEffectView()
        addSubview(flipEffectView)
        
        // 字体
        fontView = ReadSettingFontView()
        addSubview(fontView)
        
        // 字号
        fontSizeView = ReadSettingFontSizeView()
        addSubview(fontSizeView)
        
        // 分割线
        spaceLine = SpaceLineSetup(self, color: Color_6)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        colorView.frame = CGRectMake(0, 0, width, 65)
        
        let tempH:CGFloat = (height - colorView.height) / 3
        
        flipEffectView.frame = CGRectMake(0, CGRectGetMaxY(colorView.frame), width, tempH)
        
        fontView.frame = CGRectMake(0, CGRectGetMaxY(flipEffectView.frame), width, tempH)
        
        fontSizeView.frame = CGRectMake(0, CGRectGetMaxY(fontView.frame), width, tempH)
        
        spaceLine.frame = CGRectMake(0, 0, width, SpaceLineHeight)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
