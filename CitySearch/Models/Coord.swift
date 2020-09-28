//
//  Coord.swift
//  CitySearch
//
//  Created by Noel Achkar on 9/28/20.
//

import Foundation

struct Coord: JSONCompatible {
    var lon: Double
    var lat: Double

    init?(json: [String: Any]?) {
        guard let json = json else {return nil}
        lon = json["lon"] as? Double ?? 0.0
        lat = json["lat"] as? Double ?? 0.0
    }

    init() {
        self.init(json: [:])!
    }

    init?(data: Data?) {
        guard let data = data else {return nil}
        guard let json = (try? JSONSerialization.jsonObject(with: data, options: [])) as? [String: Any] else {return nil}
        self.init(json: json)
    }

    init(lon: Double, lat: Double) {
        self.lon = lon
        self.lat = lat
    }

    /// This function generate a json dictionary from the model.
    ///
    /// - Parameter useOriginalJsonKey: This parameter take effect only when you have modified a property's name making it different to the original json key. If true, the original json key will be used when generate json dictionary, otherwise, the modified property name will be used as key in the dictionary.
    func jsonDictionary(useOriginalJsonKey: Bool) -> [String: Any] {
        var dict: [String: Any] = [:]
        dict["lon"] = lon
        dict["lat"] = lat
        return dict
    }
}
