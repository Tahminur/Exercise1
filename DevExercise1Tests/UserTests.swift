//
//  UserTests.swift
//  DevExercise1Tests
//
//  Created by Tahminur Rahman on 8/29/20.
//  Copyright © 2020 Tahminur Rahman. All rights reserved.
//

import XCTest
import ArcGIS
//issue with mockingbird here that didn't allow me to create mocks of the user repository for some reason
@testable import DevExercise1

class UserTests: XCTestCase {
    var loginViewModel: LoginViewModelImpl!
    var userRepository: UserRepositoryImpl!
    var userRemote: UserRemoteDataSourceImpl!
    var userLocal: UserLocalDataSourceImpl!

    var signOutViewModel: SignOutViewModelImpl!

    override func setUp() {
        super.setUp()
        userRemote = UserRemoteDataSourceImpl()
        userLocal = UserLocalDataSourceImpl(secure: SecureDataStorage())

        userRepository = UserRepositoryImpl(userRemote: userRemote, userLocal: userLocal, internetConnection: InternetConnectivity())
        loginViewModel = LoginViewModelImpl(repository: userRepository)
        signOutViewModel = SignOutViewModelImpl(repository: userRepository)
    }

    override func tearDown() {
        super.tearDown()
        userRemote = nil
        userLocal = nil
        userRepository = nil
        loginViewModel = nil
        signOutViewModel = nil
    }

    func testLoginFailureNoUsername() {
        loginViewModel.login(username: "", password: "", rememberMe: false) { error in
            guard error == nil else {
                XCTAssertEqual(error as! loginError, loginError.missingUsername)
                return
            }
        }
    }

    func testLoginFailureNoPassword() {
        loginViewModel.login(username: "test", password: "", rememberMe: false) { error in
            guard error == nil else {
                XCTAssertEqual(error as! loginError, loginError.missingPassword)
                return
            }
        }
    }

    func testLoginFailure() {
        loginViewModel.login(username: "test", password: "tyh", rememberMe: false) { error in
            guard error == nil else {
                XCTAssertEqual(error as! loginError, loginError.incorrectLogin)
                return
            }
        }
    }

    func testSignOut() {
        signOutViewModel.signOut { result in
            switch result {
            case .success(let success):
                //shouldn't reach here
                XCTAssertNotNil(success)
            case .failure(let error):
                XCTAssertNil(error)
            }
        }
    }

}
