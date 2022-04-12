//
//  BaseNavigationController.swift
//  TheNews
//
//  Created by vtsyganov on 09.02.2022.
//

import UIKit

class BaseNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updatedTheme()
        interactivePopGestureRecognizer?.isEnabled = true
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    private func updatedTheme() {
        
        navigationBar.barStyle = UIBarStyle.black
        navigationBar.isTranslucent = false
        navigationBar.barTintColor = ThemeColor.showWhite.color
        navigationBar.tintColor = ThemeColor.darkBlack.color
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
    }
}
