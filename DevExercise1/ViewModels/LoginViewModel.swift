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

    func signIn()

    func rememberMe()

}

public final class LoginViewModelImpl: Login {
    func signIn() {
        print("nothing yet")
    }

    func rememberMe() {
        print("I remember you from user repo/ signed in before")
    }

}
