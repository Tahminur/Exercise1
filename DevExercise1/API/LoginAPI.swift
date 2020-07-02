//
//  LoginAPI.swift
//  DevExercise1
//
//  Created by Tahminur Rahman on 7/1/20.
//  Copyright © 2020 Tahminur Rahman. All rights reserved.
//

import Foundation
import Firebase

class AuthServices{
    static let handler = AuthServices()
    
    func logUserIn(email: String, password: String, completion: AuthDataResultCallback?){
        print("DEBUG:email:\(email) password: \(password)")
        
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
}
