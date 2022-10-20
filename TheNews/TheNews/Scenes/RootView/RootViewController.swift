//
//  RootViewController.swift
//  TheNews
//
//  Created by vtsyganov on 10.02.2022.
//

import UIKit

class RootViewController: BaseViewController {
    
    let tabBarVC = BaseTabBarController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTabBarController()
    }
}

extension RootViewController {
    
    private func setTabBarController() {        
        let homeViewController = TopNewsViewBuilder().build()
        homeViewController.title = "Top News"
        homeViewController.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "house"), tag: 0)
        
        let searchViewController = BaseViewController()
        searchViewController.title = "Search"
        searchViewController.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "magnifyingglass"), tag: 1)
        
        let settingViewController = BaseViewController()
        settingViewController.title = "Setting"
        settingViewController.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "gear"), tag: 2)
        
        let vcArray = [homeViewController, searchViewController, settingViewController]
        
        tabBarVC.viewControllers = vcArray.map {BaseNavigationController(rootViewController: $0)}
        
        self.view.addSubview(tabBarVC.view)
    }
    
}
