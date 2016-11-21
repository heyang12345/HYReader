//
//  BookrackCell.swift
//  HYReader
//
//  Created by 千锋 on 16/10/31.
//  Copyright © 2016年 heyang. All rights reserved.
//

import UIKit

class BookrackCell: UICollectionViewCell {
    
    var mask = UIView.init()
    var imageView = UIImageView.init()
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView.frame = CGRectMake(10, 5, 90, 129)
        self.contentView.addSubview(imageView)
        
        imageView.snp_makeConstraints { (make) in
            make.edges.equalTo(0)
        }
        self.contentView.addSubview(mask)
        mask.backgroundColor = UIColor ( red: 0.1676, green: 0.1676, blue: 0.1676, alpha: 0.66 )
        mask.alpha = 0
        mask.snp_makeConstraints { (make) in
            make.edges.equalTo(0)
        }

    }
    override var highlighted: Bool{
        didSet{
            UIView.animateWithDuration(0.25) {
                self.mask.alpha = CGFloat(self.highlighted)
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
