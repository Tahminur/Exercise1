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
    func licenseMap(completion: @escaping (Result<(), Error>) -> Void)
}

class MapViewModel: MapViewModelInput {

    private let repository: MapRepository

    init(repository: MapRepository) {
        self.repository = repository
    }
//used for fetching layers from repository effectively instantiating them since this will create the operational layers for the map once called in the map controller
    func retrieveFeatureLayers(completion:@escaping ([AGSFeatureLayer]) -> Void) {
        completion(repository.fetch())
    }
    //Gets rid of watermark
    func licenseMap(completion: @escaping (Result<(), Error>) -> Void) {
        do {
            try AGSArcGISRuntimeEnvironment.setLicenseKey("runtimelite,1000,rud4539920132,none,3M2PMD17J1802J7EZ106")
            completion(.success(()))
        } catch let error as NSError {
            completion(.failure(error))
        }
    }

}
