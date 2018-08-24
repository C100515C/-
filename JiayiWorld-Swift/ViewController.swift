//
//  ViewController.swift
//  JiayiWorld-Swift
//
//  Created by 123 on 2018/5/31.
//  Copyright © 2018年 123. All rights reserved.
//

import UIKit

class ViewController: CCRefreshVC, UITableViewDelegate, UITableViewDataSource {
    let scroll:UITableView = UITableView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT), style: UITableViewStyle.plain)
    let navView:UIView = UIView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: NAV_HEIGHT))
    static let cellID = "cc"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //网络请求测试
//        CCNetworkManager.share.GETRequest(requestUrl:"https://itunes.apple.com/cn/lookup?id=1324010475", paramDic: [:], requestType: CCNetwork.MethodType.POST) { (data, re, error) -> Void? in
//            print(data)
//        }
        //md5转换测试
//       let re = CCTools.MD5(sourceStr: "saghjsghiosaghafohgajlaghjnadfajlfgajldfgoafiudjafhgdfouhgsjuhfgjs")
//        print(re)
        //字符串去除
//        var a = "sjgkdsjgkr"
//        let re = CCTools.removeReturnSymbol(oldString: &a)
//        print(re)
        
        //计算字符串高度
//       print(CCTools.textHeight("ddgddgsdggggggggggggggggggggg", 15, labelWidth: 50))
//       print(CCTools.textWidth("ddgddgsdggggggggggggggggggggg", 15, labelHeight: 20))
        
        //获得 富文本字符串
//        let l = UILabel.init(frame:CGRect(x: 0, y: 200, width: 300, height: 30))
//        self.view.addSubview(l)
//        l.attributedText = CCTools.AttributedStringHaveImage(("leader_icon", CGRect(x: 0, y: 0, width: 15, height: 15), 2), texts: [("wode shi", UIColor.yellow, UIFont.systemFont(ofSize: 15)),("ccccc", UIColor.red, UIFont.systemFont(ofSize: 15)),("sghfdh", UIColor.blue, UIFont.systemFont(ofSize: 15)),("hfghg", UIColor.purple, UIFont.systemFont(ofSize: 15))])
        
        //刷新测试
//        allUIInit()
//        self.addRefresh(refreshScollView: self.scroll, navView: self.navView) {
//            print("刷新结束")
////            self.endRefresh()
//            self.perform(#selector(self.endRefresh), with: nil, afterDelay: 3)
//        }
        
//        let btn = UIButton.init(type: UIButtonType.custom)
//        self.view.addSubview(btn)
//        btn.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
//        let action1 = #selector(btnAction as ()->())
//        let action2 = #selector(btnAction as (UIButton)->())

//        btn.addTarget(self, action: #selector(btnAction), for: UIControlEvents.touchUpInside)
        // Do any additional setup after loading the view, typically from a nib.
//        var names:[String] = []
//        for i in 25..<28 {
//            names.append("图片\(i)")
//        }
//        print("\(CCTools.getMd5Names(uids: ["图片27","图片28","图片29","图片30","图片31","图片32","图片33","图片34","图片35","图片36"]))")
//        print("\(CCTools.getMd5Names(uids: names))")
        
        
        ///点击string
        let label  = CCClickStringLabel(frame: CGRect.zero)
        view.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.left.equalTo(view.snp.left).offset(100)
            make.top.equalTo(view.snp.top).offset(100)
            make.width.equalTo(200)
            make.height.equalTo(30)
        }
        label.setContent(con: "是否市公司规范和地方哈佛哈地方分工会sgadssagsdgasgdsagasgsdgasdgsdagdsasgadsgdsagdsgasdgasgsag发的规划符合规范撒贡嘎山广东佛山过了发刚", click: "过了", kColor:UIColor.yellow, lines: 3, font: 15)
        label.clickBlock = {(string)in
            print("\(String(describing: string))")
        }
    }
    
//    @objc func btnAction() {
//        print("btn")
//    }
//    @objc func btnAction(_ sender:UIButton){
//        print("btn1")
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func allUIInit() {
        self.scroll.delegate = self
        self.scroll.dataSource = self
        self.scroll.tableFooterView = UIView.init()
        if #available(iOS 11.0, *){
            //ios 11 的设置为 不计算内边距 UIScrollViewContentInsetAdjustmentNever
            self.scroll.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentBehavior.never
            //iOS 11 设置下面三个预算高度 回调执行即为滑到那个执行那个
            self.scroll.estimatedRowHeight = 0
            self.scroll.estimatedSectionHeaderHeight = 0
            self.scroll.estimatedSectionFooterHeight = 0
        }
        
        self.navView.backgroundColor = UIColor.purple
        
        self.view.addSubview(self.scroll)
        self.view.addSubview(self.navView)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return SCREEN_HEIGHT
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: ViewController.cellID)
        if cell==nil {
            cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: ViewController.cellID)
        }
        
        cell!.textLabel!.text = "第\(indexPath.row)行"
        cell!.textLabel!.textColor = UIColor.red
        
        return cell!
    }
}
