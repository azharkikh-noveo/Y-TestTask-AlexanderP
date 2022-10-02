//
//  AppDelegate.swift
//  MoviesTest
//
//  Created by Aleksandr Poliakov on 27.09.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    private lazy var applicationCoordinator: ApplicationCoordinator = {
        ApplicationCoordinator(window: self.window!)
    }()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        applicationCoordinator.start()

        return true
    }
}
