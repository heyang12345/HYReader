//
//  ReadSettingFontView.swift
//  Reader
//
//  Created by 千锋 on 16/11/2.
//  Copyright © 2016年 heyang. All rights reserved.
//


import UIKit

protocol ReadSettingFontViewDelegate:NSObjectProtocol {
    
    /**
     字体发生变化的时候调用
     */
    func readSettingFontView(readSettingFontView:ReadSettingFontView,changeFont font:ReadFont)
}

class ReadSettingFontView: ReadSettingCustomView {
    
    // 代理
    weak var delegate:ReadSettingFontViewDelegate?
    
    /// 当前选中的按钮
    private var selectButton:UIButton?
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        nomalNames = ["系统","黑体","楷体","宋体"]
        
        addSubviews()
        
        titleLabel.text = "字体"
        
        for button in Buttons {
            
            button.contentHorizontalAlignment = .Center
            
            button.addTarget(self, action: #selector(ReadSettingFontView.clickButton(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        }
        
        if !Buttons.isEmpty {
            
            clickButton(Buttons[ReadConfigureManger.shareManager.readFont.rawValue])
        }
    }
    
    // 点击按钮
    func clickButton(button:UIButton) {
        
        if selectButton == button {return}
        
        selectButton?.selected = false
        
        button.selected = true
        
        selectButton = button
        
        let readFont = ReadFont(rawValue: button.tag)!
        
        ReadConfigureManger.shareManager.readFont = readFont
        
        delegate?.readSettingFontView(self, changeFont: readFont)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
