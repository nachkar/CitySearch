//
//  CitiesDataItem.swift
//  CitySearch
//
//  Created by Noel Achkar on 9/28/20.
//

import Foundation

struct CitiesDataItem: JSONCompatible {
    var name: String
    var _id: Int
    var coord: Coord
    var country: String

    init?(json: [String: Any]?) {
        guard let json = json else {return nil}
        name = json["name"] as? String ?? ""
        _id = json["_id"] as? Int ?? 0
        coord = Coord(json: json["coord"] as? [String: Any]) ?? Coord()
        country = json["country"] as? String ?? ""
    }

    init() {
        self.init(json: [:])!
    }

    init?(data: Data?) {
        guard let data = data else {return nil}
        guard let json = (try? JSONSerialization.jsonObject(with: data, options: [])) as? [String: Any] else {return nil}
        self.init(json: json)
    }

    init(name: String, _id: Int, coord: Coord, country: String) {
        self.name = name
        self._id = _id
        self.coord = coord
        self.country = country
    }

    /// This function generate a json dictionary from the model.
    ///
    /// - Parameter useOriginalJsonKey: This parameter take effect only when you have modified a property's name making it different to the original json key. If true, the original json key will be used when generate json dictionary, otherwise, the modified property name will be used as key in the dictionary.
    func jsonDictionary(useOriginalJsonKey: Bool) -> [String: Any] {
        var dict: [String: Any] = [:]
        dict["name"] = name
        dict["_id"] = _id
        dict["coord"] = coord.jsonDictionary(useOriginalJsonKey: useOriginalJsonKey)
        dict["country"] = country
        return dict
    }
}
