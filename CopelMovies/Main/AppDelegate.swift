//
//  AppDelegate.swift
//  CopelMovies
//
//  Created by Mac on 14/08/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let nav = UINavigationController()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
        let vc = CM_LoginMain.createModule(navigation: nav)
        nav.pushViewController(vc, animated: true)
        return true
    }
}
