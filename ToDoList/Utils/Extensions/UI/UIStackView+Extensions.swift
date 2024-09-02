//
//  UIStackView+Extensions.swift
//  presentation
//
//  Created by Nihad Ismayilov on 23.07.24.
//

import UIKit

extension UIStackView {
    convenience init(
        axis: NSLayoutConstraint.Axis,
        alignment: Alignment = .fill,
        distribution: Distribution = .equalSpacing,
        spacing: CGFloat
    ) {
        self.init()
        
        self.axis = axis
        self.alignment = alignment
        self.distribution = distribution
        self.spacing = spacing
        
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func addArrangedSubviews(_ views: UIView...) {
        views.forEach { view in
            addArrangedSubview(view)
        }
    }
}
