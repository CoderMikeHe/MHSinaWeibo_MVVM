//
//  MHTabBarController.swift
//  MHSinaWeiboExample
//
//  Created by CoderMikeHe on 17/3/3.
//  Copyright © 2017年 CoderMikeHe. All rights reserved.
//

import UIKit

class MHTabBarController: UITabBarController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 添加中间按钮
        // 按钮在viewDidLoad中添加,会被系统的BarButtonItem挡住,处理不了事件了
        // viewWillAppear中添加按钮,在系统的BarButtonItem之后添加
        setupComposeButton()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        /// 设置控制器
        setupChildControllers()
        
        /// 设置发布按钮 千万不要在viewDidLoad里面添加，否则会被系统的UITabBarButton覆盖
//        setupComposeButton()

    }
    
    /// 发布微博按钮
    lazy var composeButton : UIButton = {() -> UIButton in
        
        let composeButton = UIButton(type: UIButtonType.custom)
        composeButton.setImage(UIImage(named:"tabbar_compose_icon_add"), for: .normal)
        composeButton.setImage(UIImage(named:"tabbar_compose_icon_add_highlighted"), for: .highlighted)
        composeButton.setBackgroundImage(UIImage(named:"tabbar_compose_button"), for: .normal)
        composeButton.addTarget(self, action: #selector(composeBtnDidClicked), for: .touchUpInside)
        return composeButton
    }()
    // 按钮的点击事件
    // private 能够保证方法私有，仅在当前对象被访问
    // @objc 允许这个函数在`运行时`通过 OC 的消息机制被调用！
    @objc private func composeBtnDidClicked(){
        
        print("撰写微博")
        
    }
 
}



// extension 类似于 OC 中的 分类，在 Swift 中还可以用来 `切分`代码块
// 可以把相近功能的函数，放在一个 extension 中
// 便于代码维护
// 注意：和 OC 的分类一样，extension 中不能定义属性
// MARK: - 添加子控件
extension MHTabBarController{
    
    /// 设置所有自控制器
    fileprivate func setupChildControllers(){
    
        /// 通过手动配置字典
        setupControllersByDictionary()
        
    }
    
    /// 通过手动配置字典
    private func setupControllersByDictionary(){
        
        let array = [
            ["clsName":"MHHomeViewController" , "title":"首页" , "imageName":"home"],
            ["clsName":"MHMessageViewController" , "title":"消息" , "imageName":"message_center"],
            ["clsName":"xxxx"],
            ["clsName":"MHDiscoverViewController" , "title":"发现" , "imageName":"discover"],
            ["clsName":"MHProfileViewController" , "title":"我" , "imageName":"profile"]]
        
        
        for dict in array {
            // 添加子控制器
            addChildViewController(controller(dict: dict as [String : AnyObject]))
        }

    }
    
    /// 通过本地加载Json文件
    private func setupControllersByJson() {
        
        //
        
        
        
    }

    
    
    
    /// 通过一个字典创建一个控制器
    ///
    /// - Parameter dict: 字典 dict[clsName , title , imageName]
    /// - Returns: 子控制器
    private func controller(dict: [String:AnyObject])-> UIViewController{
        // 解包
        guard let clsName = dict["clsName"] as? String ,let title = dict["title"] as? String, let imageName = dict["imageName"] as? String , let cls = NSClassFromString(Bundle.main.namespace + "." + clsName) as? MHBaseViewController.Type else{
            
            return UIViewController()
            
        }
        
        // 初始化控制器
        let vc = cls.init()
        
        // 设置主题
        vc.title = title
        
        // 设置图片
        vc.tabBarItem.image = UIImage(named:"tabbar_" + imageName)
        vc.tabBarItem.selectedImage = UIImage(named: "tabbar_" + imageName+"_selected")?.withRenderingMode(.alwaysOriginal)
        
        // 修改tabBarItem的样式
        // 设置高亮的字体颜色
        vc.tabBarItem.setTitleTextAttributes(
            [NSForegroundColorAttributeName:UIColor.orange],
            for: .selected)
        // 设置字体大小 系统默认是 12 号字，修改字体大小，要设置 `Normal` 的字体大小
        vc.tabBarItem.setTitleTextAttributes(
            [NSFontAttributeName:UIFont.systemFont(ofSize: 12.0)],
            for: .normal)
        
        // 设置导航栏的根控制器
        let nav = MHNavigationController(rootViewController: vc)
        
        // 返回控制器
        return nav
    }
  
}


// MARK: - 设置UI
extension MHTabBarController{
    
    /// 设置发布按钮
    fileprivate func setupComposeButton(){
        
        // 添加控件
        tabBar.addSubview(composeButton)

        // 强转
        let count = CGFloat(childViewControllers.count)
        // 容错点：tabBar两个按钮之间，会有一个点的位置会漏出去
        // 宽度
        // 将向内缩进的宽度 ,能够让按钮的宽度增大，盖住容错点，防止穿帮！
        let w = tabBar.frame.size.width/count - 1
        
        // 设置frame
        // CGRectInset 正数向内缩进，负数向外扩展
        composeButton.frame = tabBar.bounds.insetBy(dx: 2 * w, dy: 0)
    }
    
}
