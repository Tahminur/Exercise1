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
    func arcGISSignIn(credential: AGSCredential, completion:@escaping (Result<AGSCredential, Error>) -> Void)
    func gest(completion: @escaping () -> Void)
}

public class UserRemoteImpl: NSObject, UserRemote {
    //in field mobility app we can make it be the pseg portal possibly?
    private var portal: AGSPortal = AGSPortal(url: URL(string: "https://www.arcgis.com")!, loginRequired: true)

    public func arcGISSignIn(credential: AGSCredential, completion:@escaping (Result<AGSCredential, Error>) -> Void) {
        //resets portal
        self.portal = AGSPortal(url: URL(string: "https://www.arcgis.com")!, loginRequired: true)
        portal.credential = credential
        self.portal.load { [weak self] (error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            //check the loaded state
            if self?.portal.loadStatus == AGSLoadStatus.loaded {
                completion(.success(self!.portal.credential!))
            }
        }
    }
    public func gest(completion: @escaping () -> Void) {
        AGSAuthenticationManager.shared().credentialCache.removeAndRevokeCredential(self.portal.credential!) { [weak self] (error) in
            if let error = error {
                print(error)
                return
            }
            completion()
        }
    }
    override init() {
        super.init()
        AGSAuthenticationManager.shared().delegate = self
        let configuration = AGSOAuthConfiguration(portalURL: URL(string: "https://www.arcgis.com")!, clientID: "bRLWdgtj7WaPnYSY", redirectURL: "https://www.arcgis.com")
        configuration.refreshTokenExchangeInterval = 1
        AGSAuthenticationManager.shared().oAuthConfigurations.add(configuration)
    }
}

extension UserRemoteImpl: AGSAuthenticationManagerDelegate {
    public func authenticationManager(_ authenticationManager: AGSAuthenticationManager, didReceive challenge: AGSAuthenticationChallenge) {
        //need to pass the credential token generated by the authentication challenge here
        //let c = AGSCredential(token: "SkJ2zp4b99-Iisr9iQmyLjPliKkg1ckp5RLzbJcAUH6SWDaJcsQ_90DtPbwe8qL5AeB9r7qNnmUxB6mpeWBqMJJ4BP59BNGYwHVCZ54yG6Jux-TSVgWxm_Fgy8RBD2t3mNp4iWUg8wOzHJuEl1PZPQ..", referer: "test")
        //let c = portal.credential
        //portal.credential = c
        challenge.continue(with: portal.credential)
    }

}
