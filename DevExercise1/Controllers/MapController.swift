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
        //works()
    }

    
    //create arcgis auth challenge delegate and answer challenge with credentials
    
    
    
    func generateWebMap(){
        view.addSubview(mapView)
        mapView.pin(to: view)
        
        //displays map items correctly but does not work for the specified link for some reason
        let portal = AGSPortal(url: URL(string:"https://www.arcgis.com")!, loginRequired: false)
        //change below itemID to bbb2e4f589ba40d692fab712ae37b9ac, but right now there is an invalid response error
        let portalItem = AGSPortalItem(portal: portal, itemID: "7cc54c8def82483193176d3ba0cf7acc")
        map = AGSMap(item: portalItem)
        portal.credential = AGSCredential()
        self.map.load(completion: {[weak self] (error) in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            self?.mapView.map = self?.map
        })
    }
    
    /*
    func works(){
        view.addSubview(mapView)
        mapView.pin(to: view)
        //displays map items correctly but does not work for the specified link for some reason
        let portal = AGSPortal(url: URL(string:"https://www.arcgis.com")!, loginRequired: false)
        //change below itemID to , but right now there is an invalid response error
        let portalItem = AGSPortalItem(portal: portal, itemID: "")
        map = AGSMap(item: portalItem)
        //portal.credential = AGSCredential()
        self.map.load(completion: {[weak self] (error) in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            self?.mapView.map = self?.map
        })
        
    }*/
}


