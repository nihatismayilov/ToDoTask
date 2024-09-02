//
//  UIView+Extensions.swift
//  presentation
//
//  Created by Nihad Ismayilov on 23.07.24.
//

import UIKit

extension UIView {
    convenience init(
        backgroundColor: UIColor = .clear,
        cornerRadius: CGFloat = 0
    ) {
        self.init()
        
        self.backgroundColor = backgroundColor
        
        self.cornerRadius = cornerRadius
        
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    var cornerRadius: CGFloat {
        get {
            layer.cornerRadius
        } set {
            layer.cornerRadius = newValue
        }
    }
    
    var borderWidth: CGFloat {
        get {
            layer.borderWidth
        } set {
            layer.borderWidth = newValue
        }
    }
    
    var borderColor: UIColor {
        get {
            UIColor(cgColor: layer.borderColor ?? UIColor.black.cgColor)
        } set {
            layer.borderColor = newValue.cgColor
        }
    }
    
    func addSubviews(_ views: UIView...) {
        views.forEach { view in
            addSubview(view)
        }
    }
}
