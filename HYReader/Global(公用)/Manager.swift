
//
//  Manager.swift
//  Reader
//
//  Created by 千锋 on 16/11/1.
//  Copyright © 2016年 heyang. All rights reserved.
//

import UIKit

class Manager:NSObject{
    //获取单利对象
    class var shareManager:Manager{
        struct Static {
            static let instance:Manager = Manager()
        }
        return Static.instance
    }
    //当前正在显示 的控制器
    weak var displayController:UIViewController?
}
