//
//  UserRemote.swift
//  DevExercise1
//
//  Created by Tahminur Rahman on 8/11/20.
//  Copyright © 2020 Tahminur Rahman. All rights reserved.
//

import Foundation
import ArcGIS
//signing in will be done here as well as possibly signout the results of which will be passed into the user repository
//looking into if this should instead just be a function or remain as a class
public protocol UserRemote {
    func arcGISSignIn(credential: AGSCredential)
}

public class UserRemoteImpl: UserRemote {
    
    private let portal = AGSPortal(url: URL(string: "https://www.arcgis.com")!, loginRequired: true)
    
    public func arcGISSignIn(credential: AGSCredential) {
        //print("userName:\(credential.username), password:\(credential.password) approved")
        portal.credential = credential
        self.portal.load() { [weak self] (error) in
            if let error = error {
                print(error)
                return
            }
            //check the loaded state
            if self?.portal.loadStatus == AGSLoadStatus.loaded {
                let fullname = self?.portal.user?.fullName
                print("\(fullname), \(self?.portal.user?.groups?.count)")
            }
        }
        
    }
}
