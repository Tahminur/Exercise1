//
//  UserRepository.swift
//  DevExercise1
//
//  Created by Tahminur Rahman on 8/11/20.
//  Copyright © 2020 Tahminur Rahman. All rights reserved.
//

import Foundation

public class UserRepositoryImpl {
    private let userRemote: UserRemote
    private let userLocal: UserLocal

    public init(userRemote: UserRemote, userLocal: UserLocal) {
        self.userRemote = userRemote
        self.userLocal = userLocal
    }

    func handleLogin() {
        userRemote.arcGISSignIn()
    }

    func handleSignOut() {
        userLocal.signOut()
    }

}
