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

class MapViewModel: MapViewModelInput {

    private let repository: MapRepository

    init(repository: MapRepository) {
        self.repository = repository
    }

    func retrieveFeatureLayers(completion:@escaping ([AGSFeatureLayer]) -> Void) {
        completion(repository.fetch())
    }
    //Gets rid of watermark
    func licenseMap() throws {
        do {
            try AGSArcGISRuntimeEnvironment.setLicenseKey("runtimelite,1000,rud4539920132,none,3M2PMD17J1802J7EZ106")
        } catch let error as NSError {
            throw error
        }
    }
}
