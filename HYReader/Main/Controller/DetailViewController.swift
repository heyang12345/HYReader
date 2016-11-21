//
//  DetailViewController.swift
//  HYReader
//
//  Created by 千锋 on 16/11/5.
//  Copyright © 2016年 heyang. All rights reserved.
//

import UIKit
import swiftScan
import Alamofire
class DetailViewController: UIViewController {
    
    
    let cellInfos = [
        [
        [
            "title":"昵称:"
        ]
            ],
        [
        [
            "title":"性别:"
        ]
            ],
        [
        [
            "title":"出生日期:"
        ]
            ],
        [
        [
            "title":"所在地:"
        ]
            ],
        [
        [
            "title":"我的二维码:"
        ]
            ],
        [
            [
                "title":"个性签名:"
            ]
        ],
        
        
      ]
    let headBtn = UIButton.init(type: UIButtonType.Custom)
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "个人信息"
        let tabView = UITableView.init(frame:CGRectMake(0, 0, self.view.size.width, self.view.size.height), style: .Grouped)
        self.view.backgroundColor = UIColor.whiteColor()
        //头视图
        let headerView = UIView.init(frame: CGRectMake(0, 0, self.view.size.width, 160))
       
        headerView.backgroundColor = UIColor(patternImage: UIImage.init(named: "书5")!)
        let toolBar = UIToolbar.init()
        toolBar.barStyle = UIBarStyle.Black
        headerView.insertSubview(toolBar, atIndex: 0)
        toolBar.snp_makeConstraints { (make) in
            make.edges.equalTo(0)
        }
        headBtn.setImage(UIImage.init(named: "用户头像"), forState: .Normal)
        headerView.addSubview(headBtn)
        headBtn.snp_makeConstraints { (make) in
            make.center.equalTo(0)
            make.height.width.equalTo(100)
        }
        //上传用户头像
        headBtn.jk_handleControlEvents(UIControlEvents.TouchUpInside) { (sender) in
            UIActionSheet.init(title: "选择头像来源", delegate: self, cancelButtonTitle: "取消", destructiveButtonTitle: nil, otherButtonTitles: "从相册选择","拍照").showInView(self.view)
            
        }
        tabView.tableHeaderView = headerView
        // 底部视图
        let footerView = UIView.init(frame: CGRectMake(0, 0, self.view.width, 100))
        let footBtn = UIButton.init(type: UIButtonType.Custom)
        footBtn.titleLabel?.font = UIFont.systemFontOfSize(15)
        footBtn.setTitle("退出登录", forState: UIControlState.Normal)
        footBtn.setTitleColor(UIColor.darkGrayColor(), forState: UIControlState.Normal)
        footBtn.jk_setBackgroundColor(UIColor ( red: 0.9732, green: 0.2521, blue: 0.2638, alpha: 1.0 ), forState: UIControlState.Normal)
        footBtn.jk_setBackgroundColor(UIColor.lightGrayColor(), forState: UIControlState.Highlighted)
        footerView.addSubview(footBtn)
        footBtn.snp_makeConstraints { (make) in
            make.center.equalTo(0)
            make.left.equalTo(0)
            make.height.equalTo(44)
        }
       tabView.tableFooterView = footerView
        //
        tabView.sectionHeaderHeight = 10
        tabView.showsHorizontalScrollIndicator = false
        tabView.backgroundColor = UIColor ( red: 0.8353, green: 0.8353, blue: 0.8353, alpha: 1.0 )
        tabView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        tabView.rowHeight = 64
        tabView.delegate = self
        tabView.dataSource = self
        self.view.addSubview(tabView)
        //复用
        tabView.registerClassOf(UITableViewCell)
        
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
extension DetailViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return cellInfos.count
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return cellInfos[section].count
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 40
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell()
        cell.textLabel?.font = UIFont.systemFontOfSize(15)
        cell.textLabel?.text = cellInfos[indexPath.section][indexPath.row]["title"]
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
         tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if indexPath.section == 4{
            let QRCodeVC = MyQRCodeViewController()
            self.navigationController?.pushViewController(QRCodeVC, animated: true)
        }
    }
    
    
}
extension DetailViewController:UIActionSheetDelegate{
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
        guard buttonIndex != 0 else {
            return
        }
        let imagePicker = UIImagePickerController.init()
        if buttonIndex == 1 {
            //从相册选择
            imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            
        }else if buttonIndex == 2 {
            //拍照
            imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        }
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
}
extension DetailViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        // 取出编辑过后的图片
        let editedImage = info[UIImagePickerControllerEditedImage]!
        // 压缩图片，转成 data
        let imageData = UIImageJPEGRepresentation(editedImage as! UIImage, 0.9)
        self.headBtn.setImage(editedImage as! UIImage, forState: UIControlState.Normal)
//        Alamofire.upload(.POST, QFAppBaseURL, multipartFormData: { (formData) in
//            formData.appendBodyPart(data: "UserInfo.UpdateAvatar".dataUsingEncoding(NSUTF8StringEncoding)!, name: "service")
//            formData.appendBodyPart(data: UserModel.SharedUser.id!.dataUsingEncoding(NSUTF8StringEncoding)!, name: "uid")
//            formData.appendBodyPart(data: imageData!, name: "avatar", fileName: "\(NSDate.init().timeIntervalSince1970).png", mimeType: "image/jpeg")
//            
//        }) { (encodingResult) in
//            switch (encodingResult) {
//            case .Success(let upload, _, _):
//                upload.responseJSON({ (data, success) in
//                    if success {
//                        print(data)
//                        let dataInfo = data as! NSDictionary
//                        self.headBtn.setImage(editedImage as! UIImage, forState: UIControlState.Normal)
//                        // 更改用户模型的属性
//                        UserModel.SharedUser.avatar = "http://10.12.155.20/PhalApi/Public/\(dataInfo["file_url"]!)"
//                        
//                    }else {
//                        print(data)
//                    }
//                })
//            case .Failure(let errorType):
//                print(errorType)
//            }
//        }
//        
//        
//        picker.dismissViewControllerAnimated(true, completion: nil)
    }
}

