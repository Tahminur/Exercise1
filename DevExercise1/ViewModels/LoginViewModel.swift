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

    func login()

    func rememberMe()

}

public final class LoginViewModelImpl: Login {

    private let repository: UserRepositoryImpl

    public init(repository: UserRepositoryImpl) {
        self.repository = repository
    }
    //error handle to be added here
    func login() {
        repository.handleLogin()

    }

    func rememberMe() {
        print("I remember you")
    }

}
