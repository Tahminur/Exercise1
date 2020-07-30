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

    var viewModel: MapViewModel!
    var mapView:AGSMapView = AGSMapView()
    var map:AGSMap!
    //MARK:-View setup
    static func create(with viewModel: MapViewModel, mapController: MapControllerFactory) -> MapViewController{
        let view = MapViewController()
        view.viewModel = viewModel
        let map = AGSMap(basemap: .darkGrayCanvasVector())
        viewModel.retrieveFeatureLayers(){layers in
            for layer in layers{
                map.operationalLayers.add(layer)
            }
        }
        view.map = map
        return view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(mapView)
        self.mapView.pin(to: view)
        navigationItem.title = "Map"
        self.mapView.map = self.map
        do{
            try viewModel.licenseMap()
        } catch{
            self.presentAlert(message: "Error with Licensing")
        }
        //below is for the method that uses the mapmanager
        //setupMap()
    }
    /*func setupMap(){
        DispatchQueue.main.async {
            self.view.addSubview(self.mapView)
            self.mapView.pin(to: self.view)
            MapManager.shared.refreshMap(on: self.mapView, then: nil)
        }
    }*/
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setViewpoint()
    }
    func setViewpoint(){
        mapView.setViewpoint(AGSViewpoint(center: Storage.shared.point, scale: 30000000))
    }
}
