//
//  BaseTabBarController.swift
//  TheNews
//
//  Created by vtsyganov on 10.02.2022.
//

import UIKit

class BaseTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.tintColor = ThemeColor.darkBlack.color
    }
}
