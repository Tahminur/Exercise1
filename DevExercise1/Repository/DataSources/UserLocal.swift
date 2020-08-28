//
//  UserLocal.swift
//  DevExercise1
//
//  Created by Tahminur Rahman on 8/11/20.
//  Copyright © 2020 Tahminur Rahman. All rights reserved.
//

import Foundation

public protocol UserLocalDataSource {
    func rememberUser(username: String, password: String, token: String) throws
    func signOutWithRememberMe() throws
    var authenticatedUser: String? { get }
    //change to hasrememberme after confirming and add after standardstorage is made
    //var hasInitialLogin: Bool { get }
    func savedUser() throws -> User?
    func removeAllData() throws
    var authenticationToken: String? { get }
}

public class UserLocalDataSourceImpl: UserLocalDataSource {
    let secure: SecureStorage

    init(secure: SecureStorage) {
        self.secure = secure
    }

    public var authenticatedUser: String? {
        return try? secure.retrieve(item: .user)
    }

    public var authenticationToken: String? {
        return try? secure.retrieve(item: .token)
    }

    public func rememberUser(username: String, password: String, token: String) throws {
        try secure.store(value: username, item: .user)
        try secure.store(value: password, item: .password)
        try secure.store(value: token, item: .token)
    }

    public func savedUser() throws -> User? {
        let username: String? = try? secure.retrieve(item: .user)
        let password: String? = try? secure.retrieve(item: .password)
        let user: User = User(username: username, password: password)

        return user
    }

    public func signOutWithRememberMe() throws {
        try secure.delete(.token)
    }

    public func removeAllData() throws {
        try secure.removeAllData()
    }
}
