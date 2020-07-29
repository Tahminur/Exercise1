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

    func licenseMap() throws
}

class MapViewModel:MapViewModelInput{

    private let repository: MapRepository
    
    var featureLayers: [AGSFeatureLayer] = []
    
    var point:AGSPoint = AGSPoint(x: 133, y: -25, spatialReference: .wgs84())
    
    init(repository:MapRepository){
        self.repository = repository
    }
    
    
    func retrieveFeatureLayers(completion:@escaping ([AGSFeatureLayer]) -> Void){
        featureLayers = repository.fetch()
        completion(repository.fetch())
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
}
