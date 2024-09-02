//
//  UIViewController+Extensions.swift
//  presentation
//
//  Created by Nihad Ismayilov on 23.07.24.
//

import UIKit

extension UIViewController {
    func displayAlertMessage(messageToDisplay: String, title: String, actions: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: messageToDisplay, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { (action: UIAlertAction!) in
            actions?()
        }
        alertController.view.tintColor = .red600
        alertController.addAction(okAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func displayAlertMessage(messageToDisplay: String, confirmAction: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: messageToDisplay, preferredStyle: .alert)
        
        let yesBtn = UIAlertAction(title: "Yes", style: .cancel) {
            UIAlertAction in
            confirmAction?()
        }
        let noBtn = UIAlertAction(title: "No", style: .destructive)
        
        alertController.addAction(noBtn)
        alertController.addAction(yesBtn)
        self.present(alertController, animated: true)
    }
}
