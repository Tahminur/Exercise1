//
//  MapperTests.swift
//  DevExercise1Tests
//
//  Created by Tahminur Rahman on 8/29/20.
//  Copyright © 2020 Tahminur Rahman. All rights reserved.
//

import XCTest
import Moya
import ArcGIS

@testable import DevExercise1


class MapperTests: XCTestCase {
    
    var countryMapper: CountryMapperImplMock!
    var calloutMapper: CalloutMapperImplMock!

    override func setUp() {
        super.setUp()
        countryMapper = mock(CountryMapperImpl.self)
        calloutMapper = mock(CalloutMapperImpl.self)
    }

    override func tearDown() {
        super.tearDown()
    }
    
    func testCountryMapper() {
        let expectation = XCTestExpectation(description: "Fetching countries from API")
        

        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testCalloutMapper() {
        
    }
}
