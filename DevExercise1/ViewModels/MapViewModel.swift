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
    
    //
    func authenticateMap()
    func LicenseMap() throws
}


class MapViewModel:MapViewModelInput{
    var featureURLs: [String]
    
    var map:AGSMap
    
    var featureTables: [AGSServiceFeatureTable] = []
    
    init(map:AGSMap, featureURLs: [String]){
        self.map = map
        self.featureURLs = featureURLs
        for feature in featureURLs{
            featureTables.append(AGSServiceFeatureTable(url: URL(string: feature)!))
        }
        //self.authenticateMap()
        self.addFeaturesToMap()
        //self.showMap()
    }
    
    func addFeaturesToMap() {
        for feature in featureTables{
            map.operationalLayers.add(AGSFeatureLayer(featureTable: feature))
        
        }
    }
//NOTE: Cannot repull feature layers unless they are gotten rid of first since esri will return an error saying that the object is already owned otherwise. Think of how to add the refresh be it through a boolean flag or call directly Pushed to milestone 3
    func refreshMap(isRefresh:Bool) throws {
        if isRefresh{
            //check network connectivity and throw if no internet
            map.operationalLayers.removeAllObjects()
            addFeaturesToMap()
        } else {
            print("DEBUG: refresh not called")
        }
        
        
    }
    
    //Gets rid of watermark
    func LicenseMap() throws{
        do {
         try AGSArcGISRuntimeEnvironment.setLicenseKey("runtimelite,1000,rud4539920132,none,3M2PMD17J1802J7EZ106")
        }
        catch let error as NSError {
            throw error
        }
    }
    
    //TODO: Add authentication into the map layer. Kinda hacky I feel, plus need to add for when authentication fails don't load in map
    func authenticateMap(){
        let portal = AGSPortal(url: URL(string: "https://www.arcgis.com")!, loginRequired: true)
         portal.load() {(error) in
            if let error = error {
                print(error)
            }
                 // check the portal item loaded and print the modified date
            if portal.loadStatus == AGSLoadStatus.loaded {
                if let portalName = portal.portalInfo?.portalName {
                    print(portalName)
                }
                
            }
        }
    }
    func authenticateMap2(completion:@escaping (String?) -> Void){
        let portal = AGSPortal(url: URL(string: "https://www.arcgis.com")!, loginRequired: true)
        portal.load() { (error) in
            if let error = error {
                completion(error.localizedDescription)
                }
            // check the portal item loaded and print the modified date
                if portal.loadStatus == AGSLoadStatus.loaded {
                    completion(nil)
                }
            }
    }
    
    
    
    
}
