//
//  RepositoryTests.swift
//  DevExercise1Tests
//
//  Created by Tahminur Rahman on 7/22/20.
//  Copyright © 2020 Tahminur Rahman. All rights reserved.
//

import XCTest
@testable import DevExercise1

class RepositoryTests: XCTestCase {

    override func setUp(){
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        super.tearDown()
    }
//should return 188 countries everytime this also tests data refresh since the same function is used before the completion handler goes on
    func testDataRetrieval(){
        /*let expectation = self.expectation(description: "Countries Retrieved")
        Arcgis.queryFeatureLayer{
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(Arcgis.DataRetrieved.count, 188)*/
        
    }
    //check storage for countries once
    func testStorage(){
        
    }

    
    
    
}
