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
        let viewModel = CitiesViewModel()
        viewModel.coordinatorDelegate = self
        let viewController = AppDelegate.storyBoard.getViewController(identifier: .citiesList) as! CitiesListViewController
        viewController.viewModel = viewModel
        let navigationController = UINavigationController.init(rootViewController: viewController)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}

extension CitiesCoordinator : CitiesCoordinatorDelegate {
    func didSelectCity(viewModel: CitiesTableViewCellViewModel) {
        let cityCoordinator = CityCoordinator(navigationController: (self.window.rootViewController?.navigationController)!)
        cityCoordinator.start()
    }
}
