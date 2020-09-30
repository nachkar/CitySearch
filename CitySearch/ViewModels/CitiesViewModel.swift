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
    private lazy var service = ServiceRead()
    
    func initialise() {
        isLoading = true
        
        getCities { response in
            self.tmpArray = response
            self.processFetchedData(data: response)
        }
    }
    
    func citySelected(city : CitiesTableViewCellViewModel) {
        self.coordinatorDelegate?.didSelectCity(viewModel: city)
    }
    
    //Added completion handler for test cases
    func getCities(_ fileName : String = CitiesFile.FileName,_ fileType : String = CitiesFile.FileType, result: @escaping (_ response:[CitiesDataItem]) -> Void) {
//        let service = Service.init(result: { response in
//
//        }, completionBlock: {
//            self.isLoading = false
//        })
        
        //By default cities.json file
        service.fileName = fileName
        service.fileType = fileType
        
        service.result = { response in
          result(response)
        }
        
        service.completionBlock = {
            self.isLoading = false
        }
        
        queue.startOperation(operation: service)
    }
    
    //Added completion handler for test cases
    func filterData(text : String, result: @escaping (_ response:[CitiesDataItem]) -> Void) {
        let searchService = ServiceSearch.init(text: text, cities: self.tmpArray, result: { response in
            result(response)
            
            self.processFetchedData(data: response)
        }, completionBlock: {
        })
        searchService.addDependency(service)
        queue.startOperation(operation: searchService)
    }
    
    func cancelSearch() {
        self.processFetchedData(data: self.tmpArray)
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
    
    var items: [CitiesTableViewCellViewModel] = [] {
        didSet { self.didFinishLoading?() }
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
