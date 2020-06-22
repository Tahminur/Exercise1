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
    }
    
    //shows up with powered by esri but no map data is shown for some reason
    func configureMap() {
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
    }
}


