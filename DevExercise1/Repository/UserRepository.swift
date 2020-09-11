//
//  UserRepository.swift
//  DevExercise1
//
//  Created by Tahminur Rahman on 8/11/20.
//  Copyright © 2020 Tahminur Rahman. All rights reserved.
//

import Foundation

public typealias PossibleErrorComplete = (Error?) -> Void

protocol UserRepository {
    func handleLogin(username: String, password: String, rememberMe: Bool, completion:@escaping PossibleErrorComplete)
    func handleSignOut(completion: @escaping PossibleErrorComplete)
    func authenticationValid() -> Bool
    var hasInitialLogin: Bool { get }
    func passSavedUser(completion: @escaping (Result<User, Error>) -> Void)
}

public class UserRepositoryImpl: UserRepository {
    private let userRemote: UserRemoteDataSource
    private let userLocal: UserLocalDataSource
    private let internetConnection: ReachabilityObserverDelegate
    public var hasInitialLogin: Bool = false

    func authenticationValid() -> Bool {
        if userLocal.authenticationToken == nil {
            return false
        } else {
            return true
        }
    }

    public init(userRemote: UserRemoteDataSource, userLocal: UserLocalDataSource, internetConnection: ReachabilityObserverDelegate) {
        self.userRemote = userRemote
        self.userLocal = userLocal
        self.internetConnection = internetConnection
    }

    func handleLogin(username: String, password: String, rememberMe: Bool, completion: @escaping PossibleErrorComplete) {
        if !internetConnection.connectionStatus {
            completion(loginError.noInternet)
            return
        }
        if username == "" {
            completion(loginError.missingUsername)
            return
        }
        if password == "" {
            completion(loginError.missingPassword)
            return
        }

        userRemote.arcGISSignIn(username: username, password: password) { result in
            switch result {
            case .success(let user):
                //handle saving this user to local here
                if rememberMe == true {
                    do {
                        try self.userLocal.rememberUser(username: user.username!, password: user.password!, token: user.token!)
                        self.hasInitialLogin = rememberMe
                    } catch {
                        completion(loginError.rememberMeMalfunction)
                    }
                }
                completion(nil)
            case .failure:
                completion(loginError.incorrectLogin)
            }
        }
    }
//signs out and based on initial login status also deletes userlocal data
    func handleSignOut(completion: @escaping PossibleErrorComplete) {
        userRemote.logOut { error in
            completion(error)
        }
    }
    //passes the user credentials in a model format upon success for remember me
    func passSavedUser(completion: @escaping (Result<User, Error>) -> Void) {
        if self.hasInitialLogin {
            do {
                let creds = try userLocal.savedUser()
                self.hasInitialLogin = false
                completion(.success(creds!))
            } catch {
                completion(.failure(loginError.issueWithCredentials))
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
