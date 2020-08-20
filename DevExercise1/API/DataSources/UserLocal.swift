//
//  UserLocal.swift
//  DevExercise1
//
//  Created by Tahminur Rahman on 8/11/20.
//  Copyright © 2020 Tahminur Rahman. All rights reserved.
//

import Foundation

public protocol UserLocal {
    func rememberUser(username: String, password: String, token: String) throws

    func signOut() throws
    
    var authenticatedUser: String? { get }
    //change to hasrememberme after confirming and add after standardstorage is made
    //var hasInitialLogin: Bool { get }
    func removeAllData() throws
}

public class UserLocalImpl: UserLocal {
    let secure: SecureStorage
    
    init(secure:SecureStorage){
        self.secure = secure
    }
    
    public var authenticatedUser: String? {
        return try? secure.retrieve(item: .user)
    }
    
    
    
    /*public var hasInitialLogin: Bool {
        return
    }*/
    
    //user defaults updated here in remember user call look into how
    public func rememberUser(username: String, password: String, token: String) throws {
        try secure.store(value: username, item: .user)
        try secure.store(value: password, item: .password)
        try secure.store(value: token, item: .token)
    }

    
    public func signOut() throws{
        print("Signing out and forgetting unless remember me checked")
        try secure.delete(.user,.password, .token)
    }
    
    public func removeAllData() throws {
        try secure.removeAllData()
    }
}
