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
    func handleLogin(username: String, password: String, rememberMe: Bool, completion:@escaping(Result<(), Error>) -> Void)
    func handleSignOut(completion: @escaping () -> Void)
    func authenticationValid() -> String?
    var hasInitialLogin: Bool { get }
    func passSavedUser() -> [String]
}

//implement named user login from arcgis
public class UserRepositoryImpl: UserRepository {
    private let userRemote: UserRemote
    private let userLocal: UserLocal
    private var userCredential: AGSCredential?
    public var hasInitialLogin: Bool = false

    //use for invalidating session for now the expiration interval is set to 1 but have no way of checking for expired tokens
    func authenticationValid() -> String? {
        return userLocal.authenticationToken
    }

    public init(userRemote: UserRemote, userLocal: UserLocal) {
        self.userRemote = userRemote
        self.userLocal = userLocal
    }
    //create the ags credential here and sign in
    func handleLogin(username: String, password: String, rememberMe: Bool, completion:@escaping(Result<(), Error>) -> Void) {
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
                if rememberMe {
                    do {
                        try self.userLocal.rememberUser(username: user.username!, password: user.password!, token: user.token!)
                        self.hasInitialLogin = rememberMe
                    } catch {
                        //replace error here with typed error with localized description
                        completion(.failure(error))
                    }
                }
                completion(.success(()))
            case .failure:
                //pass up the error
                completion(.failure(loginError.incorrectLogin))
            }
        }
    }

    func handleSignOut(completion: @escaping () -> Void) {
        userRemote.logOut {
            if !self.hasInitialLogin {
                do {
                    try self.userLocal.signOut()
                    self.userCredential = nil
                } catch {
                    return
                }
            }
            completion()
        }
    }
    func passSavedUser() -> [String] {
        if self.hasInitialLogin {
            do {
                let creds = try userLocal.savedUser()
                return creds!
            } catch {
                print("handle error")
            }
        }
        return ["", ""]
    }
}
