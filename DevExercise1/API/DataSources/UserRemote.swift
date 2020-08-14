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
public protocol UserRemote {
    func arcGISSignIn(credential: AGSCredential, completion:@escaping (Result<AGSPortalUser, Error>) -> Void)
}

public class UserRemoteImpl: UserRemote {
    //in field mobility app we can make it be the pseg portal possibly?
    private let portal = AGSPortal(url: URL(string: "https://www.arcgis.com")!, loginRequired: true)
    //func fetch(completion:@escaping (Result<[AGSArcGISFeature], fetchError>) -> Void)
    public func arcGISSignIn(credential: AGSCredential, completion:@escaping (Result<AGSPortalUser, Error>) -> Void) {
        //print("userName:\(credential.username), password:\(credential.password) approved")
        
        portal.credential = credential
        self.portal.load() { [weak self] (error) in
            if let error = error {
                print(error)
                completion(.failure(error))
                return
            }
            //check the loaded state
            if self?.portal.loadStatus == AGSLoadStatus.loaded {
                let fullname = self?.portal.user?.fullName
                print("\(fullname), \(credential.token)")
                completion(.success(self!.portal.user!))
            }
        }
        
    }
}
