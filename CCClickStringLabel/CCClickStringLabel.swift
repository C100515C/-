//
//  CCClickStringLabel.swift
//  JiayiWorld-Swift
//
//  Created by 123 on 2018/8/21.
//  Copyright © 2018年 123. All rights reserved.
//

import UIKit
import SnapKit

/// 可点击文字 view
class CCClickStringLabel: UIView,UITextViewDelegate {
    // MARK: - key
    private let clickKey = "http://cc"
    
    // MARK: - 内容view
    /// 内容 显示textview  取消textview的编辑状态，不让点击弹出键盘  设置textview 协议代理，textview
    private lazy var contentView:UITextView = {
        let tmp = UITextView(frame: CGRect.zero)
        tmp.delegate = self
        tmp.isEditable = false
        tmp.backgroundColor = UIColor.clear
        return tmp
    }()
    
    /// 内容 显示label 添加到 textview
//    private lazy var subContentView:UILabel = {
//        let tmp = UILabel(frame: CGRect.zero)
//        tmp.backgroundColor = UIColor.white
//        return tmp
//    }()
    private lazy var subContentView:UITextView = {
        let tmp = UITextView(frame: CGRect.zero)
        tmp.backgroundColor = UIColor.white
        tmp.isEditable = false
        tmp.isUserInteractionEnabled = false
        return tmp
    }()
    
    // MARK: -  设置内容
    /// 设置显示内容  赋值给contentview
    private var content:String?
    
    /// 点击部分 颜色
    private var keyColor:UIColor?
    
    /// 点击响应部分字符串
    private var clickStr:String? {
        didSet{
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineBreakMode = NSLineBreakMode.byCharWrapping
            
            keyRange = content!.range(of: clickStr!)
            let att:NSMutableAttributedString = NSMutableAttributedString(string: content!)
            att.addAttribute(NSAttributedStringKey.link, value: URL(string: clickKey)!, range: "".nsRange(from: keyRange!))
            att.addAttribute(NSAttributedStringKey.font, value: UIFont.systemFont(ofSize: textFont), range: NSMakeRange(0, content!.count))
            att.addAttribute(NSAttributedStringKey.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, content!.count))
            self.contentView.attributedText = att
            
            let att1:NSMutableAttributedString = NSMutableAttributedString(string: content!)
            att1.addAttribute(NSAttributedStringKey.foregroundColor, value: keyColor!, range: "".nsRange(from: keyRange!))
            att1.addAttribute(NSAttributedStringKey.font, value: UIFont.systemFont(ofSize: textFont), range:NSMakeRange(0, content!.count))
            att1.addAttribute(NSAttributedStringKey.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, content!.count))
            self.subContentView.attributedText = att1
        }
    }
    
    /// 点击字符串区域
    private var keyRange:Range<String.Index>?
    
    // MARK: - 外部使用 属性
    /// 点击回调
    var clickBlock:((String?)->Void)?
    
    /// 设置view内容
    ///
    /// - Parameters:
    ///   - con: 字符串内容
    ///   - click: 点击子串
    func setContent(con:String,click:String,kColor:UIColor,lines:Int,font:CGFloat) {
        lineNum = lines
        textFont = font
        content = con
        keyColor = kColor
        clickStr = click
    }
    
    /// 设置行数
    var lineNum:Int = 0
//    var lineNum:Int = 0{
//        didSet{
//            print("\(oldValue)")
//        }
//        willSet{
//            subContentView.numberOfLines = newValue
//        }
//    }
    
    /// 设置字体大小
     var textFont:CGFloat = 15
//    var textFont:CGFloat = 15{
//        didSet{
//            print("\(oldValue)")
//        }
//        willSet{
//            subContentView.font = UIFont.systemFont(ofSize: newValue)
//            contentView.font = UIFont.systemFont(ofSize: newValue)
//        }
//    }
    
    // MARK: -  更新ui
    
    /// 更新高度
    private func updateFrame() {
        let height = (caculateHeight(lineNum: lineNum) < getContentHeight()) ? caculateHeight(lineNum: lineNum) : getContentHeight()
        self.snp.updateConstraints { (make) in
            make.height.equalTo(height)
        }
    }
    
    // MARK: - layoutSubviews
    override func layoutSubviews() {
        super.layoutSubviews()
        updateFrame()
    }
    
    // MARK: -  计算行数 大小
    
    /// 通过行数计算 应该的高度
    ///
    /// - Parameter lineNum: 行数
    /// - Returns: 高度
    private func caculateHeight(lineNum:Int) -> CGFloat {
        return CGFloat(lineNum) * self.frame.size.height 
    }
    
    /// 通过内容计算高度
    ///
    /// - Returns: 高度
    private func getContentHeight() -> CGFloat{
        return CCTools.textViewHeight(content!, textFont, labelWidth: self.frame.size.width)
    }
    
    // MARK: -  初始化方法
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.contentView)
        self.addSubview(self.subContentView)
        self.layoutUI()
    }
    
    // MARK: -  初始化方法 跟xib  sb  初始化有关
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: -  设置子视图 约束
    /// 设置子视图 约束
    private func layoutUI(){
        contentView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
        subContentView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
    }
    
    // MARK: - UITextViewDelegate
    
    /// 点击UITextView 中的 url 响应事件
    ///
    /// - Parameters:
    ///   - textView: textview
    ///   - URL: url
    ///   - characterRange: 点击范围
    /// - Returns: 是否响应 true  false
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange) -> Bool {
        
        if URL.absoluteString == clickKey {
            if let tmp = clickBlock {
                tmp(clickStr)
            }
        }
        return false
    }

}
