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
        
        NSObject.cancelPreviousPerformRequests(withTarget: self)
        
//        if Utilities.isStringNull(string: searchController.searchBar.text ?? "") {
//            viewModel.cancelFilter()
//            return
//        }
        
        perform(#selector(searchText(text:)), with: searchController.searchBar.text!, afterDelay: 0.6)
    }
    
    @objc func searchText(text : String) {
//        viewModel.filterData(text: text)
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
