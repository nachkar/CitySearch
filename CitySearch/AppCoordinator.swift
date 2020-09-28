//
//  AppCoordinator.swift
//  CitySearch
//
//  Created by Noel Achkar on 9/28/20.
//


import UIKit

class AppCoordinator: Coordinator {
    
    private let navigationController: UINavigationController
    private let window: UIWindow

    init(navigationController: UINavigationController, window: UIWindow) {
        self.navigationController = navigationController
        self.window = window
    }

    override func start() {
        let viewController = AppDelegate.storyBoard.getViewController(identifier: .citiesList)
        window.rootViewController = viewController
        window.makeKeyAndVisible()
    }
}
