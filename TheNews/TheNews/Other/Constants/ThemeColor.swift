//
//  ThemeColor.swift
//  TheNews
//
//  Created by vtsyganov on 09.02.2022.
//

import UIKit

enum ThemeColor: String {
    
    case pureBlack = "000000"
    case pureWhite = "ffffff"
    case darkBlack = "252525"
    case darkRed = "b41b1b"
    
    var color: UIColor {
        UIColor(hex: self.rawValue) ?? UIColor.white
    }
}
