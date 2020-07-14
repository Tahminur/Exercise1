//
//  DevExercise1Tests.swift
//  DevExercise1Tests
//
//  Created by Tahminur Rahman on 6/18/20.
//  Copyright © 2020 Tahminur Rahman. All rights reserved.
//

import XCTest
@testable import DevExercise1

class DevExercise1Tests: XCTestCase {

    var Arcgis:API!
    override func setUp(){
        // Put setup code here. This method is called before the invocation of each test method in the class.
        Arcgis = API()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        Arcgis = nil
        super.tearDown()
    }
//should return 188 countries everytime this also tests data refresh since the same function is used before the completion handler goes on
    func testDataRetrieval(){
        let expectation = self.expectation(description: "Countries Retrieved")
        Arcgis.queryFeatureLayer{
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(Arcgis.DataRetrieved.count, 188)
        
    }
    //should test that alert is displayed
    func testNoInternetConnection(){
        
    }
    
    
    
}
