//
//  CountryStorageTests.swift
//  DevExercise1Tests
//
//  Created by Tahminur Rahman on 9/9/20.
//  Copyright © 2020 Tahminur Rahman. All rights reserved.
//

import XCTest
@testable import DevExercise1

class CountryStorageTests: XCTestCase {

    var countryStorage: CountryStorage!

    override func setUp() {
        super.setUp()
        countryStorage = CountryStorageImpl()
    }

    override func tearDown() {
        super.tearDown()
        countryStorage = nil
    }

    func testSave() {
        do {
            try countryStorage.save(name: "test", cases: 34)
        } catch let error {
          XCTFail("Saving country failed with \(error.localizedDescription).")
        }
    }

    func testRetreive() {
        try! countryStorage.save(name: "test", cases: 123)
        countryStorage.retrieveFromStorage { result in
            switch result {
            case .success(let countries):
                XCTAssertNotNil(countries)
            case .failure:
                XCTFail("Error retrieving")
            }
        }
    }

    func testDelete() {
        do {
            try countryStorage.deleteEntities()
        } catch let error {
          XCTFail("Deleting countries failed with \(error.localizedDescription).")
        }
        countryStorage.retrieveFromStorage { result in
            switch result {
            case .success(let countries):
                XCTAssertEqual(countries.count, 0)
            case .failure:
                XCTFail("Error retrieving")
            }
        }
    }
}
