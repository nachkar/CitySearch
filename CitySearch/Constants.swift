//
//  Constants.swift
//  CitySearch
//
//  Created by Noel Achkar on 9/28/20.
//

import Foundation

public enum ViewControllerIdentifier: String {
    case citiesList = "CitiesListViewController"
    case cityDetails     = "CityViewController"
}

struct CitiesFile {
    static let FileName = "cities"
    static let FileType = "json"
}
