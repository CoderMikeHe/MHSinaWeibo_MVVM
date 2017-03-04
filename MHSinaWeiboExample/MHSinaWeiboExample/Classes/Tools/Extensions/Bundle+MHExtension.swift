//
//  Bundle+MHExtension.swift
//  MHSinaWeiboExample
//
//  Created by CoderMikeHe on 17/3/4.
//  Copyright © 2017年 CoderMikeHe. All rights reserved.
//

import Foundation

extension Bundle{
    
    // 计算型属性类似于函数，没有参数，有返回值
    var namespace : String {
        
        let name = infoDictionary?["CFBundleName"] as? String ?? ""
        
        return name
        
    }
    
    
}
