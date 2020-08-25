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
    func handleSignOut(completion: @escaping (Result<(), Error>) -> Void)
    func authenticationValid() -> String?
    var hasInitialLogin: Bool { get }
    func passSavedUser(completion: @escaping (Result<[String], Error>) -> Void)
}

//implement named user login from arcgis
public class UserRepositoryImpl: UserRepository {
    private let userRemote: UserRemote
    private let userLocal: UserLocal
    private var userCredential: AGSCredential?
    public var hasInitialLogin: Bool = false

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
                if rememberMe == true {
                    do {
                        try self.userLocal.rememberUser(username: user.username!, password: user.password!, token: user.token!)
                        self.hasInitialLogin = rememberMe
                    } catch {
                        completion(.failure(loginError.rememberMeMalfunction))
                    }
                }
                completion(.success(()))
            case .failure:
                completion(.failure(loginError.incorrectLogin))
            }
        }
    }

    func handleSignOut(completion: @escaping (Result<(), Error>) -> Void) {
        userRemote.logOut { result in
            switch result {
            case .success:
                if !self.hasInitialLogin {
                    do {
                        try self.userLocal.removeAllData()
                        self.userCredential = nil
                    } catch {
                        return
                    }
                } else {
                    do {
                        try self.userLocal.signOutWithRememberMe()
                        self.userCredential = nil
                    } catch {
                        return
                    }
                }
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
            if !self.hasInitialLogin {
                do {
                    try self.userLocal.removeAllData()
                    self.userCredential = nil
                } catch {
                    return
                }
            } else {
                do {
                    try self.userLocal.signOutWithRememberMe()
                    self.userCredential = nil
                } catch {
                    return
                }
            }
        }
    }

    func passSavedUser(completion: @escaping (Result<[String], Error>) -> Void) {
        if self.hasInitialLogin {
            do {
                let creds = try userLocal.savedUser()
                self.hasInitialLogin = false
                if creds == nil {
                    completion(.success(["", ""]))
                } else {
                    completion(.success(creds!))
                }
            } catch {
                //replace this with correct errors
                completion(.failure(loginError.noInternet))
            }
        }
    }
    //using currently to reset all saved credentials to the keychain
    func reset() {
        do {
            try userLocal.removeAllData()
        } catch {
            print("nothing in local")
        }
    }
}
