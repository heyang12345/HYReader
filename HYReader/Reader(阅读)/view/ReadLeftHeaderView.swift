//
//  ReadLeftHeaderView.swift
//  Reader
//
//  Created by 千锋 on 16/11/2.
//  Copyright © 2016年 heyang. All rights reserved.
//



import UIKit

class ReadLeftHeaderView: UIView {
    
    /// title
    private var textLabel:UILabel!
    
    /// 分割线
    private var spaceLine:UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.whiteColor()
        
        addSubviews()
    }
    
    func addSubviews() {
        
        // title
        textLabel = UILabel()
        textLabel.text = "全部章节"
        textLabel.textColor = Color_4
        textLabel.font = UIFont.fontOfSize(10)
        addSubview(textLabel)
        
        // 分割线
        spaceLine = SpaceLineSetup(self, color: Color_6)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        textLabel.frame = CGRectMake(18, 10, 50, 15)
        
        spaceLine.frame = CGRectMake(0, height - SpaceLineHeight, width, SpaceLineHeight)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
