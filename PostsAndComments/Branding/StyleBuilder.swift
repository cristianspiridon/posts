//
//  StyleBuilder.swift
//  PostsAndComments
//
//  Created by CS on 16/12/2019.
//  Copyright © 2019 CS. All rights reserved.
//

import Foundation
import UIKit

extension Style {
    // StyleAttributes is our object in which we save the configurations for our styles
    struct StyleAttributes {
        let font: UIFont
        let color: UIColor
        var backgroundColor: UIColor = UIColor.clear

        init(font: UIFont, color: UIColor, backgroundColor: UIColor = UIColor.clear) {
            self.font = font
            self.color = color
            self.backgroundColor = backgroundColor
        }
    }

    struct ColorPalette {
        var color: UIColor
        var backgroundColor: UIColor

        init(color: UIColor, backgroundColor _: UIColor = UIColor.clear) {
            self.color = color
            backgroundColor = color
        }
    }

    // Here is an enumaration of style type you can apply to textfields, textinputs, labels, buttons
    enum Styles {
         /// medium 28pt
        case title(color: UIColor, backgroundColor: UIColor = UIColor.clear)
        /// regular 17pt
        case body(color: UIColor, backgroundColor: UIColor = UIColor.clear)
        /// semibold 15pt
        case subhead(color: UIColor, backgroundColor: UIColor = UIColor.clear)
    
    }
}

extension Style.Styles {
    var lennyAppStyleBuilder: Style.StyleAttributes {
        switch self {
        /// medium 28pt
        case let .title(color, backgroundColor):
            return Style.StyleAttributes(font: .title, color: color, backgroundColor: backgroundColor)
        /// regular 17pt
        case let .body(color, backgroundColor):
            return Style.StyleAttributes(font: .body, color: color, backgroundColor: backgroundColor)
         /// semibold 15pt
        case let .subhead(color, backgroundColor):
            return Style.StyleAttributes(font: .subhead, color: color, backgroundColor: backgroundColor)
        }
    }
}
