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

    //move this to the dependency injection
    var viewModel: MapViewModel!
    var mapView:AGSMapView!
    //MARK:-View setup
    static func create(with viewModel: MapViewModel, mapController: MapControllerFactory) -> MapViewController{
        let view = MapViewController()
        view.viewModel = viewModel
        let mapView = AGSMapView()
        mapView.map = AGSMap(basemap: .darkGrayCanvasVector())
        viewModel.retrieveFeatureLayers(){ layers in
            for layer in layers{
                mapView.map?.operationalLayers.add(layer)
            }
        }
        view.mapView = mapView
        return view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapView.wrapAroundMode = .enabledWhenSupported
        navigationItem.title = "Map"
        view.addSubview(mapView)
        mapView.pin(to: view)
        do{
            try viewModel.licenseMap()
        } catch{
            self.presentAlert(message: "Error with Licensing")
        }
        mapView.reloadInputViews()
        //below is for the method that uses the mapmanager
        //setupMap()
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
        mapView.reloadInputViews()
        //mapView.setViewpoint(AGSViewpoint(center: Storage.shared.point, scale: 30000000))
    }
    func setViewpoint(){
        mapView.setViewpoint(AGSViewpoint(center: Storage.shared.point, scale: 30000000))
    }
}
