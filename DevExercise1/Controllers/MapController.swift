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
        /*view.addSubview(mapView)
        map = AGSMap()
        var tiledLayer = AGSArcGISTiledLayer(url: NSURL(string: "https://services.arcgisonline.com/arcgis/rest/services/World_Imagery/MapServer")! as URL)
        var mapLayer = AGSArcGISMapImageLayer(url: NSURL(string: "https://sampleserver6.arcgisonline.com/arcgis/rest/services/Census/MapServer")! as URL)
            
        map.basemap.baseLayers.addObjects(from: [tiledLayer, mapLayer])
        mapView.map = map*/
        
        loadMap()
        
    }
    
    /*func configureMap() {
        let urle = URL(string: "http://services.arcgisonline.com/ArcGIS/rest/services/Canvas/World_Light_Gray_Base/MapServer")
        //let tiledLayer = AGSArcGISTiledLayer(url: urle!)
        //mapView.map?.basemap = tiledLayer
    }*/
    
    //shows up with powered by esri but no map data is shown for some reason
    /*func configureMap() {
        //adds mapView view to the application
        view.addSubview(mapView)
        mapView.pin(to: view)
        
        
        
        map = AGSMap(url: URL(string: mapURL)!)
        map.load { [weak self] (error) in
            
            guard self != nil else { return }

            if let error = error {
                print("Error loading Map layer: \(error.localizedDescription)")
                return
            }
            
        }
    }*/
    
    func loadMap(){
        view.addSubview(mapView)
        mapView.pin(to: view)
        map = AGSMap(url: URL(string: "https://www.arcgis.com/home/item.html?id=bbb2e4f589ba40d692fab712ae37b9acx")!)
        self.map.load(completion: {[weak self] (error) in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            self?.mapView.map = self?.map
        })
    }
}


