//
//  UITextField+Extensions.swift
//  presentation
//
//  Created by Nihad Ismayilov on 24.07.24.
//

import UIKit

extension UITextField {
    convenience init(
        placeholder: String = "",
        backgroundColor: UIColor? = .clear,
        alignment: NSTextAlignment = .left,
        textColor: UIColor,
        placeholderColor: UIColor? = nil,
        font: UIFont,
        adjustsFontSize: Bool
    ) {
        self.init()
        
        self.adjustsFontSizeToFitWidth = adjustsFontSize
                
        self.font = font
        
        self.text = text
        
        self.textColor = textColor
        
        self.backgroundColor = backgroundColor
        
        self.leftViewMode = .always
        
        self.textAlignment = .left
        
        self.placeholder = placeholder
        
        tintColor = .red600
        
        if let placeholderColor {
            self.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: placeholderColor])
        }
        
        translatesAutoresizingMaskIntoConstraints = false
    }
}
