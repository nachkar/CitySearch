//
//  CitiesListViewController.swift
//  CitySearch
//
//  Created by Noel Achkar on 9/28/20.
//

import UIKit

class CitiesListViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var viewModel: CitiesViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupTableView()
        setupSearchBar()
        setupNavigationBar()
        handleViewModel()
    }
    
    func handleViewModel() {
        weak var weakself = self
        
        viewModel.updateLoadingStatus = { isLoading in
            DispatchQueue.main.async {
                if isLoading {
                    weakself?.activityIndicator?.isHidden = false
                    weakself?.activityIndicator?.startAnimating()
                } else {
                    weakself?.activityIndicator?.isHidden = true
                    weakself?.activityIndicator?.stopAnimating()
                }
            }
        }
        
        viewModel.didFinishLoading = {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        viewModel.initialise()
    }
    
    func setupNavigationBar() {
        self.title = "Cities"
    }
    
    func setupSearchBar() {
        let search = UISearchController(searchResultsController: nil)
        search.hidesNavigationBarDuringPresentation = false
        search.searchResultsUpdater = self
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Search here..."
        navigationItem.searchController = search
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    func setupTableView() {
        self.tableView.tableFooterView = UIView()
    }
}

extension CitiesListViewController: UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        
//        NSObject.cancelPreviousPerformRequests(withTarget: self)
        
        if (searchController.searchBar.text?.isEmpty == true) {
            viewModel.cancelSearch()
            return
        }
        
        searchText(text: searchController.searchBar.text!)
//        perform(#selector(searchText(text:)), with: searchController.searchBar.text!, afterDelay: 0.6)
    }
    
    @objc func searchText(text : String) {
        viewModel.filterData(text: text,result: {response in
            print("Filtration finished")
        })
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        // Stop doing the search stuff
        // and clear the text in the search bar
        //        searchBar.text = ""
        // Hide the cancel button
        searchBar.showsCancelButton = false
        // You could also change the position, frame etc of the searchBar
        self.tableView.scrollsToTop = true
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.becomeFirstResponder()
        searchBar.showsCancelButton = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
    }
}
