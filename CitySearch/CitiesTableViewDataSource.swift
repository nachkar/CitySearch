//
//  CitiesTableViewDataSource.swift
//  CitySearch
//
//  Created by Noel Achkar on 9/28/20.
//

import UIKit

extension CitiesListViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 112
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "CitiesCell")
        
        // Configure the cell...
        if (!(cell != nil)) {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: "CitiesCell")
        }
        
        cell?.textLabel?.text = "test"
        
        return cell!
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
