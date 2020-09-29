//
//  ServiceQueue.swift
//  CitySearch
//
//  Created by Noel Achkar on 9/29/20.
//

import Foundation

class ServiceQueue : OperationQueue {
    override init() {
        super.init()
        self.maxConcurrentOperationCount = 1
    }
    
    func startOperation(operation : Operation) {
        self.addOperation(operation)
    }
}
