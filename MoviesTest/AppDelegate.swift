//
//  AppDelegate.swift
//  MoviesTest
//
//  Created by Aleksandr Poliakov on 27.09.2022.
//

import UIKit
import SDWebImage

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    private lazy var applicationCoordinator: ApplicationCoordinator = {
        // swiftlint:disable force_unwrapping
        ApplicationCoordinator(window: self.window!)
        // swiftlint:enable force_unwrapping
    }()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        applicationCoordinator.start()
        
        // limit image cache
        SDImageCache.shared.config.maxMemoryCost = 1024 * 1024 * 50
        SDImageCache.shared.config.maxDiskSize = 1024 * 1024 * 50
        
        return true
    }
}
