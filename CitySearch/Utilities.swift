//
//  Utilities.swift
//  CitySearch
//
//  Created by Noel Achkar on 9/28/20.
//

import UIKit

extension UIStoryboard {
    func getViewController(identifier : ViewControllerIdentifier) -> UIViewController {
        return self.instantiateViewController(withIdentifier: identifier.rawValue)
    }
}
