//
//  UIColor+Extension.swift
//  PostsAndComments
//
//  Created by CS on 16/12/2019.
//  Copyright © 2019 CS. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    // we are decorating the UIColor with a new init to be able to have colors with hex values
    convenience init(hexString: String) {
        let hexString: NSString = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased() as NSString
        let scanner = Scanner(string: hexString as String as String)

        if hexString.hasPrefix("#") {
            scanner.scanLocation = 1
        }

        var color: UInt32 = 0
        scanner.scanHexInt32(&color)

        let mask = 0x0000_00FF

        let red = CGFloat(Int(color >> 16) & mask) / 255.0
        let green = CGFloat(Int(color >> 8) & mask) / 255.0
        let blue = CGFloat(Int(color) & mask) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: 1)
    }

    func toHexString() -> String {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0

        getRed(&red, green: &green, blue: &blue, alpha: &alpha)

        let rgb: Int = Int(red * 255) << 16 | Int(green * 255) << 8 | Int(blue * 255) << 0

        return NSString(format: "%06x", rgb) as String
    }
}
