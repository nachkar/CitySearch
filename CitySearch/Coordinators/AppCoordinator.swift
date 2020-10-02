//
//  AppCoordinator.swift
//  CitySearch
//
//  Created by Noel Achkar on 9/29/20.
//

import Foundation
import UIKit

class AppCoordinator: Coordinator {

    fileprivate let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    override func start() {
        startMain()
    }

    fileprivate func startMain() {
        let mainCoordinator = CitiesCoordinator(navigationController: navigationController)
        mainCoordinator.start()
    }
}
