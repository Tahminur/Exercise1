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
    //below variable to be changed
    private let reachable: Reachable

    public init(remoteDataSource: CountryRemoteDataSource, reachable: @escaping Reachable) {
        self.remoteDataSource = remoteDataSource
        self.reachable = reachable
    }
    //will handle fetching from local or fetching from remote
    public func fetch(forceRefresh: Bool, completion: @escaping (Result<[AGSArcGISFeature], Error>) -> Void) {
        if reachable() {
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
