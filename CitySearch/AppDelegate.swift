//
//  AppDelegate.swift
//  CitySearch
//
//  Created by Noel Achkar on 9/28/20.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    class var sharedDelegate: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    class var storyBoard : UIStoryboard {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        return storyboard
    }
    
    private lazy var appCoordinator = AppCoordinator(navigationController: window?.rootViewController as! UINavigationController)

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController()
        
        setupCoordinator()
               
        window?.makeKeyAndVisible()

        return true
    }

    func setupCoordinator() {
        appCoordinator.start()
    }
}

