//
//  RegisterViewController.swift
//  HYReader
//
//  Created by 千锋 on 16/10/28.
//  Copyright © 2016年 heyang. All rights reserved.
//

import UIKit
import ReactiveCocoa

class RegisterViewController: UIViewController {
    dynamic var time = -1
    var timer:NSTimer!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.barTintColor = UIColor ( red: 0.1412, green: 0.9647, blue: 0.9294, alpha: 1.0 )
        self.title = "新用户注册"
        //用户名
        let userName = UITextField.init()
        userName.placeholder = "请输入用户名"
        userName.backgroundColor =  UIColor.whiteColor()
        userName.font = UIFont.systemFontOfSize(15)
        userName.textColor = UIColor ( red: 0.6283, green: 0.6283, blue: 0.6283, alpha: 1.0 )
        userName.layer.cornerRadius = 4
        userName.layer.masksToBounds = true
        userName.layer.borderWidth = 1.0
        self.view.addSubview(userName)
        userName.snp_makeConstraints { (make) in
            make.top.equalTo(100)
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.left.height.equalTo(48)
        }
        //密码
        let password = UITextField.init()
        password.placeholder = "请设置用户密码"
        password.font = UIFont.systemFontOfSize(15)
        password.backgroundColor = UIColor.whiteColor()
        password.textColor = UIColor ( red: 0.6283, green: 0.6283, blue: 0.6283, alpha: 1.0 )
        password.layer.cornerRadius = 4
        password.layer.masksToBounds = true
        password.layer.borderWidth = 1.0
        self.view.addSubview(password)
        password.snp_makeConstraints { (make) in
            make.top.equalTo(userName.snp_bottom).offset(10)
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.height.equalTo(48)
        }
        //用户左边图标
        let nameLeft = UIView.init()
        let nameImage = UIImageView.init()
        nameImage.image = UIImage.init(named: "用户图标")
        nameLeft.addSubview(nameImage)
        userName.leftView = nameLeft
        //是否显示图标
        userName.leftViewMode = .Always
        nameLeft.snp_makeConstraints { (make) in
            make.size.equalTo(CGSizeMake(48, 48))
        }
        nameImage.snp_makeConstraints { (make) in
            make.center.equalTo(0)
        }
        //密码左边图标
        let passLeft = UIView.init()
        let passImage = UIImageView.init()
        passImage.image = UIImage.init(named:"密码图标")
        passLeft.addSubview(passImage)
        password.leftView = passLeft
        password.leftViewMode = .Always
        passLeft.snp_makeConstraints { (make) in
            make.size.equalTo(CGSizeMake(48, 48))
        }
        passImage.snp_makeConstraints { (make) in
            make.center.equalTo(0)
        }
        //显示
        password.secureTextEntry = true
        
        let code = UITextField.init()
        code.font = UIFont.systemFontOfSize(15)
        code.placeholder = "输入验证码"
        code.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(code)
        code.snp_makeConstraints { (make) in
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.top.equalTo(password.snp_bottom).offset(16)
            make.height.equalTo(48)
        }
        //验证码输入框
        let codeLeft = UIView.init()
        let codeLeftImage = UIImageView.init(image: UIImage.init(named: "验证信息图标"))
        code.leftView = codeLeft
        code.leftViewMode = UITextFieldViewMode.Always
        code.layer.cornerRadius = 4
        code.layer.masksToBounds = true
        code.layer.borderWidth = 1.0
        codeLeft.addSubview(codeLeftImage)
        codeLeftImage.snp_makeConstraints { (make) in
            make.center.equalTo(0)
        }
        codeLeft.snp_makeConstraints { (make) in
            make.size.equalTo(CGSizeMake(42, 42))
        }
        //获取验证码按钮
        let codeRight = UIView.init()
        let codeRightBtn = UIButton.init(type: UIButtonType.Custom)
        codeRightBtn.setTitle("获取验证码", forState: UIControlState.Normal)
        codeRightBtn.titleLabel?.font = UIFont.systemFontOfSize(13)
        codeRightBtn.setTitleColor(UIColor.greenColor(), forState: UIControlState.Normal)
        codeRightBtn.layer.borderColor = UIColor.lightGrayColor().CGColor
        codeRightBtn.layer.borderWidth = 1.0
        // 设置视图的圆角
        codeRightBtn.layer.cornerRadius = 3.0
        // 设置让背景颜色范围在视图范围内
        codeRightBtn.layer.masksToBounds = true
        codeRightBtn.jk_setBackgroundColor(UIColor.lightGrayColor(), forState: UIControlState.Disabled)
        codeRightBtn.jk_setBackgroundColor(UIColor.darkGrayColor(), forState: UIControlState.Highlighted)
        codeRightBtn.jk_setBackgroundColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        
        code.rightView = codeRight
        code.rightViewMode = UITextFieldViewMode.Always
        codeRight.snp_makeConstraints { (make) in
            make.height.equalTo(48)
            make.width.equalTo(120)
        }
        codeRight.addSubview(codeRightBtn)
        codeRightBtn.snp_makeConstraints { (make) in
            make.center.equalTo(0)
            make.right.equalTo(-8)
            make.top.equalTo(4)
        }
        codeRightBtn.jk_handleControlEvents(UIControlEvents.TouchUpInside) { (sender) in
            
            self.time = 5
            SMSSDK.getVerificationCodeByMethod(SMSGetCodeMethod.init(0), phoneNumber: userName.text, zone: "86", customIdentifier: nil, result: { (error) in
                //采用监控的方式，去改变按钮的状态
                self.timer = NSTimer.jk_scheduledTimerWithTimeInterval(1.0, block: { 
                    self.time = self.time-1
                    }, repeats:true) as! NSTimer
            })
            
        }
       
        
        
        //返回按钮
        let backButton = UIBarButtonItem(image: UIImage.init(named: "返回-ipad~iphone"), style: .Plain, target: self, action: #selector(RegisterViewController.backAction))
    
        self.navigationItem.leftBarButtonItem = backButton
        //注册按钮
        let registerButton = UIButton.init(type: .Custom)
        registerButton.setTitle("注册", forState: .Normal)
        registerButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        registerButton.titleLabel?.font = UIFont.systemFontOfSize(20)
        self.view.addSubview(registerButton)
        registerButton.snp_makeConstraints { (make) in
            make.top.equalTo(code.snp_bottom).offset(15)
            make.left.equalTo(8)
            make.right.equalTo(-8)
            make.height.equalTo(48)
        }
        registerButton.jk_setBackgroundColor(UIColor ( red: 0.1941, green: 1.0, blue: 0.971, alpha: 1.0 ), forState: .Normal)
        registerButton.jk_setBackgroundColor(UIColor.grayColor(), forState: .Disabled)
        registerButton.jk_setBackgroundColor(UIColor.darkGrayColor(), forState: .Highlighted)
        //按钮的点击事件
        registerButton.jk_handleControlEvents(UIControlEvents.TouchUpInside) { (sender) in
            
            NetHelp.request(parameters:
                ["service":"user.Register",
                    "phone":userName.text!,
                    "password":(password.text! as NSString).jk_md5String,
                    "vericationCode":code.text!,
                ])
            .responseJSON({ (data, success) in
                if success{
                    self.navigationController?.popViewControllerAnimated(true)
                }else{
                    NetHelp.showAlertMsg("注册失败", onViewController: self)
                }
            })
            
        
        }
        codeRightBtn.enabled = false
        registerButton.enabled = false
        //用rac订阅输入框改变的信号，根据输入的内容，改变按钮的状态
        userName.rac_textSignal().subscribeNext { (sender) in
            let name = sender as! NSString
            codeRightBtn.enabled = name.length == 11 && self.time == -1

        }
        //将几个信号合并为一个信号，订阅并改变注册按钮的状态 (代替 delegate)
        userName.rac_textSignal().combineLatestWith(password.rac_textSignal()).combineLatestWith(code.rac_textSignal()).subscribeNext { (sender) in
            registerButton.enabled = ((userName.text! as NSString).length == 11 && (password.text! as NSString).length >= 6 && (code.text! as NSString).length == 4)
        }
        // 将变量的改变当做信号来订阅(代替 kvo)
        // 使用 MVC 的思想，如果数据改变了，界面跟着变
        self.rac_valuesForKeyPath("time", observer: self).subscribeNext { (time) in
            
            code.enabled = self.time == -1
            if self.time == -1 {
                codeRightBtn.setTitle("获取验证码", forState: .Normal)
                if self.timer != nil {
                    self.timer.invalidate()
                }
            }else{
                codeRightBtn.setTitle("还剩\(self.time)秒", forState: .Normal)
            }
        }

        
    }
    func backAction(){
        self.navigationController?.popViewControllerAnimated(true)
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
