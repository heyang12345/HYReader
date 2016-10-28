//
//  ViewController.swift
//  HYReader
//
//  Created by 千锋 on 16/10/27.
//  Copyright © 2016年 heyang. All rights reserved.
//
/*
 my-default-avatar~iphone
 my-arrow~iphone@3x
 我的消息~iphone@3x
 my-充值~iphone@3x
 我的vip~iphone@3x
 
 
 
 */
import UIKit
import WPAttributedMarkup
class MenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.whiteColor()
        //创建顶部视图
        configureTopInfo()
    }
    //创建顶部视图
    func configureTopInfo(){
       //创建背景UIview
        let topView = UIView.init()
        topView.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(topView)
        topView.snp_makeConstraints { (make) in
            make.top.equalTo(24)
            make.left.right.equalTo(0)
            make.height.equalTo(300)
        }
        
        
        //创建顶部UIview
        let titleView = UIView.init()
        titleView.backgroundColor = UIColor.whiteColor()
        topView.addSubview(titleView)
        topView.snp_makeConstraints { (make) in
            make.top.equalTo(topView.snp_bottom).offset(10)
            make.left.right.equalTo(0)
            make.height.equalTo(60)
        }
        //右视图
        let headImage = UIImageView.init()
        headImage.image = UIImage.init(named: "my-default-avatar~iphone")
        // 裁减圆角图片
        headImage.layer.cornerRadius = 12
        headImage.layer.masksToBounds = true
        titleView.addSubview(headImage)
        headImage.snp_makeConstraints { (make) in
            make.left.equalTo(8)
            make.height.width.equalTo(36)
            make.center.equalTo(0)
        }
        //Label
        let idLabel = UILabel.init()
        idLabel.text = "i1049150138(游客状态)"
        idLabel.font = UIFont.systemFontOfSize(13)
        titleView.addSubview(idLabel)
        idLabel.snp_makeConstraints { (make) in
            make.left.equalTo(headImage.snp_left).offset(4)
                make.top.equalTo(10)
        }
        let Label1 = UILabel.init()
        Label1.text = "登陆后保存资产和阅读记录"
        Label1.font = UIFont.systemFontOfSize(10)
        Label1.textColor = UIColor ( red: 0.6222, green: 0.6222, blue: 0.6222, alpha: 1.0 )
        titleView.addSubview(Label1)
        idLabel.snp_makeConstraints { (make) in
            make.left.equalTo(headImage.snp_left).offset(4)
            make.top.equalTo(idLabel.snp_bottom).offset(2)
        }
        //右边图片
        let rightImage = UIImageView.init()
        rightImage.image = UIImage.init(named: "my-arrow~iphone@3x")
        titleView.addSubview(rightImage)
        rightImage.snp_makeConstraints { (make) in
            make.right.equalTo(8)
            make.top.equalTo(20)
        }
        let titleTap = UITapGestureRecognizer(target: self, action: "tapAction:")

        
        
        
        
        
        //label
        //label
        //imageView

        
        
        
        
        
        
//         时间
//        let headLabel = UILabel.init()
//        topView.addSubview(headLabel)
//        headLabel.snp_makeConstraints { (make) in
//            make.top.equalTo(6)
//            make.left.right.equalTo(5)
//            make.height.equalTo(60)
//        }
//        
//        // 以 html 的语法来设置 label 中内容的样式
//        // 样式表是以字典的形式设置的
//        // key 是随意写的，值就是对应的样式，只需要用 key 将内容包含起来就可以了
//        let style : [NSString: AnyObject] = [
//            "clock": UIImage.init(named: "时间图标")!,
//            "fontColor": UIColor.lightGrayColor(),
//            "fontSize": UIFont.systemFontOfSize(13)
//        ]
//        let timeStr : NSString = "<clock> </clock> <fontColor><fontSize>一天</fontSize></fontColor>"
//        timeLabel.attributedText = timeStr.attributedStringWithStyleBook(style)

        
    }
    func tapAction(tap:UITapGestureRecognizer){
        let loginVC = LoginViewController()
        self.presentViewController(loginVC, animated: true, completion: nil)
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
