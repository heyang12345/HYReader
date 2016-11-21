//
//  ReadSettingFlipEffectView.swift
//  Reader
//
//  Created by 千锋 on 16/11/2.
//  Copyright © 2016年 heyang. All rights reserved.
//



import UIKit

protocol ReadSettingFlipEffectViewDelegate:NSObjectProtocol {
    
    /**
     翻页效果发生变化的时候调用
     */
    func readSettingFlipEffectView(readSettingFlipEffectView:ReadSettingFlipEffectView,changeFlipEffect flipEffect:ReadFlipEffect)
}


class ReadSettingFlipEffectView: ReadSettingCustomView {
    
    // 代理
    weak var delegate:ReadSettingFlipEffectViewDelegate?
    
    /// 当前选中的按钮
    private var selectButton:UIButton?
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        nomalNames = ["无效果","覆盖","仿真","上下"]
        
        addSubviews()
        
        titleLabel.text = "翻书动画"
        
        for button in Buttons {
            
            button.contentHorizontalAlignment = .Center
            
            button.addTarget(self, action: #selector(ReadSettingFlipEffectView.clickButton(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        }
        
        if !Buttons.isEmpty {
            
            clickButton(Buttons[ReadConfigureManger.shareManager.flipEffect.rawValue])
        }
    }
    
    // 点击按钮
    func clickButton(button:UIButton) {
        
        if selectButton == button {return}
        
        let flipEffect = ReadFlipEffect(rawValue: button.tag)!
        
        // 暂时不支持的效果
        //        if flipEffect == HJReadFlipEffect.UpAndDown {return}
        
        selectButton?.selected = false
        
        button.selected = true
        
        selectButton = button
        
        ReadConfigureManger.shareManager.flipEffect = flipEffect
        
        delegate?.readSettingFlipEffectView(self, changeFlipEffect: flipEffect)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
