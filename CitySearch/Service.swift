//
//  Service.swift
//  CitySearch
//
//  Created by Noel Achkar on 9/29/20.
//

import Foundation

class Service : Operation {
    
    var result: ((_ response : [CitiesDataItem]) -> ())?

    override init() {
        super.init()
    }
    
    init(result: @escaping (_ response:[CitiesDataItem]) -> Void,completionBlock: @escaping () -> Void) {
        self.result = result

        super.init()

        self.completionBlock = completionBlock
    }

    override func main() {
        if isCancelled {
            return
        }
        
        do {
            let path = Bundle.main.path(forResource: CitiesFile.FileName, ofType: CitiesFile.FileType) ?? ""
            let data = try Data(contentsOf: URL(fileURLWithPath:path), options: .mappedIfSafe)
            let model = try JSONDecoder().decode([CitiesDataItem].self, from: data)
            let sorted = model.sorted(by: {$0.name < $1.name})
            result!(sorted)
        } catch {
            result!([])
        }
    }
}

class ServiceSearch : Operation {
    
    var result: (_ response:[CitiesDataItem]) -> Void
    
    init(result: @escaping (_ response:[CitiesDataItem]) -> Void,completionBlock: @escaping () -> Void) {
        self.result = result
        
        super.init()
        
        self.completionBlock = completionBlock
    }
    
    override func main() {
        if isCancelled {
            return
        }
        
        do {
          //Filter Data
//            result(sorted)
        } catch {
            result([])
        }
    }
}
