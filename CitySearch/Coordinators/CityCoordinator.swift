//
//  CityCoordinator.swift
//  CitySearch
//
//  Created by Noel Achkar on 9/28/20.
//

import UIKit

class CityCoordinator: Coordinator {
    
    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    override func start() {
        let viewController = AppDelegate.storyBoard.getViewController(identifier: .cityDetails)
        self.navigationController.pushViewController(viewController, animated: true)
    }
}
