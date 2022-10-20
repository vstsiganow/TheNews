//
//  Theme.swift
//  TheNews
//
//  Created by vtsyganov on 20.10.2022.
//

import UIKit

enum Theme: Int {
    case `default`, dark
    
    private enum Keys {
        static let selectedTheme = "SelectedTheme"
    }
    
    static var current: Theme {
        let storedTheme = UserDefaults.standard.integer(forKey: Keys.selectedTheme)
        return Theme(rawValue: storedTheme) ?? .default
    }
    
    var mainColor: UIColor {
        switch self {
        case .default:
            return ThemeColor.pureWhite.color
        case .dark:
            return ThemeColor.pureBlack.color
        }
    }
    
    var barStyle: UIBarStyle {
        switch self {
        case .default:
            return .default
        case .dark:
            return .black
        }
    }
    
    var navigationBackgroundColor: UIColor {
        switch self {
        case .default:
            return ThemeColor.ghostWhite.color
        case .dark:
            return ThemeColor.darkBlack.color
        }
    }
    
    var tabBarBackgroundColor: UIColor {
        switch self {
        case .default:
            return ThemeColor.pureWhite.color
        case .dark:
            return ThemeColor.pureBlack.color
        }
    }
    
    var mainBackgroundColor: UIColor {
        switch self {
        case .default:
            return ThemeColor.ghostWhite.color
        case .dark:
            return ThemeColor.pureBlack.color
        }
    }
    
    var topNewsBackgroundColor: UIColor {
        switch self {
        case .default:
            return ThemeColor.pureWhite.color
        case .dark:
            return ThemeColor.darkBlack.color
        }
    }
    
    var textColor: UIColor {
        switch self {
        case .default:
            return ThemeColor.pureBlack.color
        case .dark:
            return ThemeColor.pureWhite.color
        }
    }
    
    func apply() {
        UserDefaults.standard.set(rawValue, forKey: Keys.selectedTheme)
        UserDefaults.standard.synchronize()
        
        UIApplication.shared.delegate?.window??.tintColor = mainColor
        
        UINavigationBar.appearance().barStyle = barStyle
        UINavigationBar.appearance().backgroundColor = navigationBackgroundColor
        
        UITabBar.appearance().barStyle = barStyle
        UITabBar.appearance().backgroundColor = tabBarBackgroundColor
        
        UISwitch.appearance().onTintColor = mainColor.withAlphaComponent(0.3)
        UISwitch.appearance().thumbTintColor = mainColor
        
        //UIView.appearance().backgroundColor = backgroundColor
        
        //UITableViewCell.appearance().backgroundColor = mainBackgroundColor
        UILabel.appearance(whenContainedInInstancesOf: [UITableViewCell.self]).textColor = textColor
    }
}
