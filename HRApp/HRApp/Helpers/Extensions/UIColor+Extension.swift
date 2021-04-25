//
//  UIColor+Extension.swift
//  HRApp
//
//  Created by Даниил Храповицкий on 24.04.2021.
//

import UIKit

extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        
        Scanner(string: hex).scanHexInt64(&int)
        
        let alpha: UInt64
        let red: UInt64
        let green: UInt64
        let blue: UInt64
        
        switch hex.count {
        case 3: // RGB (12-bit)
            (alpha, red, green, blue) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (alpha, red, green, blue) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (alpha, red, green, blue) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (alpha, red, green, blue) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(red) / 255,
                  green: CGFloat(green) / 255,
                  blue: CGFloat(blue) / 255,
                  alpha: CGFloat(alpha) / 255)
    }
    
    func lighter(by value: CGFloat = 0.2) -> UIColor {
        return adjust(by: value)
    }
    
    func darker(by value: CGFloat = 0.2) -> UIColor {
        return adjust(by: -1 * value)
    }
    
    private func adjust(by value: CGFloat) -> UIColor {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return UIColor(red: min(red + value, 1.0),
                       green: min(green + value, 1.0),
                       blue: min(blue + value, 1.0),
                       alpha: alpha)
    }
}
