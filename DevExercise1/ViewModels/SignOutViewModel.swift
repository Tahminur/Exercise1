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
    func signOut() {
        print("I'm signing out and updating my user repository")
    }

}
