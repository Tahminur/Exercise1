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
    func fetch(forceRefresh: Bool, completion: @escaping (Result<[Country], fetchError>) -> Void)
}

public class CountryRepositoryImplementation: CountryRepository {

    private let remoteDataSource: CountryRemoteDataSource
    private let mapper: CountryMapper
    private let reachable: Reachable

    public init(remoteDataSource: CountryRemoteDataSource, mapper: CountryMapper, reachable: @escaping Reachable) {
        self.remoteDataSource = remoteDataSource
        self.reachable = reachable
        self.mapper = mapper
    }

    //will handle fetching from local or fetching from remote
    public func fetch(forceRefresh: Bool, completion: @escaping (Result<[Country], fetchError>) -> Void) {
        if reachable() {
            if forceRefresh {
                remoteDataSource.fetch { result in
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
                    case .failure(.noInternet):
                        return //never will make it here
                    }
                }
            } else {
                let countriesFetched = self.mapper.mapToCountry(features: remoteDataSource.retrieveCountries())
                completion(.success(countriesFetched))
            }
        } else {
            completion(.failure(.noInternet))
        }
    }
}
