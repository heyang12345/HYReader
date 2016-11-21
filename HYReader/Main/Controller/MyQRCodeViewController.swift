
//
//  MyQRCodeViewController.swift
//  HYReader
//
//  Created by 千锋 on 16/11/5.
//  Copyright © 2016年 heyang. All rights reserved.
///Users/qianfeng/Desktop/HYReader/HYReader/Main/Controller/MyQRCodeViewController.swift

import UIKit
import swiftScan
class MyQRCodeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor ( red: 0.4108, green: 0.4247, blue: 0.4094, alpha: 1.0 )
        
        let qrCodeView = UIImageView.init()
        qrCodeView.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(qrCodeView)
        qrCodeView.snp_makeConstraints { (make) in
            make.centerX.equalTo(0)
            make.top.equalTo(100)
            make.width.height.equalTo(300)
        }
        //生成二维码
        let qrImage = LBXScanWrapper.createCode("CIQRCodeGenerator", codeString: "https://www.baidu.com", size: CGSizeMake(300, 300), qrColor: UIColor ( red: 0.9991, green: 0.6432, blue: 0.5812, alpha: 1.0 ), bkColor: UIColor.whiteColor())
        qrCodeView.image = qrImage
        
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
