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

    var viewModel: MapViewModel = MapViewModel(map: AGSMap(basemap: .darkGrayCanvasVector()), featureURLs: [ "https://services1.arcgis.com/0MSEUqKaxRlEPj5g/arcgis/rest/services/Coronavirus_2019_nCoV_Cases/FeatureServer/2",
    "https://services1.arcgis.com/0MSEUqKaxRlEPj5g/arcgis/rest/services/Coronavirus_2019_nCoV_Cases/FeatureServer/1",
    "https://services1.arcgis.com/0MSEUqKaxRlEPj5g/arcgis/rest/services/Coronavirus_2019_nCoV_Cases/FeatureServer/0"])
    var mapView:AGSMapView = AGSMapView()
    
    
    //MARK:-View setup
    override func viewDidLoad() {
        super.viewDidLoad()
        if InternetConnection.shared.status != nil{
            self.presentAlert(message: InternetConnection.shared.status!)
        }
        navigationItem.title = "Map"
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if InternetConnection.shared.status != nil{
            self.presentAlert(message: InternetConnection.shared.status!)
        }else{
            setupMapView()
        }
        
        
    }
    func setupMapView(){
        view.addSubview(mapView)
        mapView.pin(to: view)
        do{
            try viewModel.LicenseMap()
        } catch{
            self.presentAlert(message: "Error with Licensing")
        }
        mapView.map = viewModel.map
        mapView.setViewpoint(AGSViewpoint(center: Storage.shared.point, scale: 30000000))
        
    }
}
