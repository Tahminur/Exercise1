//
//  test.swift
//  DevExercise1
//
//  Created by Tahminur Rahman on 7/1/20.
//  Copyright © 2020 Tahminur Rahman. All rights reserved.
//

import Foundation
import ArcGIS

class test:UIViewController{
    var map : AGSMap!
    var mapView: AGSMapView = AGSMapView()
    let clientID:String = "ArIYjBIUXuviHDtz"
    private let portalURL = URL(string: "https://www.arcgis.com")!
    let AuthConfiguration = AGSOAuthConfiguration(portalURL: URL(string: "https://www.arcgis.com")!, clientID: "ArIYjBIUXuviHDtz", redirectURL: "https://www.arcgis.com")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(mapView)
        mapView.pin(to: view)
        self.makeMap()
        self.mapView.map = map
    }
    func makeMap(){
        let portal = AGSPortal.arcGISOnline(withLoginRequired: true)
        let portalItem = AGSPortalItem(portal: portal, itemID: "e5039444ef3c48b8a8fdc9227f9be7c1")
        map = AGSMap(item: portalItem)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        AGSAuthenticationManager.shared().delegate = self
        AGSAuthenticationManager.shared().oAuthConfigurations.add(AuthConfiguration)
    }
    
    deinit {
        AGSAuthenticationManager.shared().oAuthConfigurations.remove(AuthConfiguration)
    }
}

extension test: AGSAuthenticationManagerDelegate {
    func authenticationManager(_ authenticationManager: AGSAuthenticationManager, wantsToShow viewController: UIViewController) {
        viewController.modalPresentationStyle = .formSheet
        present(viewController, animated: true)
    }
    
    func authenticationManager(_ authenticationManager: AGSAuthenticationManager, wantsToDismiss viewController: UIViewController) {
        dismiss(animated: true)
    }
}

