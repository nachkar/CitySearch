//
//  CitiesTableViewDelegate.swift
//  CitySearch
//
//  Created by Noel Achkar on 9/28/20.
//

import UIKit

extension CitiesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.citySelected(city: viewModel.items[indexPath.row])
    }
}
