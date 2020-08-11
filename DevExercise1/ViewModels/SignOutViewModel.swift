//
//  SignOutViewModel.swift
//  DevExercise1
//
//  Created by Tahminur Rahman on 8/11/20.
//  Copyright © 2020 Tahminur Rahman. All rights reserved.
//

import Foundation

protocol SignOut {
    func signOut()
}

public final class SignOutImpl: SignOut {
    private let repository: UserRepositoryImpl

    public init(repository: UserRepositoryImpl) {
        self.repository = repository
    }
    //error handling
    func signOut() {
        repository.handleSignOut()
    }

}
