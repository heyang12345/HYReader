//
//  ReadLeftViewCell.swift
//  Reader
//
//  Created by 千锋 on 16/11/2.
//  Copyright © 2016年 heyang. All rights reserved.
//



import UIKit

class ReadLeftViewCell: UITableViewCell {
    
    /// 分割线
    var spaceLine:UIView!
    
    class func cellWithTableView(tableView:UITableView) ->ReadLeftViewCell {
        
        let ID = "ReadLeftViewCell"
        
        var cell = tableView.dequeueReusableCellWithIdentifier(ID) as? ReadLeftViewCell
        
        if (cell == nil) {
            
            cell = ReadLeftViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: ID);
        }
        
        return cell!
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        textLabel?.font = UIFont.fontOfSize(16)
        
        selectionStyle = UITableViewCellSelectionStyle.None
        
        addSubViews()
    }
    
    func addSubViews() {
        
        // 分割线
        spaceLine = SpaceLineSetup(contentView, color: Color_6)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        spaceLine.frame = CGRectMake(0, height - SpaceLineHeight, width, SpaceLineHeight)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
