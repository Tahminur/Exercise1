//
//  LoginViewModel.swift
//  DevExercise1
//
//  Created by Tahminur Rahman on 8/11/20.
//  Copyright © 2020 Tahminur Rahman. All rights reserved.
//

import Foundation

//will have access to user repo
protocol Login {

    func login(username: String, password: String, rememberMe: Bool, completion:@escaping(Result<(), Error>) -> Void)
    var rememberMe: Bool { get set }
    var username: String { get }
    var password: String { get }
    func reset()
}

public final class LoginViewModelImpl: Login {

    private let repository: UserRepositoryImpl
    var username: String
    var password: String
    var rememberMe: Bool = false

    public init(repository: UserRepositoryImpl) {
        self.repository = repository
        username = repository.passSavedUser()[0]
        password = repository.passSavedUser()[1]
    }
    //error handle to be added here
    func login(username: String, password: String, rememberMe: Bool, completion:@escaping(Result<(), Error>) -> Void) {
        repository.handleLogin(username: username, password: password, rememberMe: rememberMe) { result in
            switch result {
            case .success:
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func reset() {
        repository.reset()
    }
}
