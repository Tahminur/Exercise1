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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupViewLoad()
        
    }
    
    func setupViewLoad(){
        view.backgroundColor = .white
        navigationItem.title = "Map"
        configureMap()
        addDataLayers()
    }
    
    func configureMap(){
        view.addSubview(mapView)
        mapView.pin(to: view)
        map = AGSMap(basemap: .topographic())
        //initially over australia
        map.initialViewpoint = AGSViewpoint(center: selectedPoint, scale: 30000000)
        self.mapView.map = map
    }
    
    
    
    func addDataLayers(){
        let countryLayer = AGSFeatureLayer(featureTable: apiManager.CountryFeatureTable)
        let casesLayer = AGSFeatureLayer(featureTable: apiManager.CasesFeatureTable)
        let deathsLayer = AGSFeatureLayer(featureTable: apiManager.DeathsFeatureTable)
        
        map.operationalLayers.add(countryLayer)
        map.operationalLayers.add(casesLayer)
        map.operationalLayers.add(deathsLayer)
    }
    
}


