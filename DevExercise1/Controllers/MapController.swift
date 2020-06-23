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

        generateWebMap()
    }
    
    //Old version of loading map that did not work
    /*func loadMap2(){
        view.addSubview(mapView)
        mapView.pin(to: view)
        //map = AGSMap(url: URL(string: "https://www.arcgis.com/home/item.html?id=bbb2e4f589ba40d692fab712ae37b9acx")!)
        
        map = AGSMap(url: URL(string: "https://services1.arcgis.com/0MSEUqKaxRlEPj5g/arcgis/rest/services/Coronavirus_2019_nCoV_Cases/FeatureServer/2")!)
        self.map.load(completion: {[weak self] (error) in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            self?.mapView.map = self?.map
        })
    }*/
    
    func generateWebMap(){
        view.addSubview(mapView)
        mapView.pin(to: view)
        
        //displays map items correctly but does not work for the specified link for some reason
        let portal = AGSPortal(url: URL(string:"https://www.arcgis.com")!, loginRequired: false)
        //change below itemID to bbb2e4f589ba40d692fab712ae37b9ac, but right now there is an invalid response error
        let portalItem = AGSPortalItem(portal: portal, itemID: "bbb2e4f589ba40d692fab712ae37b9ac")
        map = AGSMap(item: portalItem)
        
        self.map.load(completion: {[weak self] (error) in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            self?.mapView.map = self?.map
        })
    }
    
    
}


