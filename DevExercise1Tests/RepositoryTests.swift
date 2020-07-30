//
//  RepositoryTests.swift
//  DevExercise1Tests
//
//  Created by Tahminur Rahman on 7/22/20.
//  Copyright © 2020 Tahminur Rahman. All rights reserved.
//

import XCTest
import ArcGIS
@testable import DevExercise1

class RepositoryTests: XCTestCase {

    var countryRemoteDataSource: CountryCasesRemoteDataSource!
    var features: [AGSArcGISFeature]!
    var errorFromFetch: fetchError!
    
    override func setUp(){
        // Put setup code here. This method is called before the invocation of each test method in the class.
        countryRemoteDataSource = CountryCasesRemoteDataSource()
        features = []
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        countryRemoteDataSource = nil
        features = nil
        errorFromFetch = nil
        super.tearDown()
    }

    func testDataRetrieval(){
        let expectation = self.expectation(description: "Countries Retrieved")
        countryRemoteDataSource.fetch(){ results in
            switch results{
            case .success(let retrieved):
                self.features = retrieved
            case .failure(_):
                return
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(features.count, 188)
    }
    
    func testDataRetrievalFailure(){
        let expectation = self.expectation(description: "Failed to retrieve countries")
        countryRemoteDataSource.featureTable = AGSServiceFeatureTable(url: URL(string: "https://www.arcgis.com/home/index.html")!)
        countryRemoteDataSource.fetch(){results in
            switch results{
                case .success(let retrieved):
                    self.features = retrieved
                case .failure(let error):
                    self.errorFromFetch = error
                }
                expectation.fulfill()
            }
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssert(errorFromFetch != nil)
    }
    
}
