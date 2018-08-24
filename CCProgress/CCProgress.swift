//
//  CCProgress.swift
//  JiayiWorld-Swift
//
//  Created by 123 on 2018/6/4.
//  Copyright © 2018年 123. All rights reserved.
//

import UIKit

class CCProgress: UIView {
    private let Radius = 9.0
    
    var currentValue:CGFloat?
    var totalValue:CGFloat?
    var progressSize:CGSize?
    var progressColor:UIColor?
    var progressBackgroudColor:UIColor?
    
    private lazy var currentValueView:UIView = UIView.init(frame: CGRect.zero)
    private lazy var currentTitle:UILabel = UILabel.init(frame: CGRect.zero)
    private  var currentProgressWidth:CGFloat?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.loadUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func loadUI(){
        
    }
    
    private func loadLayout(){
        
    }
}
