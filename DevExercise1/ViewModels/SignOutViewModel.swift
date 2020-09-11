//
//  SignOutViewModel.swift
//  DevExercise1
//
//  Created by Tahminur Rahman on 8/11/20.
//  Copyright © 2020 Tahminur Rahman. All rights reserved.
//

import Foundation

protocol SignOutUseCase {
    func signOut(completion:@escaping PossibleErrorComplete)
}

public final class SignOutViewModelImpl: SignOutUseCase {
    private let repository: UserRepositoryImpl

    public init(repository: UserRepositoryImpl) {
        self.repository = repository
    }
    func signOut(completion:@escaping PossibleErrorComplete) {
        repository.handleSignOut { error in
            completion(error)
        }
    }
}
