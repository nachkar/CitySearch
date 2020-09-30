//
//  CitiesTableViewDataSource.swift
//  CitySearch
//
//  Created by Noel Achkar on 9/28/20.
//

import UIKit

extension CitiesListViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.itemCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "CitiesCell")
        
        // Configure the cell...
        if (!(cell != nil)) {
            cell = UITableViewCell.init(style: .subtitle, reuseIdentifier: "CitiesCell")
        }
        
        if viewModel.items.count > 0 {
            let model = viewModel.items[indexPath.row]
            cell?.textLabel?.text = "\(model.name), \(model.country)"
            cell?.detailTextLabel?.text = "\(model.coord.lat),\(model.coord.lon)"
        }
        
        return cell!
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
