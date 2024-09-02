//
//  UIButton+Extensiosn.swift
//  presentation
//
//  Created by Nihad Ismayilov on 23.07.24.
//

import UIKit

extension UIButton {
    convenience init(
        image: UIImage? = nil,
        title: String = "",
        tintColor: UIColor,
        backgroundColor: UIColor = .clear,
        cornerRadius: CGFloat = 0,
        font: UIFont? = nil,
        isEnabled: Bool = true
    ) {
        self.init()
        
        self.setImage(image, for: .normal)
        
        self.setTitle(title, for: .normal)
        
        self.setTitleColor(tintColor, for: .normal)
        
        self.tintColor = tintColor
        
        self.backgroundColor = backgroundColor
        
        self.cornerRadius = cornerRadius
        
        if let font {
            self.titleLabel?.font = font
        }
        
        self.isEnabled = isEnabled
        
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    convenience init(configuration: Bool = false, image: UIImage?, title: String?, tintColor: UIColor, backgroundColor: UIColor) {
        self.init()
        let tintedImage = image?.withRenderingMode(.alwaysTemplate)

        self.setImage(tintedImage, for: .normal)
        self.setTitle(title, for: .normal)
        self.setTitleColor(tintColor, for: .normal)
        self.tintColor = tintColor

        if tintedImage != nil {
            self.backgroundColor = .clear
        } else {
            self.backgroundColor = backgroundColor
        }
        
        if configuration {
            if #available(iOS 15.0, *) {
                var configuration = UIButton.Configuration.gray()
                configuration.baseBackgroundColor  = .clear
                self.configuration = configuration
            }
        }
    }
}
