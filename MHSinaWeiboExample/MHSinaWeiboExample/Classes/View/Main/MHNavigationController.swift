//
//  MHNavigationController.swift
//  MHSinaWeiboExample
//
//  Created by CoderMikeHe on 17/3/3.
//  Copyright © 2017年 CoderMikeHe. All rights reserved.
//

/**
 1. 系统的导航条左侧或右侧item不能高亮。  利用customView 或者 配置  [UIBarButtonItem appearance]
 2. 导航条融合，用户体验不好。 自定义navigationBar，或者设置导航条的颜色很重，解决高亮闪动的bug
 3. 
 */



import UIKit

class MHNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // 隐藏系统自带的navigationBar
        navigationBar.isHidden = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    /// 监听控制器的push操作 所有的 push 操作都会调用这个方法
    // viewController 是被 push进来，再次可以设置其返回按钮
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        // 如果不是栈底控制器就需要隐藏，根控制器不需要处理
        if childViewControllers.count>0 {
         
            // 隐藏底部tabBar
            viewController.hidesBottomBarWhenPushed = true
            
            // 判断控制器的类型
            if let vc = viewController as? MHBaseViewController{
                
                var title = "返回"
                
                // 判断如果是栈底控制器 即只有一个子控制器 显示栈底控制器的主题
                if childViewControllers.count==1 {
                
                    title = childViewControllers.first?.title ?? "返回"
                }
                
                // 设置控制器左侧栏的按钮 取出 navItem
                vc.navItem.leftBarButtonItem = UIBarButtonItem(title: title, target: self, action: #selector(popToParent) , isBack : true)
                
            }
            
        }
        
        super.pushViewController(viewController, animated: animated)
    }
    
    @objc private func popToParent() {
        
        popViewController(animated: true)
        
    }

}
