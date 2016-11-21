
//
//  Port.swift
//  HYReader
//
//  Created by 千锋 on 16/11/5.
//  Copyright © 2016年 heyang. All rights reserved.
//

import Foundation

// 一般项目都会有一个测试地址，和正式环境的不一样，所以一般我们会根据是否是 DEBUG 模式改变 baseUrl
#if false
let QFAppBaseURL = "http://192.168.1.107/PhalApi/Public/CodeShare/"
#else
let QFAppBaseURL = "https://www.1000phone.tk/"
#endif

// 图片资源的基地址
let QFResourceBaseUrl = "http://www.1000phone.tk/upload/QFApi"

// 短信发送SDK的 appKey 和 appSecret
let MobApp = "142d07ce785cb"
let MobSecret = "adecbf154b1728cb450ab56c0344e988"

// 极光推送的 appKey 91175c4c166f1d8810659781  6e374ad3af2116de708083cd
let JPushAppKey = "6e374ad3af2116de708083cd"


