//
//  MapController.swift
//  DevExercise1
//
//  Created by Tahminur Rahman on 6/18/20.
//  Copyright © 2020 Tahminur Rahman. All rights reserved.
//

import Foundation
import UIKit

import ArcGIS


class MapController:UIViewController{
    //will be the page that displays the map
    var map : AGSMap!
    var mapView: AGSMapView = AGSMapView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Map"
        configureMap()
        //below returns nil for feature layers at the moment even though it correctly works for other data, most likely will have to change from weak reference to strong
        addDataLayer()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5){
            self.mapView.reloadInputViews()
        }
        
        
    }
    //below is the way that wors for individually addig feature layers to a map
    func configureMap(){
        view.addSubview(mapView)
        mapView.pin(to: view)
        map = AGSMap(basemap: .topographic())
        //map.initialViewpoint = AGSViewpoint(center: AGSPoint(x:-13176752, y: 4090404, spatialReference: .webMercator()), scale: 300000)
        self.mapView.map = map
    }
    
    
    
    func addDataLayer(){
        let featureLayer = apiManager.retrieveFeatureLayer()
        map.operationalLayers.add(featureLayer)
    }
//below was old way that works for feture layers that have been incorporated into the map already.
    func generateWebMap(){
        view.addSubview(mapView)
        mapView.pin(to: view)
        
        //displays map items correctly but does not work for the specified link for some reason
        let portal = AGSPortal(url: URL(string:"https://www.arcgis.com")!, loginRequired: false)
        //change below itemID to bbb2e4f589ba40d692fab712ae37b9ac, but right now there is an invalid response error
        let portalItem = AGSPortalItem(portal: portal, itemID: "bbb2e4f589ba40d692fab712ae37b9ac")
        map = AGSMap(item: portalItem)
        portal.credential = AGSCredential()
        self.map.load(completion: {[weak self] (error) in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            self?.mapView.map = self?.map
        })
        print(map.loadStatus.rawValue)
    }
}
