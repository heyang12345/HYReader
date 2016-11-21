//
//  ScanViewController.swift
//  HYReader
//
//  Created by 千锋 on 16/11/6.
//  Copyright © 2016年 heyang. All rights reserved.
//

import UIKit
import swiftScan
class ScanViewController: LBXScanViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //扫描嘛线条
        self.scanStyle?.animationImage = UIImage.init(named: "横线 3")
        //四个角颜色
        self.scanStyle?.colorAngle = UIColor ( red: 0.6112, green: 1.0, blue: 0.3528, alpha: 1.0 )
        //四个角的位置
        self.scanStyle?.photoframeAngleStyle = LBXScanViewPhotoframeAngleStyle.Inner
        //巨型区域中心上移
        self.scanStyle?.centerUpOffset = 44
        //边框颜色
        self.scanStyle?.colorRetangleLine = UIColor.whiteColor()
        //动画类型
        self.scanStyle?.anmiationStyle = LBXScanViewAnimationStyle.NetGrid
       
        //处理扫描结果
        //scanVC.handleCodeResult(results)
    }
    override func handleCodeResult(arrayResult: [LBXScanResult]) {
        //print(arrayResult)
        // 在这里根据扫描到的不同结果，做不同的处理
        // 比如如果扫到一个网站，跳转到网站
        // 如果扫到的是用户的信息，就加对方为好友
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
