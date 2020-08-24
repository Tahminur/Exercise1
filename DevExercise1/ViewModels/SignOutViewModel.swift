//
//  SignOutViewModel.swift
//  DevExercise1
//
//  Created by Tahminur Rahman on 8/11/20.
//  Copyright © 2020 Tahminur Rahman. All rights reserved.
//

import Foundation

protocol SignOut {
    func signOut(completion:@escaping (Result<(), Error>) -> Void)
}

public final class SignOutImpl: SignOut {
    private let repository: UserRepositoryImpl

    public init(repository: UserRepositoryImpl) {
        self.repository = repository
    }
    func signOut(completion:@escaping ((Result<(), Error>)) -> Void) {
        repository.handleSignOut { result in
            switch result {
            case .success(()):
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
