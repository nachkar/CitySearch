//
//  AppCoordinator.swift
//  CitySearch
//
//  Created by Noel Achkar on 9/28/20.
//

import UIKit

class CitiesCoordinator: Coordinator {
    
    private let window: UIWindow

    init(window: UIWindow) {
        self.window = window
    }

    override func start() {
        let viewController = AppDelegate.storyBoard.getViewController(identifier: .citiesList)
        let navigationController = UINavigationController.init(rootViewController: viewController)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
