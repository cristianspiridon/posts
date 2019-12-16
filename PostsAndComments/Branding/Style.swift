//
//  Style.swift
//  PostsAndComments
//
//  Created by CS on 16/12/2019.
//  Copyright © 2019 CS. All rights reserved.
//

import Foundation
import UIKit

public class Style {
    /// making this static makes sure that we are thread safe and no other copies are found on different threads
    public static let shared = Style(backgroundColor: .white, attributesForStyle: { $0.lennyAppStyleBuilder })

    // MARK: - General Properties

    private let backgroundColor: UIColor
    private let attributesForStyle: (_ style: Styles) -> StyleAttributes

    private init(backgroundColor: UIColor, attributesForStyle: @escaping (_ style: Styles) -> StyleAttributes) {
        self.backgroundColor = backgroundColor
        self.attributesForStyle = attributesForStyle
    }

    // MARK: Convenience Getters

    private func font(for style: Styles) -> UIFont {
        return attributesForStyle(style).font
    }

    private func color(for style: Styles) -> UIColor {
        return attributesForStyle(style).color
    }

    private func backgroundColor(for style: Styles) -> UIColor? {
        return attributesForStyle(style).backgroundColor
    }

    // MARK: Methods for clients to use

    func apply(textStyle: Styles, to textView: UITextView) {
        let attributes = attributesForStyle(textStyle)
        textView.font = attributes.font
        textView.textColor = attributes.color
        textView.backgroundColor = attributes.backgroundColor
    }

    func apply(textStyle: Styles, to label: UILabel) {
        let attributes = attributesForStyle(textStyle)
        label.font = attributes.font
        label.textColor = attributes.color
        label.backgroundColor = attributes.backgroundColor
    }

    func apply(textStyle: Styles, to textField: UITextField) {
        let attributes = attributesForStyle(textStyle)
        textField.font = attributes.font
        textField.textColor = attributes.color
        textField.backgroundColor = attributes.backgroundColor
    }

    func apply(textStyle: Styles, to button: UIButton) {
        let attributes = attributesForStyle(textStyle)
        button.setTitleColor(attributes.color, for: .normal)
        button.titleLabel?.font = attributes.font
        button.backgroundColor = attributes.backgroundColor
        button.layer.cornerRadius = button.layer.frame.height / 2
        button.layer.masksToBounds = true
    }

    func apply(textStyle: Styles, to button: UIButton, borderColor: UIColor) {
        apply(textStyle: textStyle, to: button)
        button.layer.borderColor = borderColor.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = button.layer.frame.height / 2
        button.layer.masksToBounds = true
    }

}
