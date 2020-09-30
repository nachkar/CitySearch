//
//  Service.swift
//  CitySearch
//
//  Created by Noel Achkar on 9/29/20.
//

import Foundation

protocol OperationService {
    var result: ((_ response : [CitiesDataItem], _ filterDict : Dictionary<Character,[CitiesDataItem]>) -> ())? { get set }
    init(result: @escaping (_ response:[CitiesDataItem], _ filterDict : Dictionary<Character,[CitiesDataItem]>) -> Void,completionBlock: @escaping () -> Void)
}

class ServiceRead : Operation, OperationService  {
    
    var result: ((_ response : [CitiesDataItem],_ filterDict : Dictionary<Character,[CitiesDataItem]>) -> ())?
    var fileName = CitiesFile.FileName
    var fileType = CitiesFile.FileType
    
    override init() {
        super.init()
    }
    
    required init(result: @escaping (_ response:[CitiesDataItem],_ filterDict : Dictionary<Character,[CitiesDataItem]>) -> Void,completionBlock: @escaping () -> Void) {
        self.result = result

        super.init()

        self.completionBlock = completionBlock
    }

    override func main() {
        if isCancelled {
            return
        }
        
        do {
            let path = Bundle.main.path(forResource: fileName, ofType: fileType) ?? ""
            let data = try Data(contentsOf: URL(fileURLWithPath:path), options: .mappedIfSafe)
            let model = try JSONDecoder().decode([CitiesDataItem].self, from: data)
            let sorted = model.sorted(by: {$0.name < $1.name})
//            let sections = Dictionary(grouping: sorted) { (city) -> Character in
//                return city.name.first!
//                }
            //Grouped in dictionary where the Key is the first letter and value is the array of cities starting with this letter
            let groups = Dictionary(grouping:  sorted) { (city) -> Character in
                return city.name.lowercased().first!
            }
            
            result!(sorted,groups)
        } catch {
            result!([],[:])
        }
    }
}

class ServiceSearch : Operation {
    
    var result: (_ response:[CitiesDataItem]) -> Void
    var text: String
    var cities: Dictionary<Character,[CitiesDataItem]>
    
    init(text : String, cities : Dictionary<Character,[CitiesDataItem]>,result: @escaping (_ response:[CitiesDataItem]) -> Void,completionBlock: @escaping () -> Void) {
        self.result = result
        self.text = text
        self.cities = cities
        
        super.init()
        
        self.completionBlock = completionBlock
    }
    
    override func main() {
        if isCancelled {
            return
        }
        
        let array = self.cities[text.lowercased().first!]
        
        //Filter Data // Linear Algorithm
        let filteredArray = array?.filter({$0.name.lowercased().hasPrefix(text.lowercased())}) ?? []
        result(filteredArray)
    }
}
