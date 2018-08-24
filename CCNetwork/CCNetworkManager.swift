//
//  CCNetworkManager.swift
//  JiayiWorld-Swift
//
//  Created by 123 on 2018/5/31.
//  Copyright © 2018年 123. All rights reserved.
//

import UIKit

/// 网络工具
class CCNetworkManager: NSObject {
    
    static let share:CCNetworkManager = CCNetworkManager()
    private override init() {
    }
    var netWork:CCNetwork?
    
    func GETRequest(requestUrl url:String?, paramDic params:Dictionary<String,AnyObject>?, requestType method:CCNetwork.MethodType?,_ callBack:@escaping ((_ data:Any?, _ response:URLResponse?, _ error:Error?)->Void?)) {
        self.netWork = CCNetwork(requestUrl: url, params: params, requestType: method, callBack)
        self.netWork?.start()
    }
}
