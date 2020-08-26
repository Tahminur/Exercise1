//
//  UserDIContainer.swift
//  DevExercise1
//
//  Created by Tahminur Rahman on 8/11/20.
//  Copyright © 2020 Tahminur Rahman. All rights reserved.
//

import Foundation

final class UserDIContainer {

    struct Dependencies {
        let userRepo: UserRepositoryImpl
    }

    private let dependencies: Dependencies

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }

    func makeLoginViewModel() -> Login {
        return LoginViewModelImpl(repository: dependencies.userRepo)
    }

    func makeLoginViewController() -> LoginViewController {
        return LoginViewController.create(with: makeLoginViewModel())
    }

    func makeSignOutViewModel() -> SignOutUseCase {
        return SignOutViewModelImpl(repository: dependencies.userRepo)
    }

    func makeSignOutController() -> SignOutController {
        return SignOutController.create(with: makeSignOutViewModel())
    }

}
