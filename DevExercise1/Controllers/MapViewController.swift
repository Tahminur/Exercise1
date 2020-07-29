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

    /*var viewModel: MapViewModel = MapViewModel(map: AGSMap(basemap: .darkGrayCanvasVector()), featureURLs: [ "https://services1.arcgis.com/0MSEUqKaxRlEPj5g/arcgis/rest/services/Coronavirus_2019_nCoV_Cases/FeatureServer/2",
    "https://services1.arcgis.com/0MSEUqKaxRlEPj5g/arcgis/rest/services/Coronavirus_2019_nCoV_Cases/FeatureServer/1",
    "https://services1.arcgis.com/0MSEUqKaxRlEPj5g/arcgis/rest/services/Coronavirus_2019_nCoV_Cases/FeatureServer/0"])*/
    //move this to the dependency injection
    //var viewModel: MapViewModel = MapViewModel(repository: MapRepository(remoteDataSource: MapRemoteDataSource()))
    //var mapView:AGSMapView = AGSMapView()
    //var map:AGSMap = AGSMap(basemap: .darkGrayCanvasVector())
    //var portalItem = AGSPortalItem(portal: AGSPortal(url: URL(string: "https://arcgis.com")!, loginRequired: false), itemID: "bbb2e4f589ba40d692fab712ae37b9ac")
    var mapView:AGSMapView = AGSMapView()
    //MARK:-View setup
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapView.wrapAroundMode = .enabledWhenSupported
        navigationItem.title = "Map"
        //setupMapView()
        setupMap()
    }
    
    
    func setupMap(){
        
        DispatchQueue.main.async {
            self.view.addSubview(self.mapView)
            self.mapView.pin(to: self.view)
            MapManager.shared.refreshMap(on: self.mapView, then: nil)
        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(mapView.map?.operationalLayers.count)
        //mapView.setViewpoint(AGSViewpoint(center: Storage.shared.point, scale: 30000000))
    }
    /*func setupMapView(){
        view.addSubview(mapView)
        mapView.pin(to: view)
        do{
            try viewModel.licenseMap()
        } catch{
            self.presentAlert(message: "Error with Licensing")
        }
        //need to use completion for this
        DispatchQueue.main.async {
            for feature in self.viewModel.featureLayers{
                self.map.operationalLayers.add(feature)
            }
            self.mapView.map = self.map
        }
        
        
        
    }
    func setViewpoint(){
        mapView.setViewpoint(AGSViewpoint(center: Storage.shared.point, scale: 30000000))
    }*/
}
