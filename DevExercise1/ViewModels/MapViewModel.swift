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
    
    var featureTables: [AGSServiceFeatureTable] = []
    
    init(map:AGSMap, featureURLs: [String]){
        self.map = map
        self.featureURLs = featureURLs
        for feature in featureURLs{
            featureTables.append(AGSServiceFeatureTable(url: URL(string: feature)!))
        }
        self.addFeaturesToMap()
        
    }
    
    func addFeaturesToMap() {
        for feature in featureTables{
            //let featureTable = AGSServiceFeatureTable(url: URL(string: feature)!)
            //map.operationalLayers.add(AGSFeatureLayer(featureTable: featureTable))
            map.operationalLayers.add(AGSFeatureLayer(featureTable: feature))
        
        }
    }
//NOTE: Cannot repull feature layers unless they are gotten rid of first since esri will return an error saying that the object is already owned otherwise. Think of how to add the refresh be it through a boolean flag or call directly
    func refreshMap(isRefresh:Bool) throws {
        if isRefresh{
            map.operationalLayers.removeAllObjects()
            addFeaturesToMap()
            
        } else {
            print("DEBUG: refresh not called")
        }
        
        
    }
}
