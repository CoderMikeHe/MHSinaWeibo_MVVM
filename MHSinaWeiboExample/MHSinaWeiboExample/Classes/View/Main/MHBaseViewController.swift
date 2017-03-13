//
//  MHBaseViewController.swift
//  MHSinaWeiboExample
//
//  Created by CoderMikeHe on 17/3/3.
//  Copyright © 2017年 CoderMikeHe. All rights reserved.
//

import UIKit
// 面试题：OC 中支持多继承吗？如果不支持，如何替代？答案：使用协议替代！
// Swift 的写法更类似于多继承！
//class WBBaseViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
// Swift 中，利用 extension 可以把`函数`按照功能分类管理，便于阅读和维护！
// 注意：
// 1. extension 中不能有属性
// 2. extension 中不能重写`父类`本类的方法！重写父类方法，是子类的职责，扩展是对类的扩展！
/// 所以主控制器的基类控制器
class MHBaseViewController: UIViewController {

    /// 自定义导航条
    lazy var navigationBar : UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: UIScreen.cz_screenWidth(), height: 64))
    /// 自定义的导航条目 - 以后设置导航栏内容，统一使用 navItem
    /// Expected ')' in expression list 这种错误，说明括号少打了一个
    lazy var navItem : UINavigationItem = UINavigationItem()
    
    /// UITableView  - 如果用户没有登录，就不创建
    var tableView : UITableView?
    /// 刷新控件
    var refreshControl: UIRefreshControl?

    /// 上拉刷新标记
    var isPullup = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /// 初始化
        setup()
        /// 初始化子控件
        setupSubViews()

    }
    
    /// 重写Setter方法
    override var title: String?{
        didSet{
            // 设置值
            navItem.title = title
        }
    }
    
    /// 加载数据
    func loadNewData(){
        
        MHLog(message: "xxx")
        refreshControl?.endRefreshing()
        
    }
    


}
// MARK: - 初始化
extension MHBaseViewController{

    fileprivate func setup() {
        
        view.backgroundColor = UIColor.white
        
        // 去除缩进，取消自动缩进 - 如果隐藏了导航栏，会缩进 20 个点
        automaticallyAdjustsScrollViewInsets = false
        
    }
    
}

// MARK: - 设置自控制器
extension MHBaseViewController{
    
    fileprivate func setupSubViews(){
        
        // 设置导航栏
        setupNavigationBar()
        
        // 设置表格视图
        setupTableView()
        
    }
    
    /// 设置表格视图 - 用户登录之后执行
    /// 子类重写此方法，因为子类不需要关心用户登录之前的逻辑
    /// 设置表格视图
    private func setupTableView() {
        
        /// 初始化表格
        tableView = UITableView(frame: view.bounds, style: .plain)
        
        tableView?.delegate = self
        tableView?.dataSource = self
        
        view.insertSubview(tableView!, belowSubview: navigationBar)
        
        /// 初始化刷新控件
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(loadNewData), for: .valueChanged)
        tableView?.addSubview(refreshControl!)
        
        
        /// 设置tableView的额外视图
        tableView?.contentInset = UIEdgeInsets(top: navigationBar.bounds.height, left: 0, bottom: tabBarController?.tabBar.bounds.height ?? 49, right: 0)
        
    }
    
    
    /// 设置导航栏
    private func setupNavigationBar() {
     
        // 添加导航条
        view.addSubview(navigationBar)
        
        // 将item 设置给bar
        navigationBar.items = [navItem]
        
        // 设置navigationBar的 整个背景的颜色 渲染 （PS：否则导航条的透明太高，导致导航栏的右侧，有一块白色区域,即曝光太高）
        navigationBar.barTintColor = UIColor.cz_color(withHex: 0xF6F6F6)
        
        // 设置 navigationBar 的字体颜色
        navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.darkGray]
        
        // 设置导航栏文字按钮的渲染颜色
        navigationBar.tintColor = UIColor.orange
        
        // Tips : 勤提交
        
    }
    
    
    
}



// MARK: - UITableViewDelegate,UITableViewDataSource
extension MHBaseViewController: UITableViewDelegate,UITableViewDataSource{
    
    // 基类只是准备方法，子类负责具体的实现
    // 子类的数据源方法不需要 super
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 只是保证没有语法错误！
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 只是保证没有语法错误！
        return UITableViewCell()
    }
    
    /// 在显示最后一行的时候，做上拉刷新
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // 1. 判断 indexPath 是否是最后一行
        // (indexPath.section(最大) / indexPath.row(最后一行))
        // 1> row
        let row = indexPath.row
        let section = tableView.numberOfSections - 1
        
        if row<0||section<0 {
            return
        }
        
        // 2> 获取每段的总行数
        let count = tableView.numberOfRows(inSection: indexPath.section)
        
        // 如果是最后一行，同时没有开始上拉刷新
        if row == (count - 1) && !isPullup {
            
            print("上拉刷新")
            isPullup = true
            
            // 开始刷新
//            loadData()
        }
        
        
    }
    
}







