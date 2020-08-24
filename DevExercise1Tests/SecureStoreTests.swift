//
//  SecureStoreTests.swift
//  DevExercise1Tests
//
//  Created by Tahminur Rahman on 8/23/20.
//  Copyright © 2020 Tahminur Rahman. All rights reserved.
//

import XCTest
@testable import DevExercise1

//this file just tests the secure store files which are the base for the remember me functions
class SecureStoreTests: XCTestCase {
  var secureStoreWithPwd: SecureStore!
  
  override func setUp() {
    super.setUp()
    
    let genericStoreQueryable = GenericSecureStoreQueryable(service: "TestService")
    secureStoreWithPwd = SecureStore(secureStoreQueryable: genericStoreQueryable)
  }

  override func tearDown() {
    try? secureStoreWithPwd.removeAllValues()

    super.tearDown()
  }
  
  func testSaveGenericPassword() {
    do {
      try secureStoreWithPwd.setValue("password", for: "somePass")
    } catch (let error) {
      XCTFail("Saving password failed with \(error.localizedDescription).")
    }
  }
  
  func testReadPassword() {
    do {
      try secureStoreWithPwd.setValue("password", for: "somePass")
      let password = try secureStoreWithPwd.getValue(for: "somePass")
      XCTAssertEqual("password", password)
    } catch (let error) {
      XCTFail("Reading password failed with \(error.localizedDescription).")
    }
  }
  
  func testUpdatePassword() {
    do {
      try secureStoreWithPwd.setValue("password", for: "somePass")
      try secureStoreWithPwd.setValue("newPassword", for: "somePass")
      let password = try secureStoreWithPwd.getValue(for: "somePass")
      XCTAssertEqual("newPassword", password)
    } catch (let error) {
      XCTFail("Updating password failed with \(error.localizedDescription).")
    }
  }
  
  func testRemovePassword() {
    do {
      try secureStoreWithPwd.setValue("password", for: "somePass")
      try secureStoreWithPwd.removeValue(for: "somePass")
      XCTAssertNil(try secureStoreWithPwd.getValue(for: "somePass"))
    } catch (let error) {
      XCTFail("Saving password failed with \(error.localizedDescription).")
    }
  }
  
  func testRemoveAllPasswords() {
    do {
      try secureStoreWithPwd.setValue("password", for: "somePass")
      try secureStoreWithPwd.setValue("newPassword", for: "somePass2")
      try secureStoreWithPwd.removeAllValues()
      XCTAssertNil(try secureStoreWithPwd.getValue(for: "somePass"))
      XCTAssertNil(try secureStoreWithPwd.getValue(for: "somePass2"))
    } catch (let error) {
      XCTFail("Removing both passwords failed with \(error.localizedDescription).")
    }
  }
}
