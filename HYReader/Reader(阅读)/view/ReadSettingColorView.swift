//
//  ReadSettingColorView.swift
//  Reader
//
//  Created by 千锋 on 16/11/2.
//  Copyright © 2016年 heyang. All rights reserved.
//


import UIKit

@objc protocol ReadSettingColorViewDelegate:NSObjectProtocol {
    
    /**
     阅读背景颜色发生变化的时候调用
     */
    optional func readSettingColorView(readSettingColorView:ReadSettingColorView,changeReadColor readColor:UIColor)
}

class ReadSettingColorView: UIScrollView {
    
    // 代理
    weak var aDelegate:ReadSettingColorViewDelegate?
    
    /// 分割线
    private var spaceLine:UIView!
    
    /// 当前选中的按钮
    private var selectButton:UIButton?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.whiteColor()
        
        addSubviews()
    }
    
    func addSubviews() {
        
        // 创建颜色按钮
        let count = ReadColors.count
        
        for i in 0..<count {
            
            let backgroundColor = ReadColors[i]
            let button = UIButton(type:UIButtonType.Custom)
            button.tag = i
            button.layer.borderColor = Color_4.CGColor
            button.layer.borderWidth = backgroundColor == Color_13 ? 1 : 0
            button.backgroundColor = backgroundColor
            addSubview(button)
            button.addTarget(self, action: #selector(ReadSettingColorView.clickButton(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            
            // 当前选中的颜色
            if i == ReadConfigureManger.shareManager.readColorInex {
                
                clickButton(button)
            }
        }
        
        // 分割线
        spaceLine = SpaceLineSetup(self, color: Color_6)
    }
    
    func clickButton(button:UIButton) {
        
        if selectButton == button {return}
        
        selectButton?.layer.borderWidth -= 1
        
        button.layer.borderWidth += 1
        
        selectButton = button
        
        let readColor = ReadColors[button.tag]
        
        ReadConfigureManger.shareManager.readColorInex = button.tag
        
        aDelegate?.readSettingColorView?(self, changeReadColor: readColor)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let count = ReadColors.count
        
        // 左右间距
        let spaceW:CGFloat = ReadSettingSpaceW
        
        let buttoonWH:CGFloat = 36
        
        let buttoonY:CGFloat = (height - buttoonWH) / 2
        
        let centerSpaceW:CGFloat = (width - 2*spaceW - buttoonWH*CGFloat(count)) / (CGFloat(count) - 1)
        
        for i in 0..<count {
            
            let button = subviews[i]
            
            button.frame = CGRectMake(spaceW + CGFloat(i) * (buttoonWH + centerSpaceW), buttoonY, buttoonWH, buttoonWH)
            
            button.layer.cornerRadius = buttoonWH/2
        }
        
        spaceLine.frame = CGRectMake(0, height - SpaceLineHeight, width, SpaceLineHeight)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
