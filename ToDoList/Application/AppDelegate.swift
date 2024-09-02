//
//  AppDelegate.swift
//  ToDoList
//
//  Created by Nihad Ismayilov on 31.08.24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let vc = HomeRouter.build()
        setupInitialPage(vc, hasNavVC: true)
                
        return true
    }
    
    private func setupInitialPage(_ vc: UIViewController, hasNavVC: Bool) {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        if hasNavVC {
            let navVC = UINavigationController(rootViewController: vc)
            self.window?.rootViewController = navVC
            self.window?.makeKeyAndVisible()
        } else {
            self.window?.rootViewController = vc
        }
        self.window?.makeKeyAndVisible()
    }
}
