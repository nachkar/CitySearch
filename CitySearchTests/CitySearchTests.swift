//
//  CitySearchTests.swift
//  CitySearchTests
//
//  Created by Noel Achkar on 9/28/20.
//

import XCTest
@testable import CitySearch

class CitySearchTests: XCTestCase {

    let viewModel = CitiesViewModel()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        openFileAndProcess()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCitySearch() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        viewModel.filterData(text: "hur", result: { response in
            let firstCity = response[0]
            XCTAssertEqual(firstCity.name,CitiesDataItem.getCity().name)
            XCTAssertEqual(firstCity.coord.lat,CitiesDataItem.getCity().coord.lat)
            XCTAssertEqual(firstCity.coord.lon,CitiesDataItem.getCity().coord.lon)
        })
        
        viewModel.filterData(text: "nov", result: { response in
            let firstCity = response[0]
            XCTAssertNotEqual(firstCity.name,CitiesDataItem.getCity().name)
            XCTAssertNotEqual(firstCity.coord.lat,CitiesDataItem.getCity().coord.lat)
            XCTAssertNotEqual(firstCity.coord.lon,CitiesDataItem.getCity().coord.lon)
        })
        
        viewModel.filterData(text: "abc", result: { response in
            XCTAssertEqual(response.count, 0)
        })
    }
    
    func openFileAndProcess() {
        let testExp = XCTestExpectation(description: "Read and process file")
        
        viewModel.getCities(JsonFile.fileName,JsonFile.fileType,result: {response in
            self.viewModel.tmpArray = response
            
            let firstCity = response[0]
            XCTAssertEqual(firstCity.name,CitiesDataItem.getCity().name)
            XCTAssertEqual(firstCity.coord.lat,CitiesDataItem.getCity().coord.lat)
            XCTAssertEqual(firstCity.coord.lon,CitiesDataItem.getCity().coord.lon)
            
            testExp.fulfill()
        })
        
        wait(for: [testExp], timeout: 5.0)
    }
    
    func testPerformance() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}

internal extension CitiesDataItem {
    static func getCity() -> CitiesDataItem {
        return CitiesDataItem.init(name: "Hurzuf", _id: 707860, coord: Coord.init(lon: 34.283333, lat: 44.549999), country: "UA")
    }
}

internal struct JsonFile {
    static let fileName = "citiesTest"
    static let fileType = "json"
}
