//
//  LoginViewModel.swift
//  DevExercise1
//
//  Created by Tahminur Rahman on 8/11/20.
//  Copyright © 2020 Tahminur Rahman. All rights reserved.
//

import Foundation

//will have access to user repo
protocol LoginUseCase {
    func login(username: String, password: String, rememberMe: Bool, completion:@escaping(Result<(), Error>) -> Void)
    var rememberMe: Bool { get set }
    func reset()
    func savedCredentials(completion: @escaping(Result<User, Error>) -> Void)
}

public final class LoginViewModelImpl: LoginUseCase {

    private let repository: UserRepositoryImpl
    var rememberMe: Bool = false
    public init(repository: UserRepositoryImpl) {
        self.repository = repository
    }

    func savedCredentials(completion: @escaping(Result<User, Error>) -> Void) {
        repository.passSavedUser { result in
            switch result {
            case .success(let creds):
                completion(.success(creds))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

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
