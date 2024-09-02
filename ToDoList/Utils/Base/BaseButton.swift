//
//  BaseButton.swift
//  ToDoList
//
//  Created by Nihad Ismayilov on 31.08.24.
//

import UIKit

class BaseButton: UIButton {
    override var isEnabled: Bool{
        didSet{
            alpha = isEnabled ? 1 : 0.5
        }
    }
    override var isHighlighted: Bool{
        didSet{
            if isHighlighted{
                UIView.transition(with: self, duration: 0.2, options: .beginFromCurrentState) { [weak self] in
                    guard let self else {return}
                    transform = CGAffineTransform(scaleX: 0.98, y: 0.98)
                }
            }else{
                UIView.transition(with: self, duration: 0.2, options: .beginFromCurrentState) { [weak self] in
                    guard let self else {return}
                    transform = CGAffineTransform(scaleX: 1, y: 1)
                }
            }
        }
    }
}
