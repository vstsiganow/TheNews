//
//  ThemeColor.swift
//  TheNews
//
//  Created by vtsyganov on 09.02.2022.
//

import UIKit

enum ThemeColor: String {
    
    // Dark Colors
    case pureBlack = "000000"
    case darkBlack = "252525"
  
    // Light Colors
    case pureWhite = "ffffff"
    case pearlWhite = "fbfcf8"
    case ghostWhite = "f8f8ff"
    case smokeWhite = "f5f5f5"
    case showWhite = "f5fefd"
    
    // Colorful Colors
    case darkRed = "b41b1b"
    
    var color: UIColor {
        UIColor(hex: self.rawValue) ?? UIColor.white
    }
}
