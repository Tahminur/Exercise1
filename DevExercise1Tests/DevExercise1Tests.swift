//
//  DevExercise1Tests.swift
//  DevExercise1Tests
//
//  Created by Tahminur Rahman on 6/18/20.
//  Copyright © 2020 Tahminur Rahman. All rights reserved.
//

import XCTest
import ArcGIS
@testable import DevExercise1

class DevExercise1Tests: XCTestCase {

    var cell: CountryCell!
    var nilPointCountry: Country!
    var mapper: CountryMapper!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        cell = CountryCell()
        mapper = CountryMapperImplemetation()
        nilPointCountry = Country(name: "TestCountry", cases: 0, point: nil)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        nilPointCountry = nil
        cell = nil
        super.tearDown()
    }

    func testCountryCellSet() {
        cell.set(country: nilPointCountry)
        XCTAssert(cell.textLabel?.text == "\(nilPointCountry.name) : \(nilPointCountry.cases)")
    }

    func testCountryMapper() {

    }
}
