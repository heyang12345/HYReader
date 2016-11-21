//
//  UserModel.swift
//  HYReader
//
//  Created by 千锋 on 16/11/5.
//  Copyright © 2016年 heyang. All rights reserved.
//

import UIKit
import YYModel
class UserModel: NSObject {
    //用户单利
    //一句话写单利
    static var SharedUser = UserModel()
    
    private override init() {
        super.init()
        //取出沙盒数据，配置默认用户
        if let userInfo = NSUserDefaults.standardUserDefaults().objectForKey(String(UserModel)){
            self.yy_modelSetWithJSON(userInfo)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var address = ""
    var avatar = ""
    var birthday = ""
    var email = ""
    var gender = ""
    var id:String? = nil
    var name = ""
    var nickname = ""
    var phone = ""
    //判断用户是否登录
    class func isLogin()->Bool{
        return SharedUser.id != nil
    }
    class func loggin(with userInfo:[String:AnyObject]){
        //用YYModel做字典转模型
        SharedUser.yy_modelSetWithDictionary(userInfo)
        //将用户数据存储到沙盒
        NSUserDefaults.standardUserDefaults().setObject(SharedUser.yy_modelToJSONObject(), forKey: String(UserModel))
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    //退出登录
    class func logout(){
        NSUserDefaults.standardUserDefaults().setObject(nil, forKey: String(UserModel))
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
}
