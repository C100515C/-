//
//  CCTools.swift
//  JiayiWorld-Swift
//
//  Created by 123 on 2018/5/31.
//  Copyright © 2018年 123. All rights reserved.
//

import UIKit

/// 工具类
class CCTools: NSObject {
    
   /// 去掉字符串中的回车
   ///
   /// - Parameter str: 要被去掉回车的字符串
   /// - Returns: 去掉回车的字符串
   class func removeReturnSymbol(oldString str:inout String) -> String {
        return CCTools.removeSymbols(removeSymbols: ["\r","\n"], oldStr: &str, replaceStr: "")
    }
    
   /// 过滤字符串中不要的字符
   ///
   /// - Parameters:
   ///   - symbols: 要过滤的字符数组
   ///   - old: 要被过滤的字符串
   ///   - replace: 用来替换的字符串
   /// - Returns: 结果字符串
   class func removeSymbols(removeSymbols symbols:[String], oldStr old:inout String, replaceStr replace:String) -> String {
        old.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        for symbol in symbols {
            let range = old.range(of: symbol)
            if let tmp = range{
                old.replaceSubrange(tmp, with: replace)
            }
        }
        return old
    }
    
    
    /// 通过颜色获得 image
    ///
    /// - Parameter color: 颜色
    /// - Returns: image
    class func createImage(withColor color:UIColor) -> UIImage{
        let rect:CGRect = CGRect(x:0.0,y:0.0,width:1.0,height:1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context:CGContext = UIGraphicsGetCurrentContext()!
        context.setFillColor(color.cgColor)
        context.fill(rect)
        let image:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
    
    
    /// md5 字符串转换
    ///
    /// - Parameter str: 源字符串
    /// - Returns: 结果
    class func MD5(sourceStr str:String) -> String {
        let tmp = str.cString(using: String.Encoding.utf8)
        let md5Buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: Int(CC_MD5_DIGEST_LENGTH))
        CC_MD5(tmp!, (CC_LONG)(strlen(tmp!)), md5Buffer)
        
        let md5Str = NSMutableString()
        for i in 0..<CC_MD5_DIGEST_LENGTH {
            md5Str.appendFormat("%02x",md5Buffer[Int(i)])
        }
        
        free(md5Buffer)
        
        return md5Str as String
    }
    
    
    /// 设置按钮 内容居中 图片在上文字在下
    ///
    /// - Parameter btn: 按钮
    /// - Returns: 按钮
    class func buttonContentCenterImageUp(_ btn:UIButton)->UIButton{
        
        let imgViewSize = btn.imageView?.bounds.size ?? CGSize(width: 0, height: 0 )
        let titleSize = btn.titleLabel?.bounds.size ?? CGSize(width: 0, height: 0 )
        let btnSize = btn.bounds.size;
        
        let heightSpace:CGFloat = 10.0
        
        let imageViewEdge = UIEdgeInsetsMake(-heightSpace, 0.0,btnSize.height-imgViewSize.height-heightSpace, -titleSize.width)
        btn.imageEdgeInsets = imageViewEdge
        
        let titleEdge = UIEdgeInsetsMake(imgViewSize.height+heightSpace, -imgViewSize.width, 0.0, 0.0);
        btn.titleEdgeInsets = titleEdge

        return btn
    }
    
    
    /// 获得字符串 宽度 高度固定
    ///
    /// - Parameters:
    ///   - text: 字符串
    ///   - fontSize: 字体大小
    ///   - height: 高度
    /// - Returns: 宽度
    class func textWidth(_ text:String, _ fontSize:CGFloat, labelHeight height:CGFloat) -> CGFloat {
        let rect = CGRect(x: 0, y: 0, width: 0, height: height)
        let label = UILabel(frame: rect)
        label.text = text
        label.font = UIFont.systemFont(ofSize: fontSize)
        label.numberOfLines = 0
        label.sizeToFit()
        return label.frame.size.width
    }
    
    
    /// 获得 高度 宽度固定
    ///
    /// - Parameters:
    ///   - text: 字符串
    ///   - fontSize: 字体大小
    ///   - width: 宽度
    /// - Returns: 高度
    class func textHeight(_ text:String, _ fontSize:CGFloat, labelWidth width:CGFloat) -> CGFloat {
        let rect = CGRect(x: 0, y: 0, width: width, height: 0)
        let label = UILabel(frame: rect)
        label.text = text
        label.font = UIFont.systemFont(ofSize: fontSize)
        label.numberOfLines = 0
        label.sizeToFit()
        return label.frame.size.height
    }
    
    /// 获得字符串 宽度 高度固定 在textView中
    ///
    /// - Parameters:
    ///   - text: 字符串
    ///   - fontSize: 字体大小
    ///   - height: 高度
    /// - Returns: 宽度
    class func textViewWidth(_ text:String, _ fontSize:CGFloat, labelHeight height:CGFloat) -> CGFloat {
        let rect = CGRect(x: 0, y: 0, width: 0, height: height)
        let label = UITextView(frame: rect)
        label.text = text
        label.font = UIFont.systemFont(ofSize: fontSize)
//        label.numberOfLines = 0
        label.sizeToFit()
        return label.frame.size.width
    }
    
    
    /// 获得 高度 宽度固定 在textView中
    ///
    /// - Parameters:
    ///   - text: 字符串
    ///   - fontSize: 字体大小
    ///   - width: 宽度
    /// - Returns: 高度
    class func textViewHeight(_ text:String, _ fontSize:CGFloat, labelWidth width:CGFloat) -> CGFloat {
        let rect = CGRect(x: 0, y: 0, width: width, height: 0)
        let label = UITextView(frame: rect)
        label.text = text
        label.font = UIFont.systemFont(ofSize: fontSize)
//        label.numberOfLines = 0
        label.sizeToFit()
        return label.frame.size.height
    }
    
    
    /// 带图片的 富文本字符串
    ///
    /// - Parameters:
    ///   - imageInfor: 图片的信息元祖 （图片名字字符串，图片rect,图片在哪个位置）
    ///   - allTextArr: 整个文字字符串 拼接起来的小字符串信息数组 数组元素为元祖（字符串，字符串颜色,字体）
    /// - Returns: 富文本
    class func AttributedStringHaveImage(_ imageInfor:(String,CGRect,Int),texts allTextArr:[(String,UIColor,UIFont)]) -> NSMutableAttributedString {
        var allText:String = ""
        for (str,_,_) in allTextArr {
            allText += str
        }
        
        let result = NSMutableAttributedString.init(string: allText)
        for (str,color,font) in allTextArr {
            let range = allText.range(of: str)
            result.addAttribute(NSAttributedStringKey.font, value: font, range: NSRange(range!, in: ""))
            result.addAttribute(NSAttributedStringKey.foregroundColor, value: color, range: NSRange(range!, in: ""))
        }
        
        let imageAttch = NSTextAttachment.init()
        imageAttch.image = UIImage.init(named: imageInfor.0)
        imageAttch.bounds = imageInfor.1
        
        let imageString = NSAttributedString.init(attachment: imageAttch)
        
        let insertStr = allTextArr[imageInfor.2].0
        let range = allText.range(of: insertStr)
        result .insert(imageString, at: NSRange(range!, in: "").location+NSRange(range!, in: "").length)
        
        return result
    }
    
    /// 获得图片名字
    class func getMd5Names(uids:[String])->[String]{
        var newNames:[String] = []
        for name in uids{
           newNames.append(getMD5PicName(uid: name))
        }
        return newNames
    }
    
    /// - Returns: MD5 string
    class func getMD5PicName(uid:String)->String{
        let time = String(currentTimeStamp())
        return MD5(sourceStr: "\(uid)+\(time)")
    }
    
    ///
    /// - Returns: 时间秒数
    class func currentTimeStamp()-> Double{
        return Date().timeIntervalSince1970
    }
}

extension String{
    //Range转换为NSRange
    func nsRange(from range: Range<String.Index>) -> NSRange {
        let utf16view = self.utf16
        if let from = range.lowerBound.samePosition(in: utf16view), let to = range.upperBound.samePosition(in: utf16view) {
            return NSMakeRange(utf16view.distance(from: utf16view.startIndex, to: from), utf16view.distance(from: from, to: to))
        }
        return NSMakeRange(0, 0)
    }
    
    //Range转换为NSRange
    func range(from nsRange: NSRange) -> Range<String.Index>? {
        guard
            let from16 = utf16.index(utf16.startIndex, offsetBy: nsRange.location, limitedBy: utf16.endIndex),
            let to16 = utf16.index(from16, offsetBy: nsRange.length, limitedBy: utf16.endIndex),
            let from = String.Index(from16, within: self),
            let to = String.Index(to16, within: self)
            else { return nil }
        return from ..< to
    }
    
}
