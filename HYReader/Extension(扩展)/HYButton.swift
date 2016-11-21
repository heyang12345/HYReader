//
//  HYBUtton.swift
//  HYReader
//
//  Created by 千锋 on 16/11/4.
//  Copyright © 2016年 heyang. All rights reserved.
//

import UIKit

class HYButton: UIButton {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    //重写imageView的位置
    override func imageRectForContentRect(contentRect: CGRect) -> CGRect {
        //调用父类的imageView
        let imageRect = super.imageRectForContentRect(contentRect)
        //返回imageView的位置和大小
        return CGRectMake((contentRect.size.width - (imageRect.size.width)
            ) / 2, 8, (imageRect.size.width), (imageRect.size.height))
    }
    //重写title的位置和大小
    override func titleRectForContentRect(contentRect: CGRect) -> CGRect {
        
        let imageRect = super.imageRectForContentRect(contentRect)
        let titleRect = super.titleRectForContentRect(contentRect)
        
        return CGRectMake((contentRect.size.width - (titleRect.size.width)) / 2, (imageRect.size.height) + 16, (titleRect.size.width), (titleRect.size.height))
    }
    
}
