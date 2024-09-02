//
//  UILabel+Extensions.swift
//  presentation
//
//  Created by Nihad Ismayilov on 23.07.24.
//

import UIKit

extension UILabel {
    convenience init(
        text: String = "",
        textColor: UIColor,
        backgroundColor: UIColor = .clear,
        textAlignment: NSTextAlignment = .left,
        numberOfLines: Int = 0,
        font: UIFont
    ) {
        self.init()
        
        self.text = text
        
        self.textColor = textColor
        
        self.backgroundColor = backgroundColor
        
        self.textAlignment = textAlignment
        
        self.numberOfLines = numberOfLines
        
        self.font = font
        
        translatesAutoresizingMaskIntoConstraints = false
    }
}
