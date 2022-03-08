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
        let firstVC = RegularNewsViewBuilder().build()
        firstVC.title = "News Today"
        firstVC.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "doc.text"), tag: 0)
        
        let secondVC = BaseViewController()
        secondVC.title = "Hot News"
        secondVC.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "flame"), tag: 1)
        
        let vcArray = [firstVC, secondVC]
        
        tabBarVC.viewControllers = vcArray.map{BaseNavigationController(rootViewController: $0)}
        
        self.view.addSubview(tabBarVC.view)
    }
    
}
