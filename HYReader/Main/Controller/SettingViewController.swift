//
//  SettingViewController.swift
//  HYReader
//
//  Created by 千锋 on 16/10/29.
//  Copyright © 2016年 heyang. All rights reserved.
//

import UIKit
import swiftScan
class SettingViewController: TableViewController {
    
    private lazy var clearLabel : UILabel = {
        let clearLabel = UILabel.init()
        clearLabel.frame.size.height = 20
        clearLabel.frame.size.width = 50
        clearLabel.textColor = UIColor ( red: 0.4303, green: 0.4303, blue: 0.4303, alpha: 1.0 )
        clearLabel.text = "0KB"
        return clearLabel
    }()
    private lazy var sweepLabel : UILabel = {
        let sweepLabel = UILabel.init()
        sweepLabel.frame.size.height = 20
        sweepLabel.frame.size.width = 80
        sweepLabel.textColor = UIColor ( red: 0.4303, green: 0.4303, blue: 0.4303, alpha: 1.0 )
        sweepLabel.text = "扫一扫"
        return sweepLabel
    }()
    
    let cellInfos = [
        [   [
            "title":"阅读设置",
            "image":"阅读设置~iphone",
            "type":"0"
            ],
            [
                "title":"书架设置",
                "image":"书架设置~iphone",
                "type":"0"
            ],
            [
                "title":"阅读偏好设置",
                "image":"阅读偏好设置~iphone",
                "type":"0"
            ],
        ],
        
        [
           
            [
                "title":"账户与安全",
                "image":"账户与安全~iphone",
                "type":"0"
            ],
        ],
        
        [
            [
                "title":"清除缓存",
                "image":"清除缓存~iphone",
                "type":"1"
            ],
            [
                "title":"关于我们",
                "image":"关于我们~iphone",
                "type":"2"
            ],
            [
                "title":"回复苹果购买书籍",
                "image":"恢复苹果购买书籍~iphone",
                "type":"2"
            ],

        ],
        
        [
            [
                "title":"电纸书",
                "image":"电纸书~iphone",
                "type":"3"
            ]
        ]
        
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.whiteColor()
        //设置tableView
        self.tableView.backgroundColor = UIColor ( red: 0.9471, green: 0.9471, blue: 0.9471, alpha: 1.0 )
        tableView.rowHeight = 60
        //tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0)
        //设置组间距
        tableView.sectionHeaderHeight = 0
        tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        
        tableView.registerClassOf(UITableViewCell)
        //隐藏分割线
        //tableView.layoutMargins = UIEdgeInsetsZero
        //self.view.addSubview(clearLabel!)
        configureNav()
        
    }
    func configureNav(){
        
        self.navigationItem.title = "设置"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage.init(named: "book_store_back~iphone"), style: .Plain, target: self, action: #selector(SettingViewController.backAction))
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
extension SettingViewController{
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
            return self.cellInfos.count
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.cellInfos[section].count
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell()
        //字体
        cell.textLabel?.font = UIFont.systemFontOfSize(16)
        cell.textLabel?.textColor = UIColor.blackColor()
        cell.textLabel?.text = cellInfos[indexPath.section][indexPath.row]["title"]
        //图片
        cell.imageView?.image = UIImage.init(named: cellInfos[indexPath.section][indexPath.row]["image"]!)
        let type = cellInfos[indexPath.section][indexPath.row]["type"]
        if type == "0" {
            cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        }else if type == "1"{
            cell.accessoryView = clearLabel
            
        }else if type == "2"{
            cell.accessoryType = UITableViewCellAccessoryType.None
        }else if type == "3"{
            cell.accessoryView = sweepLabel
        }
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
       
        }
}