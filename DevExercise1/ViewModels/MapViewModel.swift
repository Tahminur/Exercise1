//
//  MapViewModel.swift
//  DevExercise1
//
//  Created by Tahminur Rahman on 7/6/20.
//  Copyright © 2020 Tahminur Rahman. All rights reserved.
//

import Foundation
import ArcGIS

protocol MapViewModelInput {
    var map:AGSMap {get}
    var featureURLs:[String] {get}
    func addFeaturesToMap()
}


class MapViewModel:MapViewModelInput{
    var featureURLs: [String]
    let map:AGSMap
    
    
    init(map:AGSMap, featureURLs: [String]){
        self.map = map
        self.featureURLs = featureURLs
        self.addFeaturesToMap()
    }
    
    func addFeaturesToMap() {
        for feature in featureURLs{
            let featureTable = AGSServiceFeatureTable(url: URL(string: feature)!)
            map.operationalLayers.add(AGSFeatureLayer(featureTable: featureTable))
        }
    }
}
