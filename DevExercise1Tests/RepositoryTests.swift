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

    let failedRetrieveEndpoint = { (target: CountryProvider) -> Endpoint in
        return Endpoint(url: URL(target: target).absoluteString, sampleResponseClosure: { .networkResponse(500, Data()) }, method: target.method, task: target.task, httpHeaderFields: target.headers)
    }

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
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

    func testDataRetrievalFailure() {
        let expectation = self.expectation(description: "Failed to retrieve countries")
        let provider = MoyaProvider<CountryProvider>(endpointClosure: failedRetrieveEndpoint, stubClosure: MoyaProvider.immediatelyStub)

        provider.request(.getCountries) { result in
            switch result {
            case .success(let t):
                //checks if it has 0 bytes loaded in 
                XCTAssert(t.data == Data())
                expectation.fulfill()
            case .failure:
                expectation.fulfill()
            }
        }

        wait(for: [expectation], timeout: 10.0)
    }

}
