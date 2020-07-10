//
//  MapViewController.swift
//  DevExercise1
//
//  Created by Tahminur Rahman on 7/7/20.
//  Copyright © 2020 Tahminur Rahman. All rights reserved.
//

import Foundation
import ArcGIS

class MapViewController:UIViewController{
    //
    var viewModel: MapViewModel = MapViewModel(map: AGSMap(basemap: .topographic()), featureURLs: [ "https://services1.arcgis.com/0MSEUqKaxRlEPj5g/arcgis/rest/services/Coronavirus_2019_nCoV_Cases/FeatureServer/2",
    "https://services1.arcgis.com/0MSEUqKaxRlEPj5g/arcgis/rest/services/Coronavirus_2019_nCoV_Cases/FeatureServer/1",
    "https://services1.arcgis.com/0MSEUqKaxRlEPj5g/arcgis/rest/services/Coronavirus_2019_nCoV_Cases/FeatureServer/0"])
    var mapView:AGSMapView = AGSMapView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMapView()
        navigationItem.title = "New Map"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.mapView.setViewpoint(AGSViewpoint(center: CountryStorage.shared.point, scale: 30000000))
    }
    
    func setupMapView(){
        view.addSubview(mapView)
        mapView.pin(to: view)
        mapView.map = viewModel.map
    }
    
    
}
