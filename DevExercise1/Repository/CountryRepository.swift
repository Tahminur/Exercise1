//
//  CountryRepository.swift
//  DevExercise1
//
//  Created by Tahminur Rahman on 8/3/20.
//  Copyright © 2020 Tahminur Rahman. All rights reserved.
//

import Foundation
import ArcGIS

public protocol CountryRepository {
    func fetch(forceRefresh: Bool, completion: @escaping (Result<[AGSArcGISFeature], Error>) -> Void)
}

public class CountryRepositoryImpl: CountryRepository {

    private let remoteDataSource: CountryRemoteDataSource
    private let internetConnection: ReachabilityObserverDelegate

    public init(remoteDataSource: CountryRemoteDataSource, internetConnection: ReachabilityObserverDelegate) {
        self.remoteDataSource = remoteDataSource
        self.internetConnection = internetConnection
    }
    
    public func fetch(forceRefresh: Bool, completion: @escaping (Result<[AGSArcGISFeature], Error>) -> Void) {
        if internetConnection.connectionStatus {
            if forceRefresh {
                remoteDataSource.fetch { result in
                    switch result {
                    case .success(let features):
                        completion(.success(features))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            } else {
                let countriesFetched = remoteDataSource.retrieveCountries()
                completion(.success(countriesFetched))
            }
        } else {
            completion(.failure(fetchError.noInternet))
        }
    }
}
