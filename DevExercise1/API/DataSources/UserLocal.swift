//
//  UserLocal.swift
//  DevExercise1
//
//  Created by Tahminur Rahman on 8/11/20.
//  Copyright © 2020 Tahminur Rahman. All rights reserved.
//

import Foundation

public protocol UserLocal {
    func rememberUser()

    func signOut()
}

public class UserLocalImpl: UserLocal {
    public func rememberUser() {
        print("ya I remember I stored you in either in secure storage or standard storage")
    }

    public func signOut() {
        print("Signing out and forgetting unless remember me checked")
    }
}
