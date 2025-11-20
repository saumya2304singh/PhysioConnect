//
//  UIColorHex.swift
//  PhysioConnect
//
//  Created by admin4 on 13/11/25.
//

// UIColor+Hex.swift
import UIKit

extension UIColor {
    convenience init?(hex: String) {
        var formatted = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if formatted.hasPrefix("#") { formatted.remove(at: formatted.startIndex) }
        guard formatted.count == 6 else { return nil }
        var rgbValue: UInt64 = 0
        guard Scanner(string: formatted).scanHexInt64(&rgbValue) else { return nil }
        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: 1.0
        )
    }
}

