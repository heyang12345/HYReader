//
//  ReadBottomStatusView.swift
//  Reader
//
//  Created by 千锋 on 16/11/2.
//  Copyright © 2016年 heyang. All rights reserved.
//

let ReadBottomStatusViewH:CGFloat = 30

import UIKit

class ReadBottomStatusView: UIView {
    
    /// 页码
    private var numberPageLabel:UILabel!
    
    /// 时间
    private var timeLabel:UILabel!
    
    /// 倒计时器
    private var timer:NSTimer?
    
    /// 电池view
    private var batteryView:BatteryView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews()
    }
    
    /// 设置页码
    func setNumberPage(page:Int,tatolPage:Int) {
        
        numberPageLabel.text = "\(page + 1)/\(tatolPage)"
    }
    
    func addSubviews() {
        
        // 页码
        numberPageLabel = UILabel()
        numberPageLabel.textColor = UIColor.blackColor()
        numberPageLabel.font = UIFont.fontOfSize(12)
        numberPageLabel.textAlignment = .Left
        addSubview(numberPageLabel)
        
        // 时间label
        timeLabel = UILabel()
        timeLabel.textColor = UIColor.blackColor()
        timeLabel.font = UIFont.fontOfSize(12)
        timeLabel.textAlignment = .Right
        addSubview(timeLabel)
        
        // 电池
        batteryView = BatteryView()
        addSubview(batteryView)
        
        // 添加定时器获取时间
        addTimer()
        didChangeTime()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let h = SpaceTwo
        
        // 页码
        let numberPageLabelW:CGFloat = width/2
        numberPageLabel.frame = CGRectMake(SpaceTwo, (height - h)/2, width/2, h)
        
        // 时间
        let timeLabelW:CGFloat = width - numberPageLabelW - 2 * BatterySize.width - SpaceThree
        timeLabel.frame = CGRectMake(CGRectGetMaxX(numberPageLabel.frame), (height - h)/2, timeLabelW, h)
        
        // 电池
        batteryView.frame.origin = CGPointMake(CGRectGetMaxX(timeLabel.frame) + SpaceThree, (height - BatterySize.height)/2)
        
    }
    
    // MARK: -- 时间相关
    
    func addTimer() {
        
        if timer == nil {
            
            timer = NSTimer.scheduledTimerWithTimeInterval(30, target: self, selector: #selector(ReadBottomStatusView.didChangeTime), userInfo: nil, repeats: true)
            
            NSRunLoop.currentRunLoop().addTimer(timer!, forMode: NSRunLoopCommonModes)
        }
    }
    
    func removeTimer() {
        
        if timer != nil {
            
            timer!.invalidate()
            
            timer = nil
        }
    }
    
    /// 时间变化
    func didChangeTime() {
        
        batteryView.batteryLevel = UIDevice.currentDevice().batteryLevel
        
        timeLabel.text = GetCurrentTimerString("HH:mm")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        
        removeTimer()
    }
}
