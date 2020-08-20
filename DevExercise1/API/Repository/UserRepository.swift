//
//  UserRepository.swift
//  DevExercise1
//
//  Created by Tahminur Rahman on 8/11/20.
//  Copyright © 2020 Tahminur Rahman. All rights reserved.
//

import Foundation
import ArcGIS

protocol UserRepository {
    func handleLogin(username: String, password: String, completion:@escaping(Result<(), Error>) -> Void)
    func handleSignOut(completion: @escaping () -> Void)
}

//implement named user login from arcgis
public class UserRepositoryImpl: UserRepository {
    private let userRemote: UserRemote
    private let userLocal: UserLocal

    private var userCredential: AGSCredential?

    public init(userRemote: UserRemote, userLocal: UserLocal) {
        self.userRemote = userRemote
        self.userLocal = userLocal
    }
    //create the ags credential here and sign in
    func handleLogin(username: String, password: String, completion:@escaping(Result<(), Error>) -> Void) {
        userCredential = AGSCredential(user: username, password: password)
        if username == "" {
            completion(.failure(loginError.missingUsername))
            return
        }
        if password == "" {
            completion(.failure(loginError.missingPassword))
            return
        }
        //check internet connectivity here
        userRemote.arcGISSignIn(credential: userCredential!) { result in
            switch result {
            case .success(let user):
                //handle saving this user to local here
                self.userCredential = user
                completion(.success(()))

            case .failure:
                //pass up the error
                completion(.failure(loginError.incorrectLogin))
            }

        }
        //store in user local the ags credential
    }

    func handleSignOut(completion: @escaping () -> Void) {
        userRemote.gest {
            self.userLocal.signOut()
            self.userCredential = nil
            completion()
        }

    }

}
