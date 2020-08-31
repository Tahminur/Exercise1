//
//  MapRepository.swift
//  DevExercise1
//
//  Created by Tahminur Rahman on 8/3/20.
//  Copyright © 2020 Tahminur Rahman. All rights reserved.
//

import Foundation
import ArcGIS

protocol MapRepository {
    func fetch() -> [AGSFeatureLayer]
    func licenseMap() throws
}

public class MapRepositoryImpl: MapRepository {

    private let remoteDataSource: MapRemoteDataSource

    public init(remoteDataSource: MapRemoteDataSource) {
        self.remoteDataSource = remoteDataSource
    }
//converts the featuretables into featurelayers
    public func fetch() -> [AGSFeatureLayer] {
        var layers: [AGSFeatureLayer] = []
        for table in remoteDataSource.features {
            layers.append(AGSFeatureLayer(featureTable: table))
        }
        return layers
    }

    func licenseMap() throws {
        do {
            try AGSArcGISRuntimeEnvironment.setLicenseKey("runtimelite,1000,rud4539920132,none,3M2PMD17J1802J7EZ106")
        } catch let error as NSError {
            throw error
        }
    }
}
