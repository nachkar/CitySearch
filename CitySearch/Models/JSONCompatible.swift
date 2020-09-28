//
//  JSONCompatible.swift
//  CitySearch
//
//  Created by Noel Achkar on 9/28/20.
//

import Foundation

protocol JSONCompatible {
    init?(json: [String: Any]?)
    init()
    init?(data: Data?)
    func jsonDictionary(useOriginalJsonKey: Bool) -> [String: Any]
}
