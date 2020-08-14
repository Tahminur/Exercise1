//
//  UserRepository.swift
//  DevExercise1
//
//  Created by Tahminur Rahman on 8/11/20.
//  Copyright © 2020 Tahminur Rahman. All rights reserved.
//

import Foundation
import ArcGIS


protocol UserRepository{
    func handleLogin(username:String, password:String)
    func handleSignOut()
}


//implement named user login from arcgis
public class UserRepositoryImpl:UserRepository {
    private let userRemote: UserRemote
    private let userLocal: UserLocal
    
    private var userCredential: AGSCredential = AGSCredential()

    public init(userRemote: UserRemote, userLocal: UserLocal) {
        self.userRemote = userRemote
        self.userLocal = userLocal
    }
    //create the ags credential here and sign in
    func handleLogin(username: String, password: String) {
        userCredential = AGSCredential(user: username, password: password)
        userRemote.arcGISSignIn(credential: userCredential)
        
        //store in user local the ags credential
    }

    func handleSignOut() {
        userLocal.signOut()
    }

}
