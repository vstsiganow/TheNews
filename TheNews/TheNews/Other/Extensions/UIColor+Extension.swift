//
//  UIColor+Extension.swift
//  TheNews
//
//  Created by vtsyganov on 09.02.2022.
//

import UIKit

extension UIColor {
    // MARK: - Initialization

        convenience init?(hex: String) {
            var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
            hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

            var rgb: UInt32 = 0

            var red: CGFloat = 0.0
            var green: CGFloat = 0.0
            var blue: CGFloat = 0.0
            var alpha: CGFloat = 1.0

            let length = hexSanitized.count

            guard Scanner(string: hexSanitized).scanHexInt32(&rgb) else { return nil }

            if length == 6 {
                red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
                green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
                blue = CGFloat(rgb & 0x0000FF) / 255.0

            } else if length == 8 {
                red = CGFloat((rgb & 0xFF000000) >> 24) / 255.0
                green = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
                blue = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
                alpha = CGFloat(rgb & 0x000000FF) / 255.0

            } else {
                return nil
            }

            self.init(red: red, green: green, blue: blue, alpha: alpha)
        }
}
