//
//  UIImageView+Extensiosn.swift
//  presentation
//
//  Created by Nihad Ismayilov on 23.07.24.
//

import UIKit

extension UIImageView {
    convenience init(
        image: UIImage?,
        backgroundColor: UIColor? = nil,
        tintColor: UIColor? = nil,
        cornerRadius: CGFloat = 0
    ) {
        self.init()
        
        self.image = image
                
        self.backgroundColor = backgroundColor
        
        if let tintColor {
            self.tintColor = tintColor
        }
        
        self.cornerRadius = cornerRadius
        
        translatesAutoresizingMaskIntoConstraints = false
    }
}
