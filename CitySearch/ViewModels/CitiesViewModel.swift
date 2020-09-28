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

    func initialise() {
        getCities()
    }
    
    func getCities() {
//        do
//        {
//            let path = Bundle.main.path(forResource: "", ofType: "") ?? ""
//            let data = try Data(contentsOf: URL(fileURLWithPath:path), options: .mappedIfSafe)
//            let model = try JSONDecoder().decode([CitiesDataItem].self, from: data)
//        } catch {
//
//        }
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
