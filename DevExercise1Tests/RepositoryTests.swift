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
import Mockingbird

@testable import DevExercise1
//change tests so they do not rely on network connectivity
class RepositoryTests: XCTestCase {

    let failedRetrieveEndpoint = { (target: CountryProvider) -> Endpoint in
        return Endpoint(url: URL(target: target).absoluteString, sampleResponseClosure: { .networkResponse(500, Data()) }, method: target.method, task: target.task, httpHeaderFields: target.headers)
    }
    var dataSource: CountryRemoteDataSourceImplMock!
    var repo: CountryRepositoryImpl!
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        dataSource = mock(CountryRemoteDataSourceImpl.self)
        repo = CountryRepositoryImpl(remoteDataSource: dataSource, internetConnection: InternetConnectivity())
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        reset(dataSource)
        super.tearDown()
    }

    func testRetrieveData() {
        let expectation = XCTestExpectation(description: "Fetching countries from API")
        let provider = MoyaProvider<CountryProvider>(stubClosure: MoyaProvider.immediatelyStub)

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
            case .success(let emptyFeature):
                //checks if it has 0 bytes loaded in 
                XCTAssert(emptyFeature.data == Data())
                expectation.fulfill()
            case .failure:
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 10.0)
    }

    func testDataSourceFetch() {
        given(dataSource.fetch(completion: any())) ~> {completion in
            completion(.success([]))
        }
        let expectation = eventually {
            verify(
                dataSource.fetch(completion: any())
            ).wasCalled()
        }
        repo.fetch(forceRefresh: true) { _ in}
        wait(for: [expectation], timeout: 5.0)

    }
}
