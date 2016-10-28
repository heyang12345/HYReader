//
//  LoginViewController.swift
//  HYReader
//
//  Created by 千锋 on 16/10/27.
//  Copyright © 2016年 heyang. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.whiteColor()
        self.title = "登录"
        //用户名
        let userName = UITextField.init()
        userName.placeholder = "请输入用户名"
        userName.backgroundColor =  UIColor.whiteColor()
        userName.font = UIFont.systemFontOfSize(15)
        userName.textColor = UIColor ( red: 0.6283, green: 0.6283, blue: 0.6283, alpha: 1.0 )
        userName.layer.cornerRadius = 8
        userName.layer.masksToBounds = true
        userName.layer.borderWidth = 1.0
        self.view.addSubview(userName)
        userName.snp_makeConstraints { (make) in
            make.top.equalTo(100)
            make.left.right.equalTo(10)
            make.left.height.equalTo(48)
        }
        //密码
        let password = UITextField.init()
        password.placeholder = "请输入用户密码"
        password.font = UIFont.systemFontOfSize(15)
        password.backgroundColor = UIColor.whiteColor()
        password.textColor = UIColor ( red: 0.6283, green: 0.6283, blue: 0.6283, alpha: 1.0 )
        password.layer.cornerRadius = 12
        password.layer.masksToBounds = true
        password.layer.borderWidth = 1.0
        self.view.addSubview(password)
        password.snp_makeConstraints { (make) in
            make.top.equalTo(userName.snp_bottom).offset(10)
            make.left.right.equalTo(8)
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
            make.size.equalTo(CGPointMake(48, 48))
        }
        passImage.snp_makeConstraints { (make) in
            make.center.equalTo(0)
        }
        //显示
        password.secureTextEntry = true
        
        //忘记密码
        let forgetPass = UIButton.init(type: .Custom)
        forgetPass.setTitle("忘记密码?", forState: .Normal)
        forgetPass.titleLabel?.font = UIFont.systemFontOfSize(15)
        forgetPass.setTitleColor(UIColor ( red: 0.9019, green: 0.5133, blue: 0.593, alpha: 1.0 ), forState: .Normal)
        self.view.addSubview(forgetPass)
        forgetPass.snp_makeConstraints { (make) in
            make.top.equalTo(password.snp_bottom).offset(5)
            make.right.equalTo(2)
            make.height.equalTo(56)
            make.width.equalTo(72)
        }
        forgetPass.jk_handleControlEvents(UIControlEvents.TouchUpInside) { (sender) in
            
        }
        //登录按钮
        let loginButton = UIButton.init(type: .Custom)
        loginButton.setTitle("登录", forState: .Normal)
        loginButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        loginButton.titleLabel?.font = UIFont.systemFontOfSize(20)
        self.view.addSubview(loginButton)
        loginButton.snp_makeConstraints { (make) in
            make.top.equalTo(forgetPass).offset(30)
            make.right.left.equalTo(8)
            make.height.equalTo(48)
        }
        loginButton.jk_setBackgroundColor(UIColor ( red: 0.1941, green: 1.0, blue: 0.971, alpha: 1.0 ), forState: .Normal)
        loginButton.jk_setBackgroundColor(UIColor.grayColor(), forState: .Disabled)
        loginButton.jk_setBackgroundColor(UIColor.darkGrayColor(), forState: .Highlighted)
        //按钮的点击事件
        loginButton.jk_handleControlEvents(UIControlEvents.TouchUpInside) { (sender) in
            
        }
        //注册按钮
        let registerButton = UIButton.init(type: .Custom)
        registerButton.setTitle("注册", forState: .Normal)
        registerButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        registerButton.titleLabel?.font = UIFont.systemFontOfSize(20)
        self.view.addSubview(registerButton)
        registerButton.snp_makeConstraints { (make) in
            make.top.equalTo(loginButton.snp_bottom).offset(10)
            make.left.right.equalTo(8)
            make.height.equalTo(48)
        }
        registerButton.jk_setBackgroundColor(UIColor ( red: 0.1941, green: 1.0, blue: 0.971, alpha: 1.0 ), forState: .Normal)
        registerButton.jk_setBackgroundColor(UIColor.grayColor(), forState: .Disabled)
        registerButton.jk_setBackgroundColor(UIColor.darkGrayColor(), forState: .Highlighted)
        //按钮的点击事件
        registerButton.jk_handleControlEvents(UIControlEvents.TouchUpInside) { (sender) in
            
            let registerVC = RegisterViewController.init()
            
           self.presentViewController(registerVC, animated: true, completion: nil)
            
        }

        
        
        
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
