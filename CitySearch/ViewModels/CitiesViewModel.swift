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

    weak var coordinatorDelegate: CitiesCoordinatorDelegate?

    var filterDict = [Character: [CitiesDataItem]]()
    var allArray = [CitiesDataItem]()

    private lazy var queue = ServiceQueue()
    private lazy var service = ServiceRead()

    func initialise() {
        isLoading = true

        getCities { response, dictionary in
            self.filterDict = dictionary
            self.allArray = response

            self.processFetchedData(data: response)
        }
    }

    func citySelected(city: CitiesTableViewCellViewModel) {
        self.coordinatorDelegate?.didSelectCity(viewModel: city)
    }

    //Added completion handler for test cases
    func getCities(_ fileName: String = CitiesFile.FileName, _ fileType: String = CitiesFile.FileType, result: @escaping (_ response: [CitiesDataItem], _ dictionary: [Character: [CitiesDataItem]]) -> Void) {
//        let service = Service.init(result: { response in
//
//        }, completionBlock: {
//            self.isLoading = false
//        })

        //By default cities.json file
        service.fileName = fileName
        service.fileType = fileType

        service.result = { response, dictionary in
          result(response, dictionary)
        }

        service.completionBlock = {
            self.isLoading = false
        }

        queue.startOperation(operation: service)
    }

    //Added completion handler for test cases
    func filterData(text: String, result: @escaping (_ response: [CitiesDataItem]) -> Void) {
        let searchService = ServiceSearch.init(text: text, cities: self.filterDict, result: { response in
            result(response)

            self.processFetchedData(data: response)
        }, completionBlock: {
        })
        searchService.addDependency(service)
        queue.startOperation(operation: searchService)
    }

    func cancelSearch() {
        if self.allArray.count > 0 {
            self.processFetchedData(data: self.allArray)
        }
    }

    var isLoading: Bool = false {
        didSet { self.updateLoadingStatus?(isLoading) }
    }

    var error: String? {
        didSet { self.showAlertClosure?() }
    }

    var didFinishLoading: (() -> Void)?
    var updateLoadingStatus: ((_ isLoading: Bool) -> Void)?
    var showAlertClosure: (() -> Void)?

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
