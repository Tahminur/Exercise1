//
//  MapRepository.swift
//  DevExercise1
//
//  Created by Tahminur Rahman on 8/3/20.
//  Copyright © 2020 Tahminur Rahman. All rights reserved.
//

import Foundation
import ArcGIS

protocol MapRepository{
    func fetch()->[AGSFeatureLayer]
}

public class MapRepositoryImplementation: MapRepository{
    
    private let remoteDataSource:MapRemoteDataSource
    
    public init(remoteDataSource:MapRemoteDataSource){
        self.remoteDataSource = remoteDataSource
    }
    
    public func fetch()->[AGSFeatureLayer]{
        var layers:[AGSFeatureLayer] = []
        for table in remoteDataSource.features{
            layers.append(AGSFeatureLayer(featureTable: table))
        }
        return layers
    }
    
}
