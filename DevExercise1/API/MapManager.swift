//
//  MapManager.swift
//  DevExercise1
//
//  Created by Tahminur Rahman on 7/28/20.
//  Copyright © 2020 Tahminur Rahman. All rights reserved.
//

import Foundation
import ArcGIS

class MapManager: NSObject {

    private static var _shared: MapManager?
    //ensure same instance of shared is being used
    static var shared: MapManager {
        get {
            if _shared == nil {
                _shared = MapManager()
            }
            return _shared!
        }
    }

    let portalURL: URL
    let portalItem: AGSPortalItem
    let portal: AGSPortal
    let map: AGSMap
    override init() {
        self.portalURL = URL(string: "https://arcgis.com")!
        self.portal = AGSPortal(url: portalURL, loginRequired: false)
        self.portalItem = AGSPortalItem(portal: portal, itemID: "38dd71df8d1740058b041904220013ab")
        self.map = AGSMap(item: self.portalItem)
        super.init()
        //agsauth setup
        AGSAuthenticationManager.shared().delegate = self
        let configuration = AGSOAuthConfiguration(portalURL: portalURL, clientID: "bRLWdgtj7WaPnYSY", redirectURL: nil)
        AGSAuthenticationManager.shared().oAuthConfigurations.add(configuration)
    }
}
//below url works but not the url that was given I believe this is due to the fact that I am trying to pass in credentials for a publicly accessible map layer.
//"38dd71df8d1740058b041904220013ab"
//this url doesn't work "bbb2e4f589ba40d692fab712ae37b9ac"
extension MapManager: AGSAuthenticationManagerDelegate {
    public func authenticationManager(_ authenticationManager: AGSAuthenticationManager, didReceive challenge: AGSAuthenticationChallenge) {
        let c = AGSCredential(token: "SkJ2zp4b99-Iisr9iQmyLjPliKkg1ckp5RLzbJcAUH6SWDaJcsQ_90DtPbwe8qL5AeB9r7qNnmUxB6mpeWBqMJJ4BP59BNGYwHVCZ54yG6Jux-TSVgWxm_Fgy8RBD2t3mNp4iWUg8wOzHJuEl1PZPQ..", referer: "test")
        portal.credential = c
        challenge.continue(with: c)
    }

    func refreshMap(on mapView: AGSMapView, then completion: (() -> Void)?) {
        mapView.map = nil
        self.map.load(completion: { [weak self] (error) in
            guard let strongSelf = self else {return}
            guard error == nil else {
                let msg = (error?.localizedDescription)
                print(msg)
                return
            }
            mapView.map = strongSelf.map
            if let completion = completion {
                completion()
            }
        })

    }
}
