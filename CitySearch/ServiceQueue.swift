//
//  ServiceQueue.swift
//  CitySearch
//
//  Created by Noel Achkar on 9/29/20.
//

import Foundation

class ServiceQueue: OperationQueue {
    override init() {
        super.init()
        self.maxConcurrentOperationCount = 1
    }

    func startOperation(operation: Operation) {
        //In case 2 search operations are executing at the same time to stop the previous one
        let finishedRead = self.operations.map { ($0.name == "read")}
        if finishedRead.count == 0 && self.operationCount > 0 {
            self.cancelAllOperations()
        }

        self.addOperation(operation)
    }
}
