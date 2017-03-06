//
//  UIBarButtonItem+MHExtension.swift
//  MHSinaWeiboExample
//
//  Created by CoderMikeHe on 17/3/7.
//  Copyright © 2017年 CoderMikeHe. All rights reserved.
//

import Foundation
import UIKit


extension UIBarButtonItem{
   
    /// 便利构造函数
    convenience init(title : String , fontSize : CGFloat = 16.0 , target : AnyObject? , action : Selector ) {
        
        // 创建按钮对象 注意：Swift 调用 OC 返回 instancetype方法，判断（推倒）不出是否可选，所以要设置其类型
        let btn : UIButton = UIButton.cz_textButton(title, fontSize: fontSize, normalColor: UIColor.darkGray, highlightedColor: UIColor.orange)
        // 监听按钮点击事件
        btn.addTarget(target, action: action, for: .touchUpInside)
        
        // self.init 实例化 UIBarButtonItem
        self.init(customView: btn)
        
    }
    
}
