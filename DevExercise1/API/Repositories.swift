//
//  Repositories.swift
//  DevExercise1
//
//  Created by Tahminur Rahman on 7/8/20.
//  Copyright © 2020 Tahminur Rahman. All rights reserved.
//

import Foundation
import ArcGIS


//have feature layers also be loaded in here so 


public protocol Repositories{
    func fetch(forceRefresh:Bool, completion: @escaping (Result<[Country],fetchError>) -> Void)
}

public class CountryDataRepository : Repositories {
    
    private let remoteDataSource: CountryCasesRemoteDataSource
    private let mapper = CountryMapper()
    
    public init(remoteDataSource: CountryCasesRemoteDataSource){
        self.remoteDataSource = remoteDataSource
    }
    
    //will handle fetching from local or fetching from remote
    public func fetch(forceRefresh:Bool, completion: @escaping (Result<[Country],fetchError>) -> Void) {
        if (forceRefresh){
            remoteDataSource.fetch(){ result in
                switch result {
                case .success(let features):
                    let countriesFetched = self.mapper.mapToCountry(features: features)
                    completion(.success(countriesFetched))
                case .failure(.errorCasting):
                    completion(.failure(.errorCasting))
                case .failure(.errorQuery):
                    completion(.failure(.errorQuery))
                case .failure(.errorLoad):
                    completion(.failure(.errorLoad))
                }
            }
        } else{
            let countriesFetched = self.mapper.mapToCountry(features: remoteDataSource.retrieveCountries())
            completion(.success(countriesFetched))
        }
    }
}

public class MapRepository{
    
    private let remoteDataSource:MapRemoteDataSource
    private var features: [AGSFeatureLayer] = []
    
    public init(remoteDataSource:MapRemoteDataSource){
        self.remoteDataSource = remoteDataSource
        features = fetch()
    }
    
    public func fetch()->[AGSFeatureLayer]{
        var layers:[AGSFeatureLayer] = []
        for table in remoteDataSource.features{
            layers.append(AGSFeatureLayer(featureTable: table))
        }
        return layers
    }
    
    
}
