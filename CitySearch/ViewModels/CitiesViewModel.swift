//
//  CitiesViewModel.swift
//  CitySearch
//
//  Created by Noel Achkar on 9/28/20.
//

import Foundation

protocol CitiesCoordinatorDelegate {
    func didSelectCity(viewModel: CitiesTableViewCellViewModel)
}    

class CitiesViewModel: NSObject {
        
    var coordinatorDelegate: CitiesCoordinatorDelegate?
    var tmpArray = [CitiesDataItem]()
    
    private lazy var queue = ServiceQueue()
    private lazy var service = Service()
    
    func initialise() {
        isLoading = true
        
        getCities()
    }
    
    func citySelected(city : CitiesTableViewCellViewModel) {
        self.coordinatorDelegate?.didSelectCity(viewModel: city)
    }
    
    func getCities() {
//        let service = Service.init(result: { response in
//
//        }, completionBlock: {
//            self.isLoading = false
//        })
        service.result = { response in
            self.tmpArray = response
            self.processFetchedData(data: response)
        }
        
        service.completionBlock = {
            self.isLoading = false
        }
        
        queue.startOperation(operation: service)
    }
    
    func filterData(text : String) {
        let searchService = ServiceSearch.init(result: { response in
            self.processFetchedData(data: response)
        }, completionBlock: {
        })
        searchService.addDependency(service)
        queue.startOperation(operation: searchService)
    }
    
    func cancelSearch() {
        self.processFetchedData(data: self.tmpArray)
    }
    
    var items: [CitiesTableViewCellViewModel] = [] {
        didSet { self.didFinishLoading?() }
    }
    
    var isLoading: Bool = false {
        didSet { self.updateLoadingStatus?(isLoading) }
    }
    
    var error: String? {
        didSet { self.showAlertClosure?() }
    }
    
    var didFinishLoading: (() -> ())?
    var updateLoadingStatus: ((_ isLoading : Bool) -> ())?
    var showAlertClosure: (() -> ())?
    
    var itemCount: Int {
        get { return items.count }
    }
    
    //Cells
    func createCellViewModel(item: CitiesDataItem) -> CitiesTableViewCellViewModel {
        return CitiesTableViewCellViewModel(name: item.name, _id: item._id, coord: item.coord, country: item.country)
    }
    
    func processFetchedData(data: [CitiesDataItem]) {
        var vms = [CitiesTableViewCellViewModel]()
        
        for city in data {
            vms.append(createCellViewModel(item: city))
        }
        self.items = vms
    }
}
