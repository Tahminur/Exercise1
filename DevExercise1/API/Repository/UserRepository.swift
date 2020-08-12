//
//  UserRepository.swift
//  DevExercise1
//
//  Created by Tahminur Rahman on 8/11/20.
//  Copyright © 2020 Tahminur Rahman. All rights reserved.
//

import Foundation

//implement named user login from arcgis
public class UserRepositoryImpl {
    private let userRemote: UserRemote
    private let userLocal: UserLocal

    public init(userRemote: UserRemote, userLocal: UserLocal) {
        self.userRemote = userRemote
        self.userLocal = userLocal
    }
    //create the ags credential here and sign in
    func handleLogin(username: String, password: String) {
        userRemote.arcGISSignIn(username: username, password: password)
    }

    func handleSignOut() {
        userLocal.signOut()
    }

}
