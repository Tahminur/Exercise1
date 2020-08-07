//
//  RepositoryTests.swift
//  DevExercise1Tests
//
//  Created by Tahminur Rahman on 7/22/20.
//  Copyright © 2020 Tahminur Rahman. All rights reserved.
//

import XCTest
import ArcGIS
import Moya

@testable import DevExercise1
//change tests so they do not rely on network connectivity
class RepositoryTests: XCTestCase {

    var countryRemoteDataSource: CountryRemoteDataSource!
    var features: [AGSArcGISFeature]!
    var errorFromFetch: fetchError!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        countryRemoteDataSource = CountryRemoteDataSourceImplementation()
        features = []
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        countryRemoteDataSource = nil
        features = nil
        errorFromFetch = nil
        super.tearDown()
    }

    func testRetrieveData() {
        let expectation = XCTestExpectation(description: "Fetching countries from API")

        let provider = MoyaProvider<CountryProvider>(stubClosure: MoyaProvider.immediatelyStub)
        //remote =
        provider.request(.getCountries) { result in
            switch result {
            case .success(let retrieved):
                XCTAssertNotNil(retrieved.data)
                expectation.fulfill()
            case .failure:
                XCTFail("Jobs should be correctly passed")
            }

        }
        wait(for: [expectation], timeout: 10.0)
    }

/*    func testDataRetrievalFailure() {
        let expectation = self.expectation(description: "Failed to retrieve countries")
        //countryRemoteDataSource.featureTable = AGSServiceFeatureTable(url: URL(string: "https://www.arcgis.com/home/index.html")!)
        countryRemoteDataSource.fetch {results in
            switch results {
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
*/
}
