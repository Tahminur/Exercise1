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
    
    func authenticateMap(completion:@escaping (String?) -> Void)
    func licenseMap() throws
}


class MapViewModel:MapViewModelInput{
    var featureURLs: [String]
    
    var map:AGSMap
    
    var featureTables: [AGSServiceFeatureTable] = []
    
    var point:AGSPoint = AGSPoint(x: 133, y: -25, spatialReference: .wgs84())
    
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
            map.operationalLayers.add(AGSFeatureLayer(featureTable: feature))
        }
    }
    
    //Gets rid of watermark
    func licenseMap() throws{
        do {
            try AGSArcGISRuntimeEnvironment.setLicenseKey("runtimelite,1000,rud4539920132,none,3M2PMD17J1802J7EZ106")
        }
        catch let error as NSError {
            throw error
        }
    }
    
    
    func authenticateMap(completion:@escaping (String?) -> Void){
        let portal = AGSPortal(url: URL(string: "https://www.arcgis.com")!, loginRequired: true)
        portal.load() { (error) in
            if let error = error {
                completion(error.localizedDescription)
            }
            if portal.loadStatus == AGSLoadStatus.loaded {
                completion(nil)
            }
        }
    }
    
    
    
    
}
