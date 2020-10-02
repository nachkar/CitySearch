//
//  CityMapViewModel.swift
//  CitySearch
//
//  Created by Noel Achkar on 9/29/20.
//

import Foundation

class CityMapViewModel {

    var name: String?
    var country: String?
    var coord: Coord?

    init(city: CitiesTableViewCellViewModel) {
        self.name = city.name
        self.coord = city.coord
        self.country = city.country
    }

    func didFinishLoading() {
        didFinishProcessing?()
    }

    var didFinishProcessing: (() -> Void)?
}
