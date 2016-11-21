//
//  BookrackViewController.swift
//  HYReader
//
//  Created by 千锋 on 16/10/27.
//  Copyright © 2016年 heyang. All rights reserved.
//
/*
my-default-avatar~iphone@3x
搜索~iphone@3x
add_wifi~iphone@3x
[superview bringSubviewToFront:subview]
*/

import UIKit
import MMDrawerController
import MBProgressHUD
//import FDFullscreenPopGesture
class BookrackViewController: UIViewController{
    var readVC:ReadPageController!
    var collectionView:UICollectionView!
    
    var flowLayout:UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
    
    var cellInfos = ["星罗武神","亡灵进化系统","茅山道士之灵异笔记","围城","曾国藩三部曲","西游记","盗墓笔记","三国演义"]
    var nameArray = ["星罗武神","亡灵进化系统","茅山道士之灵异笔记","围城","曾国藩三部曲","西游记","盗墓笔记","三国演义"]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.whiteColor()
        
        
        //导航
        setNavtrl()
        //UIcolletionVIew
        var bgImage = UIImage.init(named:"book")
         //拉伸图片的大小
        bgImage = bgImage!.jk_resizedImage(CGSizeMake(self.view.bounds.size.width, bgImage!.size.height), interpolationQuality: CGInterpolationQuality.High)
        
        let bgColor = UIColor(patternImage: bgImage!)
        collectionView = UICollectionView.init(frame: CGRectZero, collectionViewLayout: flowLayout)
        collectionView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0)
        collectionView.backgroundColor = bgColor
        
        self.view.addSubview(collectionView)
        collectionView.snp_makeConstraints { (make) in
            make.edges.equalTo(0)
        }
        //设置item大小,相当于tableView的cell
        flowLayout.itemSize = CGSizeMake(90, 119)
        //但是，上面这两个值的设置不一定是实际显示的值
        //下面的这个属性也会影响上面的值
        //设置边距
         flowLayout.sectionInset = UIEdgeInsetsMake(5, 25, 10, 25)
        ////设置最小行间距
        flowLayout.minimumLineSpacing = 20
        //设置最小列间距
        flowLayout.minimumInteritemSpacing = 6

        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.contentInset = UIEdgeInsetsMake(44, 0, 0, 0)
        
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.scrollIndicatorInsets = UIEdgeInsetsMake(44, 0, 0, 0)
        collectionView.registerClassOf(BookrackCell)
        
        bookCity()
        
    }
    
   
        //导航
    func setNavtrl(){
        //背景图片
        let navImage = UIImage.init(named: "导航")?.stretchableImageWithLeftCapWidth(10, topCapHeight: 10).imageWithRenderingMode(.AlwaysOriginal)
        self.navigationController?.navigationBar.setBackgroundImage(navImage, forBarMetrics: .Default)
        //标题视图
        let titleLabel = UILabel.init(frame: CGRectMake(0, 0, 200, 44))
        titleLabel.textAlignment = .Center
        titleLabel.font = UIFont.boldSystemFontOfSize(20)
        titleLabel.text = "书屋"
        titleLabel.textColor = UIColor ( red: 0.2148, green: 0.0818, blue: 0.0266, alpha: 1.0 )
        self.navigationItem.titleView = titleLabel
        //左边按钮
       
        let leftButton = UIButton.init(type:.Custom)
        leftButton.frame = CGRectMake(0, 0, 30, 30)
        leftButton.setBackgroundImage(UIImage.init(named: "my-default-avatar"), forState: .Normal)
        leftButton.addTarget(self, action: #selector(BookrackViewController.backAction), forControlEvents: .TouchUpInside)
        leftButton.layer.cornerRadius = 15
        leftButton.layer.masksToBounds = true
        let leftBarButton = UIBarButtonItem(customView: leftButton)
        self.navigationItem.leftBarButtonItem = leftBarButton
        //右边
        let searchBtn = UIBarButtonItem(image: UIImage.init(named:"搜索~iphone"  ), style: .Plain, target: self, action: #selector(BookrackViewController.searchAction))
        self.navigationItem.rightBarButtonItem = searchBtn
     
    }
    //进入书城按钮
    func bookCity(){
        
        let bookCityBtn = UIButton.init(type: UIButtonType.Custom)
        bookCityBtn.setTitle("书城", forState: UIControlState.Normal)
        bookCityBtn.setBackgroundImage(UIImage.init(named: "书城"), forState: .Normal)
        bookCityBtn.jk_setBackgroundColor(UIColor.lightGrayColor(), forState: UIControlState.Highlighted)
        bookCityBtn.jk_setBackgroundColor(UIColor ( red: 0.3175, green: 0.9413, blue: 0.6104, alpha: 1.0 ), forState: UIControlState.Disabled)
        bookCityBtn.layer.cornerRadius = 5
        bookCityBtn.layer.masksToBounds = true
        self.view.addSubview(bookCityBtn)
        bookCityBtn.snp_makeConstraints { (make) in
            make.right.equalTo(0)
            make.height.equalTo(45)
            make.width.equalTo(65)
            make.top.equalTo(400)
        }
        bookCityBtn.jk_handleControlEvents(UIControlEvents.TouchUpInside) { (sender) in
            if self.mm_drawerController.openSide == .None{
            
                self.mm_drawerController.openDrawerSide(MMDrawerSide.Right, animated: true, completion: { (finished) in
                    if finished {
                        print("打开成功")
                    }else{
                        print("打开失败")
                    }

                })
            }
        }
        

    }
    func backAction(){
    
        if mm_drawerController.openSide == .None{
            //打开
            self.mm_drawerController.openDrawerSide(MMDrawerSide.Left, animated: true, completion: { (finished) in
                
                if finished {
                    print("打开成功")
                }else{
                    print("打开失败")
                }
                
            })
        }else{
            self.mm_drawerController.closeDrawerAnimated(true) { (finished) in
                
                if finished {
                    print("关闭成功")
                }else{
                    print("关闭失败")
                }
            }
        }
    
        
        
        
    }
    func searchAction(){
//        let searchVC = SearchViewController.init()
//        self.navigationController?.pushViewController(searchVC, animated: true)
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
extension BookrackViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    //item的个数
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellInfos.count
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell:BookrackCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        cell.imageView.image = UIImage.init(named: cellInfos[indexPath.row])
//        if self.traitCollection.forceTouchCapability == UIForceTouchCapability.Available{
//            self.registerForPreviewingWithDelegate(self, sourceView: cell)
//        }
        return cell
        
    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
       collectionView.deselectItemAtIndexPath(indexPath, animated: true)
       
        
        let HUD = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        HUD.label.text = "数据加载中..."
        HUD.dimBackground = true
        
        let fileURL = NSBundle.mainBundle().URLForResource(nameArray[indexPath.row], withExtension: "txt")
        
        readVC = ReadPageController()
        
        ReadParser.separateLocalURL(fileURL!) { [weak self] (isOK) in
            
            HUD.removeFromSuperview()
            
            if self != nil {
                
               
            self!.readVC!.readModel = ReadModel.readModelWithFileName(self!.nameArray[indexPath.row])
              //隐藏导航条
            //self?.navigationController?.navigationBar.hidden = true
            //self?.fd_prefersNavigationBarHidden = true
             self!.mm_drawerController.navigationController?.pushViewController(self!.readVC!, animated: true)
                
                
            }
        }
        

        
    }
    
}

//extension BookrackViewController:UIViewControllerPreviewingDelegate{
//    func previewingContext(previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
//    }
//    func previewingContext(previewingContext: UIViewControllerPreviewing, commitViewController viewControllerToCommit: UIViewController) {
//      
//    }
//}
