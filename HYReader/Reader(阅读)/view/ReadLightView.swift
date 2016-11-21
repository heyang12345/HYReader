//
//  ReadLightView.swift
//  Reader
//
//  Created by 千锋 on 16/11/2.
//  Copyright © 2016年 heyang. All rights reserved.
//


import UIKit

protocol ReadLightViewDelegate:NSObjectProtocol {
    
    /// 切换亮度背景
    func readLightView(readLightView:ReadLightView, lightType:ReadLightType)
}

class ReadLightView: UIView {
    
    /// 代理
    weak var delegate:ReadLightViewDelegate?
    
    // 分割线
    private var spaceLine:UIView!
    
    /// 进度条
    private var slider:UISlider!
    
    /// textLabel
    private var textLabel:UILabel!
    
    /// 亮度按钮
    private var lightButton:UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.whiteColor()
        
        addSubviews()
    }
    
    func addSubviews() {
        
        // 进度条
        slider = UISlider()
        slider.minimumValue = 0.0
        slider.maximumValue = 1.0
        slider.value = Float(UIScreen.mainScreen().brightness)
        slider.tintColor = Color_4
        slider.setThumbImage(UIImage(named: "icon_read_0")!, forState: UIControlState.Normal)
        slider.addTarget(self, action: #selector(ReadLightView.sliderChanged(_:)), forControlEvents: UIControlEvents.ValueChanged)
        addSubview(slider)
        
        // textLabel
        textLabel = UILabel()
        textLabel.text = "亮度"
        textLabel.textAlignment = .Right
        textLabel.font = UIFont.fontOfSize(14)
        addSubview(textLabel)
        
        // lightButton
        lightButton = UIButton(type:UIButtonType.Custom)
        lightButton.selected = ReadConfigureManger.shareManager.lightTypeNumber.boolValue
        lightButton.setImage(UIImage(named: "icon_read_2"), forState: UIControlState.Normal)
        lightButton.setImage(UIImage(named: "icon_read_1"), forState: UIControlState.Selected)
        lightButton.contentHorizontalAlignment = .Left
        lightButton.addTarget(self, action: #selector(ReadLightView.clickLightButton(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        addSubview(lightButton)
        
        // 分割线
        spaceLine = SpaceLineSetup(self, color: Color_6)
    }
    
    func clickLightButton(button:UIButton) {
        
        button.selected = !button.selected
        
        let lightType = ReadLightType(rawValue: Int(button.selected))!
        
        ReadConfigureManger.shareManager.lightType = lightType
        
        delegate?.readLightView(self, lightType: lightType)
    }
    
    @objc private func sliderChanged(slider:UISlider) {
        
        UIScreen.mainScreen().brightness = CGFloat(slider.value)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // 进度条
        let sliderW:CGFloat = 208
        let chapterButtonW:CGFloat = (width - sliderW) / 2
        slider.frame = CGRectMake(chapterButtonW, 0, sliderW, height)
        
        // textLabel
        let textLabelH = CGRectGetMinX(slider.frame) - SpaceTwo
        textLabel.frame = CGRectMake(0, 0, textLabelH, height)
        
        // lightButton
        let lightButtonX:CGFloat = CGRectGetMaxX(slider.frame) + SpaceTwo
        let lightButtonW:CGFloat = width - lightButtonX
        lightButton.frame = CGRectMake(lightButtonX, 0, lightButtonW, height)
        
        /// spaceLine
        spaceLine.frame = CGRectMake(0, 0, width, SpaceLineHeight)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
