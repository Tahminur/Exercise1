//
//  SignOutViewModel.swift
//  DevExercise1
//
//  Created by Tahminur Rahman on 8/11/20.
//  Copyright © 2020 Tahminur Rahman. All rights reserved.
//

import Foundation

protocol SignOut {
    func signOut(completion:@escaping () -> Void)
}

public final class SignOutImpl: SignOut {
    private let repository: UserRepositoryImpl

    public init(repository: UserRepositoryImpl) {
        self.repository = repository
    }
    //error handling
    func signOut(completion:@escaping () -> Void) {
        repository.handleSignOut(){
            completion()
        }
    }
}
