//
//  ReadTopStatusViewH.swift
//  Reader
//
//  Created by 千锋 on 16/11/2.
//  Copyright © 2016年 heyang. All rights reserved.
//



let ReadTopStatusViewH:CGFloat = 30

import UIKit

class ReadTopStatusView: UIView {
    
    // leftTitle
    private var leftTitle:UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.clearColor()
        
        addSubviews()
    }
    
    
    /**
     设置头部标题
     
     - parameter title: 标题
     */
    func setLeftTitle(title:String?) {
        
        self.leftTitle.text = title
    }
    
    
    func addSubviews() {
        
        // leftTitle
        leftTitle = UILabel()
        leftTitle.textColor = ReadTextColor
        leftTitle.font = UIFont.fontOfSize(12)
        leftTitle.textAlignment = .Left
        addSubview(leftTitle)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        leftTitle.frame = CGRectMake(SpaceTwo, 0, width - 2*SpaceTwo, height)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
