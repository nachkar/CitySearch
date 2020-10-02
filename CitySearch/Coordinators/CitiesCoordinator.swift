//
//  AppCoordinator.swift
//  CitySearch
//
//  Created by Noel Achkar on 9/28/20.
//

import UIKit

class CitiesCoordinator: Coordinator {

    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    override func start() {
        let viewModel = CitiesViewModel()
        viewModel.coordinatorDelegate = self
        let viewController = AppDelegate.storyBoard.getViewController(identifier: .citiesList) as! CitiesListViewController
        viewController.viewModel = viewModel
        self.navigationController.setViewControllers([viewController], animated: true)
    }

    func showDetailsVC(viewModel: CitiesTableViewCellViewModel) {
        let viewModel = CityMapViewModel(city: viewModel)
        let viewController = AppDelegate.storyBoard.getViewController(identifier: .cityDetails) as! CityViewController
        viewController.viewModel = viewModel
        self.navigationController.pushViewController(viewController, animated: true)
    }
}

extension CitiesCoordinator: CitiesCoordinatorDelegate {
    func didSelectCity(viewModel: CitiesTableViewCellViewModel) {
        showDetailsVC(viewModel: viewModel)
    }
}
