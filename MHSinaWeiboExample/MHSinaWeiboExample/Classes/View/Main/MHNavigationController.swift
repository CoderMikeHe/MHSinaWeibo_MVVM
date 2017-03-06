//
//  MHNavigationController.swift
//  MHSinaWeiboExample
//
//  Created by CoderMikeHe on 17/3/3.
//  Copyright © 2017年 CoderMikeHe. All rights reserved.
//

/**
 1. 系统的导航条左侧或右侧item不能高亮。  利用customView 或者 配置  [UIBarButtonItem appearance]
 2. 导航条融合，用户体验不好。 自定义navigationBar
 
 */



import UIKit

class MHNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    /// 监听控制器的push操作 所有的 push 操作都会调用这个方法
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        // 如果不是栈底控制器就需要隐藏，根控制器不需要处理
        if childViewControllers.count>0 {
         
            // 隐藏底部tabBar
            viewController.hidesBottomBarWhenPushed = true
        }
        
        super.pushViewController(viewController, animated: animated)
    }

}
