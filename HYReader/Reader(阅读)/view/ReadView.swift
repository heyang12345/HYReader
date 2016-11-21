//
//  ReadView.swift
//  Reader
//
//  Created by 千锋 on 16/11/2.
//  Copyright © 2016年 heyang. All rights reserved.
//



import UIKit

class ReadView: UIView {
    
    /// 当前文字
    var content:String!
    
    /// 当前视图文字
    var frameRef:CTFrameRef? {
        
        didSet{
            
            setNeedsDisplay()
        }
    }
    
    override func drawRect(rect: CGRect) {
        
        if (frameRef == nil) {
            
            return
        }
        
        let ctx = UIGraphicsGetCurrentContext()
        CGContextSetTextMatrix(ctx, CGAffineTransformIdentity)
        CGContextTranslateCTM(ctx, 0, self.bounds.size.height);
        CGContextScaleCTM(ctx, 1.0, -1.0);
        CTFrameDraw(frameRef!, ctx!);
    }
    
}
