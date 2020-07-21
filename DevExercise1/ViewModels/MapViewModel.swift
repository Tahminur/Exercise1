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
    
    var map:AGSMap
    
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
            //check network connectivity and throw if no internet
            map.operationalLayers.removeAllObjects()
            addFeaturesToMap()
        } else {
            print("DEBUG: refresh not called")
        }
        
        
    }
    
    //this function still shows the developer watermark
    func showMap(){
        let map2 = AGSMap(url: URL(fileURLWithPath: "https://www.arcgis.com/home/item.html?id=bbb2e4f589ba40d692fab712ae37b9ac"))
        self.map = map2!
        print(map.operationalLayers.count)
    }
    
    //below needed to get rid of watermark
    func authenticateMap() throws{
        do {
         let result = try AGSArcGISRuntimeEnvironment.setLicenseKey("runtimelite,1000,rud4539920132,none,3M2PMD17J1802J7EZ106")
         print("License Result : \(result.licenseStatus)")
        }
        catch let error as NSError {
         print("error: \(error)")
            throw error
        }
    }
    /*func load() throws{
        self.portal = AGSPortal(url: URL(string: "https://www.arcgis.com")!, loginRequired: false)
         self.portal.load() {[weak self] (error) in
            if let error = error {
                print(error)
            }
                 // check the portal item loaded and print the modified date
            if self?.portal.loadStatus == AGSLoadStatus.loaded {
                if let portalName = self?.portal.portalInfo?.portalName {
                    print(portalName)
                }
            }
        }
    }*/
    
    
}
