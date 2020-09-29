//
//  ServiceQueue.swift
//  CitySearch
//
//  Created by Noel Achkar on 9/29/20.
//

import Foundation

class ServiceQueue : OperationQueue {
    init(_ operation : Operation) {
        super.init()
        
        self.maxConcurrentOperationCount = 1
        self.addOperation(operation)
    }
}
