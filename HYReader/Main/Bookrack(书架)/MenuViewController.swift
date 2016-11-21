//
//  MenuViewController.swift
//  HYReader
//
//  Created by 千锋 on 16/10/29.
//  Copyright © 2016年 heyang. All rights reserved.
//

import UIKit
import WPAttributedMarkup
import swiftScan
import OpenShare
class MenuViewController: UIViewController {
    

    let tableView1 = UITableView.init()
    let tableView2 = UITableView.init()
    var bgView  = UIView.init()
    var tapFlag = false
    
    let cellInfos1  = [
        [
            "title":"我的消息",
            "image":"我的消息~iphone"
        ],
        [
            "title":"个人信息",
            "image":"个人信息"
        ],
        [
            "title":"我的VIP",
            "image":"我的vip~iphone"
        ],
       
    ]

    let cellInfos2 = [
        [
            "title":"阅读器丰收季",
            "image":"结果-打开阅读"
        ],
        [
            "title":"帮助与反馈",
            "image":"结果-打开阅读"
           
        ],

        [
            "title":"活动中心",
            "image":"结果-打开阅读"
        ],

        [
            "title":"推荐给小伙伴",
           "image":"结果-打开阅读"
        ],

        [
            "title":"扫一扫",
            "image":"结果-打开阅读"
        ],

        

    ]
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.whiteColor()
        //创建上面tableView
        prepareTableView()
        
        
    }
    func prepareTableView(){
        
        
        //创建背景UIview
        let topView = UIView.init()
        topView.backgroundColor = UIColor.whiteColor()
        topView.frame = CGRectMake(0, 20,self.view.bounds.width, 70)
        //加点击手势
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(MenuViewController.tapAction1(_:)))
        topView.addGestureRecognizer(tap1)
        //右视图
        let headImage = UIImageView.init()
        headImage.image = UIImage.init(named: "my-default-avatar~iphone")
        // 裁减圆角图片
        headImage.layer.cornerRadius = 16
        headImage.layer.masksToBounds = true
        topView.addSubview(headImage)
        headImage.snp_makeConstraints { (make) in
            make.top.equalTo(32)
            make.left.equalTo(8)
            make.height.width.equalTo(36)
        }
        let idLabel = UILabel.init()
        
        idLabel.textColor = UIColor.blackColor()
        idLabel.font = UIFont.systemFontOfSize(16)
        topView.addSubview(idLabel)
        idLabel.snp_makeConstraints { (make) in
            make.left.equalTo(headImage.snp_right).offset(8)
            make.height.equalTo(20)
            make.top.equalTo(headImage)
        }
        idLabel.text = "i1049150138(游客状态)"
    
        let Label1 = UILabel.init()
        Label1.textColor = UIColor ( red: 0.6853, green: 0.6853, blue: 0.6853, alpha: 1.0 )
        Label1.font = UIFont.systemFontOfSize(12)
        topView.addSubview(Label1)
        Label1.snp_makeConstraints { (make) in
            make.left.equalTo(headImage.snp_right).offset(8)
            make.top.equalTo(idLabel.snp_bottom)
            make.height.equalTo(20)
           
        }
         Label1.text = "登陆后保存资产和阅读记录"
        //右边图片
        let rightImage = UIImageView.init()
        rightImage.image = UIImage.init(named: "broswerForward~iphone")
        topView.addSubview(rightImage)
        rightImage.snp_makeConstraints { (make) in
            make.right.equalTo(-8)
            make.top.equalTo(20)
        }

        tableView1.tableHeaderView = topView
        //设置分隔线的颜色
        //tableView?.separatorColor = UIColor.redColor()
        
        //取消cell之间的线条设置分隔的风格
        self.tableView1.separatorStyle = UITableViewCellSeparatorStyle.None

        tableView1.delegate = self
        tableView1.dataSource = self
        tableView1.tag = 100
        self.view.addSubview(tableView1)
        tableView1.snp_makeConstraints { (make) in
            make.top.equalTo(0)
            make.left.right.equalTo(0)
            make.height.equalTo(300)
        }
        tableView1.scrollEnabled = false
        tableView1.registerClassOf(UITableViewCell)
        
        
        
        tableView2.delegate = self
        tableView2.dataSource = self
        tableView2.tag = 200
        self.view.addSubview(tableView2)
        tableView2.snp_makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.top.equalTo(tableView1.snp_bottom)
            make.bottom.equalTo(-50)
        }
        tableView2.registerClassOf(UITableViewCell)
        //设置按钮
        let leftView = UIView.init()
        leftView.userInteractionEnabled = true
        self.view.addSubview(leftView)
        let tap = UITapGestureRecognizer(target: self, action: #selector(MenuViewController.tapAction(_:)))
        leftView.addGestureRecognizer(tap)
        self.view.addSubview(leftView)
        leftView.layer.borderWidth = 0.5
        leftView.snp_makeConstraints { (make) in
            make.left.equalTo(0)
            make.bottom.equalTo(0)
            make.height.equalTo(40)
            make.width.equalTo(view.bounds.size.width/2-40)
        }
        let setLabel = UILabel.init()
         leftView.addSubview(setLabel)
         setLabel.snp_makeConstraints { (make) in
        
            make.center.equalTo(0)
            
        }
        // 以 html 的语法来设置 label 中内容的样式
        // 样式表是以字典的形式设置的
        // key 是随意写的，值就是对应的样式，只需要用 key 将内容包含起来就可以了
        let style : [NSString: AnyObject] = [
            "clock": UIImage.init(named: "侧边栏设置icon~iphone")!,
            "fontColor": UIColor.lightGrayColor(),
            "fontSize": UIFont.systemFontOfSize(16),
            
        ]
        let setStr : NSString = "<clock> </clock> <fontColor><fontSize>设置</fontSize></fontColor>"
        setLabel.attributedText = setStr.attributedStringWithStyleBook(style)
        //夜间按钮
        let rightView = UIView.init()
        self.view.addSubview(rightView)
        rightView.userInteractionEnabled = true
        let tap2 = UITapGestureRecognizer(target: self, action:#selector(MenuViewController.tapAction2(_:)))
        
        rightView.addGestureRecognizer(tap2)
        rightView.layer.borderWidth = 0.5
        rightView.snp_makeConstraints { (make) in
            make.left.equalTo(leftView.snp_right)
            make.bottom.equalTo(0)
            make.height.equalTo(40)
            make.width.equalTo(view.bounds.size.width/2-leftView.bounds.width)
        }
        let nightLabel = UILabel.init()
        rightView.addSubview(nightLabel)
        nightLabel.snp_makeConstraints { (make) in
            
            make.center.equalTo(0)
            
        }
        
        let style1 : [NSString: AnyObject] = [
            "clock": UIImage.init(named: "夜间~iphone")!,
            "fontColor": UIColor.lightGrayColor(),
            "fontSize": UIFont.systemFontOfSize(16),
            
            ]
        let setStr1 : NSString = "<clock> </clock> <fontColor><fontSize>夜间</fontSize></fontColor>"
        nightLabel.attributedText = setStr1.attributedStringWithStyleBook(style1)

    }
    //登录注册点击手势
    func tapAction1(tap:UITapGestureRecognizer){
        
        let loginVC = LoginViewController.init()
        let applocation = UIApplication.sharedApplication()
        let appDelegate = applocation.delegate! as! AppDelegate
        let mmDav = appDelegate.mmDrawerVC
        mmDav?.navigationController?.pushViewController(loginVC, animated: true)
        mmDav?.navigationController?.navigationBar.hidden = false
    
    }

    //设置手势相应方法
    func tapAction(tap:UITapGestureRecognizer){
        
        let settingVC = SettingViewController.init()

        //首先去获取UIApplication这个类的单例对象
        let application = UIApplication.sharedApplication()
        
        //这个类中有一个delegate属性，这个属性保存是 AppDelegate类的对象
        let appDelegate = application.delegate! as! AppDelegate
        
        let mmDav = appDelegate.mmDrawerVC
        
        mmDav?.navigationController?.pushViewController(settingVC, animated: true)
        mmDav?.navigationController?.navigationBar.hidden = false
    
    }
    //夜间
    func tapAction2(tap:UITapGestureRecognizer){
        
        let window = UIApplication.sharedApplication().keyWindow
        bgView.backgroundColor = UIColor.blackColor()
        bgView.frame = UIScreen.mainScreen().bounds
        if tapFlag {
            bgView.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0)
            tapFlag = false
        }else{
            bgView.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.5)
            tapFlag = true
        }
        bgView.userInteractionEnabled = false
        window?.addSubview(bgView)

       
    }


    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        //首先去获取UIApplication这个类的单例对象
        let application = UIApplication.sharedApplication()
        //这个类中有一个delegate属性，这个属性保存是 AppDelegate类的对象
        let appDelegate = application.delegate! as! AppDelegate
        let mmDav = appDelegate.mmDrawerVC
        mmDav?.navigationController?.navigationBar.hidden = true
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
extension MenuViewController:UITableViewDataSource,UITableViewDelegate{
    
    
    //返回分区行数
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tableView1 {
            return self.cellInfos1.count
        }else{
            return self.cellInfos2.count
        }
        
        
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    
    //
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if tableView == tableView1{
        let cell = tableView.dequeueReusableCell()
        cell.textLabel?.font = UIFont.systemFontOfSize(15)
        cell.textLabel?.text = self.cellInfos1[indexPath.row]["title"]
        cell.imageView?.image = UIImage.init(named: cellInfos1[indexPath.row]["image"]!)
            //设置cell被选中的风格
            //cell?.selectionStyle = .Blue
            
            return cell
            
        }else{
            let cell = tableView.dequeueReusableCell()
            cell.textLabel?.font = UIFont.systemFontOfSize(15)
            cell.textLabel?.text = self.cellInfos2[indexPath.row]["title"]
            cell.imageView?.image = UIImage.init(named: cellInfos2[indexPath.row]["image"]!)
            return cell
        }
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        if tableView == tableView1 {
            if indexPath.row == 1{
                let detailVC = DetailViewController.init()
                self.navigationController?.pushViewController(detailVC, animated: true)
            }else if indexPath.row == 2 {
                let loginVC = LoginViewController.init()
                let applocation = UIApplication.sharedApplication()
                let appDelegate = applocation.delegate! as! AppDelegate
                let mmDav = appDelegate.mmDrawerVC
                mmDav?.navigationController?.pushViewController(loginVC, animated: true)
                mmDav?.navigationController?.navigationBar.hidden = false
            }
        }else if tableView == tableView2 {
            if indexPath.row == 1{
                let feedbackVC = FeedbackViewController.init()
                self.navigationController?.pushViewController(feedbackVC, animated: true)
            }else if indexPath.row == 4{

                
          let scanVC = ScanViewController.init()
                scanVC.title = "扫一扫"
                //设置扫码界面的样式
                // let scanStyle = LBXScanViewStyle
                //扫描嘛线条
                scanVC.scanStyle?.animationImage = UIImage.init(named: "横线 3")
                //四个角颜色
                scanVC.scanStyle?.colorAngle = UIColor ( red: 0.6112, green: 1.0, blue: 0.3528, alpha: 1.0 )
                //四个角的位置
                scanVC.scanStyle?.photoframeAngleStyle = LBXScanViewPhotoframeAngleStyle.Inner
                //巨型区域中心上移
                scanVC.scanStyle?.centerUpOffset = 44
                //边框颜色
                scanVC.scanStyle?.colorRetangleLine = UIColor.whiteColor()
                //动画类型
                scanVC.scanStyle?.anmiationStyle = LBXScanViewAnimationStyle.NetGrid
                self.navigationController?.pushViewController(scanVC, animated: true)
                //处理扫描结果
                //scanVC.handleCodeResult(results)

            }else if indexPath.row == 3{
                let message = OSMessage.init()
                message.title = "书山有路勤为径"
                message.desc = "学海无涯苦作舟"
                OpenShare.shareToWeixinSession(message, success: { (msmessage) in
                    print(msmessage)
                    }, fail: { (msmessage, error) in
                        if error != nil {
                            print(error)
                        }else{
                            print(msmessage)
                        }
                })
            }
        }
        
        
    }
    
}
