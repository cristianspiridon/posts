//
//  StyleFonts.swift
//  PostsAndComments
//
//  Created by CS on 16/12/2019.
//  Copyright © 2019 CS. All rights reserved.
//

import Foundation
import UIKit

extension UIFont {
    static var title: UIFont {
        return UIFont.systemFont(ofSize: 28, weight: UIFont.Weight.bold)
    }

    static var body: UIFont {
        return UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.regular)
    }

    static var smallMediumRegular: UIFont {
        return UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.regular)
    }

    static var subhead: UIFont {
        return UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.semibold)
    }

    static var footnote: UIFont {
        return UIFont.systemFont(ofSize: 13, weight: UIFont.Weight.regular)
    }
}
