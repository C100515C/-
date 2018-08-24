//
//  CCNetwork.swift
//  JiayiWorld-Swift
//
//  Created by 123 on 2018/5/31.
//  Copyright © 2018年 123. All rights reserved.
//

import UIKit
//import Foundation

/// 网络工具
class CCNetwork: NSObject,URLSessionDelegate {
    
    /// 请求方法类型
    ///
    /// - GET: get 请求
    /// - POST: post 请求
    enum MethodType:String{
        case  GET = "GET"
        case  POST = "POST"
    }
    
    /// 错误类型
    ///
    /// - DataNone: 数据不存在
    /// - DataError: 数据错误
    enum ErrorDataType:Error {
        case DataNone
        case DataError
    }
    
    var url:String!
    var method:MethodType!
    var params:Dictionary<String,AnyObject>?
    var callBack:(_ data:Any?, _ response:URLResponse?, _ error:Error?)->Void?
    
    var request:URLRequest!
    var task:URLSessionTask!
    var session:URLSession!
    
    /// 初始化
    ///
    /// - Parameters:
    ///   - url: url连接
    ///   - paramDic: 参数
    ///   - method: 请求类型
    ///   - callBack: 返回执行
    init(requestUrl url:String?, params paramDic:Dictionary<String,AnyObject>?, requestType method:MethodType?,_ callBack:@escaping ((_ data:Any?, _ response:URLResponse?, _ error:Error?)->Void?)) {
        
        self.url = url
        self.method = method
        self.callBack = callBack
        self.params = paramDic
        self.request = URLRequest(url: URL(string:self.url)!)
        super.init()
        self.session = URLSession(configuration: URLSession.shared.configuration, delegate: self, delegateQueue: URLSession.shared.delegateQueue)
    }
    
    /// 开始请求
    func start(){
        self.request.httpMethod = self.method.rawValue;
        self.request.timeoutInterval = 10
        if (self.params?.count)!>0 {
            self.request.httpBody = getRequestBodyData(paramsDic: self.params)
        }
        self.request.setValue("application/json;encoding=utf-8", forHTTPHeaderField:"Content-Type")

        self.task = self.session.dataTask(with: self.request, completionHandler: { (data, response, error) in
            do {
                let resData = try self.getJson(resData: data!)
                self.callBack(resData,response,nil)
            }catch{
                print(error)
            }
            
            if let resError = error{
                self.callBack(nil,response,resError)
            }
        })
        self.task.resume()
    }
    
    
    /// 获得请求体的data数据
    ///
    /// - Parameter params: 请求参数字典
    /// - Returns: 请求体data
    func getRequestBodyData(paramsDic params:Dictionary<String,AnyObject>!) -> Data {
        var keyValues:[String] = []
        for key in params.keys {
            let str = key + "=" + (params[key]! as! String)
            keyValues.append(str)
        }
        let bodyStr = keyValues.joined(separator: "&")
        return bodyStr.data(using: String.Encoding.utf8)!
    }
    
    
    /// json 转换
    ///
    /// - Parameter data: 请求data 数据
    /// - Returns: json 数据 dic 或者 arr
    /// - Throws: 转完为空错误抛出
    func getJson(resData data:Data) throws -> Any {
        var result:Any?
        do {
            result =  try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
            guard result != nil else{
                throw ErrorDataType.DataNone
            }
        } catch {
            print(error)
        }
        return result!
    }
    
}
