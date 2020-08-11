//
//  UserRemote.swift
//  DevExercise1
//
//  Created by Tahminur Rahman on 8/11/20.
//  Copyright © 2020 Tahminur Rahman. All rights reserved.
//

import Foundation

//signing in will be done here as well as possibly signout the results of which will be passed into the user repository
//looking into if this should instead just be a function or remain as a class
public protocol UserRemote {
    func arcGISSignIn()
}

public class UserRemoteImpl: UserRemote {
    public func arcGISSignIn() {
        print("You're approved to use the app")
    }
}
