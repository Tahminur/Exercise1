//
//  RemoteDataSourceTests.swift
//  DevExercise1Tests
//
//  Created by Tahminur Rahman on 7/22/20.
//  Copyright © 2020 Tahminur Rahman. All rights reserved.
//

import XCTest
@testable import DevExercise1

class RemoteDataSourceTests: XCTestCase {

    var unitTest:CountryCasesRemoteDataSource!
    
    override func setUp(){
        // Put setup code here. This method is called before the invocation of each test method in the class.
        unitTest = CountryCasesRemoteDataSource()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        unitTest = nil
        
        super.tearDown()
    }
//should return 188 countries
    func testDataRetrieval(){
        let expectation = self.expectation(description: "Countries Retrieved")
        unitTest.fetch {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(unitTest.retrieveCountries().count, 188)
    }
    func testIncorrectFeatureTable(){
        
    }
    
    
    
    
}
