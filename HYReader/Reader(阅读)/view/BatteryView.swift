//
//  BatteryView.swift
//  Reader
//
//  Created by 千锋 on 16/11/2.
//  Copyright © 2016年 heyang. All rights reserved.
//



/// 电池宽推荐使用宽高
var BatterySize:CGSize = CGSizeMake(25, 10)

/// 电池量宽度 跟图片的比例
private var BatteryLevelViewW:CGFloat = 20
private var BatteryLevelViewScale = BatteryLevelViewW / BatterySize.width

import UIKit

class BatteryView: UIImageView {
    
    /// BatteryLevel
    var batteryLevel:Float = 0 {
        
        didSet{
            
            setNeedsLayout()
        }
    }
    
    /// BatteryLevelView
    private var batteryLevelView:UIView!
    
    convenience init() {
        
        self.init(frame: CGRectMake(0, 0, BatterySize.width, BatterySize.height))
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: CGRectMake(0, 0, BatterySize.width, BatterySize.height))
        
        addSubviews()
    }
    
    func addSubviews() {
        
        // 图片
        image = UIImage(named: "Battery")
        
        // 进度
        batteryLevelView = UIView()
        batteryLevelView.layer.masksToBounds = true
        batteryLevelView.backgroundColor = UIColor.blackColor()
        addSubview(batteryLevelView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let spaceW:CGFloat = 1 * (frame.width / BatterySize.width) * BatteryLevelViewScale
        let spaceH:CGFloat = 1 * (frame.height / BatterySize.height) * BatteryLevelViewScale
        
        let batteryLevelViewY:CGFloat = 2.1*spaceH
        let batteryLevelViewX:CGFloat = 1.4*spaceW
        let batteryLevelViewH:CGFloat = frame.height - 3.4*spaceH
        let batteryLevelViewW:CGFloat = frame.width * BatteryLevelViewScale
        let batteryLevelViewWScale:CGFloat = batteryLevelViewW / 100
        
        // 判断电量
        var tempBatteryLevel = batteryLevel
        
        if batteryLevel < 0 {
            
            tempBatteryLevel = 0
            
        }else if batteryLevel > 1 {
            
            tempBatteryLevel = 1
            
        }else{}
        
        batteryLevelView.frame = CGRectMake(batteryLevelViewX , batteryLevelViewY, CGFloat(tempBatteryLevel * 100) * batteryLevelViewWScale, batteryLevelViewH)
        batteryLevelView.layer.cornerRadius = batteryLevelViewH * 0.125
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
