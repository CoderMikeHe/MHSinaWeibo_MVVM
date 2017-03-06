//
//  MHBaseViewController.swift
//  MHSinaWeiboExample
//
//  Created by CoderMikeHe on 17/3/3.
//  Copyright © 2017年 CoderMikeHe. All rights reserved.
//

import UIKit

class MHBaseViewController: UIViewController {

    
    /// 自定义导航条
    lazy var navigationBar : UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: UIScreen.cz_screenWidth(), height: UIScreen.cz_screenHeight()))
    /// 自定义的导航条目 - 以后设置导航栏内容，统一使用 navItem
    /// Expected ')' in expression list 这种错误，说明括号少打了一个
    lazy var navItem : UINavigationItem = UINavigationItem()
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// 初始化子控件
        setupSubViews()

    }
    

    /// 重写Setter方法
    override var title: String?{
        didSet{
            
            navItem.title = title
        }
    }
    


}

extension MHBaseViewController{
    func setupSubViews()  {
        
        // 添加导航条
        view.addSubview(navigationBar)
        
        // 将item 设置给bar
        navigationBar.items = [navItem]

    }
}









