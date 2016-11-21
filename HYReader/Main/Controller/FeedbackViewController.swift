//
//  FeedbackViewController.swift
//  HYReader
//
//  Created by 千锋 on 16/11/6.
//  Copyright © 2016年 heyang. All rights reserved.
//

import UIKit
import CoreTelephony
import MessageUI
class FeedbackViewController: UIViewController {
    
    var feedback = UITextField.init()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.whiteColor()
       
        //短信按钮
        let smsBtn = UIButton.init(type: .Custom)
        smsBtn.jk_setBackgroundColor(UIColor ( red: 0.2578, green: 0.5026, blue: 0.7727, alpha: 1.0 ), forState: .Normal)
        smsBtn.jk_setBackgroundColor(UIColor.grayColor(), forState: .Disabled)
        smsBtn.jk_setBackgroundColor(UIColor.lightGrayColor(), forState: .Highlighted)
        smsBtn.setTitle("发短信联系我们", forState: .Normal)
        self.view.addSubview(smsBtn)
        smsBtn.snp_makeConstraints { (make) in
            make.top.equalTo(100)
            make.left.equalTo(8)
            make.right.equalTo(-8)
            make.height.equalTo(40)
        }
        smsBtn.jk_handleControlEvents(UIControlEvents.TouchUpInside) { (sender) in
            let messageV = MFMessageComposeViewController.init()
            messageV.body = self.feedback.text
            messageV.recipients = ["15238978986"]
            //设置代理
            messageV.messageComposeDelegate = self
            messageV.fd_interactivePopDisabled = true
            messageV.fd_viewControllerBasedNavigationBarAppearanceEnabled = true
            self.presentViewController(messageV, animated: true, completion: nil)
        }
        //短信按钮
        let callBtn = UIButton.init(type: .Custom)
        callBtn.jk_setBackgroundColor(UIColor ( red: 0.2578, green: 0.5026, blue: 0.7727, alpha: 1.0 ), forState: .Normal)
        callBtn.jk_setBackgroundColor(UIColor.grayColor(), forState: .Disabled)
        callBtn.jk_setBackgroundColor(UIColor.lightGrayColor(), forState: .Highlighted)
        callBtn.setTitle("打电话联系我们", forState: .Normal)
        self.view.addSubview(callBtn)
        callBtn.snp_makeConstraints { (make) in
            make.top.equalTo(smsBtn.snp_bottom).offset(20)
            make.left.equalTo(8)
            make.right.equalTo(-8)
            make.height.equalTo(40)
        }
        callBtn.jk_handleControlEvents(UIControlEvents.TouchUpInside) { (sender) in
            let webView = UIWebView.init()
            self.view.addSubview(webView)
            webView.loadRequest(NSURLRequest.init(URL: NSURL.init(string: "tel://15238978986")!))
            
            }
        
        //让键盘下去
       // self.view.endEditing(true)
        
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
extension FeedbackViewController:MFMessageComposeViewControllerDelegate{
    func messageComposeViewController(controller: MFMessageComposeViewController, didFinishWithResult result: MessageComposeResult) {
        //无论成功还是失败，经控制器弹下去
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
}
