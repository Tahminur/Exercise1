//
//  SecureStoreTests.swift
//  DevExercise1Tests
//
//  Created by Tahminur Rahman on 8/23/20.
//  Copyright © 2020 Tahminur Rahman. All rights reserved.
//

import XCTest
@testable import DevExercise1

class SecureStoreTests: XCTestCase {
  var secureStoreWithGenericPwd: SecureStore!
  var secureStoreWithInternetPwd: SecureStore!
  
  override func setUp() {
    super.setUp()
    
    let genericStoreQueryable = GenericSecureStoreQueryable(service: "MyService")
    secureStoreWithGenericPwd = SecureStore(secureStoreQueryable: genericStoreQueryable)
  }

  override func tearDown() {
    try? secureStoreWithGenericPwd.removeAllValues()

    super.tearDown()
  }
  
  func testSaveGenericPassword() {
    do {
      try secureStoreWithGenericPwd.setValue("pwd_1234", for: "genericPassword")
    } catch (let e) {
      XCTFail("Saving generic password failed with \(e.localizedDescription).")
    }
  }
  
  func testReadGenericPassword() {
    do {
      try secureStoreWithGenericPwd.setValue("pwd_1234", for: "genericPassword")
      let password = try secureStoreWithGenericPwd.getValue(for: "genericPassword")
      XCTAssertEqual("pwd_1234", password)
    } catch (let e) {
      XCTFail("Reading generic password failed with \(e.localizedDescription).")
    }
  }
  
  func testUpdateGenericPassword() {
    do {
      try secureStoreWithGenericPwd.setValue("pwd_1234", for: "genericPassword")
      try secureStoreWithGenericPwd.setValue("pwd_1235", for: "genericPassword")
      let password = try secureStoreWithGenericPwd.getValue(for: "genericPassword")
      XCTAssertEqual("pwd_1235", password)
    } catch (let e) {
      XCTFail("Updating generic password failed with \(e.localizedDescription).")
    }
  }
  
  func testRemoveGenericPassword() {
    do {
      try secureStoreWithGenericPwd.setValue("pwd_1234", for: "genericPassword")
      try secureStoreWithGenericPwd.removeValue(for: "genericPassword")
      XCTAssertNil(try secureStoreWithGenericPwd.getValue(for: "genericPassword"))
    } catch (let e) {
      XCTFail("Saving generic password failed with \(e.localizedDescription).")
    }
  }
  
  func testRemoveAllGenericPasswords() {
    do {
      try secureStoreWithGenericPwd.setValue("pwd_1234", for: "genericPassword")
      try secureStoreWithGenericPwd.setValue("pwd_1235", for: "genericPassword2")
      try secureStoreWithGenericPwd.removeAllValues()
      XCTAssertNil(try secureStoreWithGenericPwd.getValue(for: "genericPassword"))
      XCTAssertNil(try secureStoreWithGenericPwd.getValue(for: "genericPassword2"))
    } catch (let e) {
      XCTFail("Removing generic passwords failed with \(e.localizedDescription).")
    }
  }
}
