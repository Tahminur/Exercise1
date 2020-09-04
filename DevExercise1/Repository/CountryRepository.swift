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
    //func fetch(forceRefresh: Bool, completion: @escaping (Result<[AGSArcGISFeature], Error>) -> Void)
    func fetch(forceRefresh: Bool, completion: @escaping (Result<[Country], Error>) -> Void)
    func savingCountries(countries: [Country])
}

public class CountryRepositoryImpl: CountryRepository {

    private let remoteDataSource: CountryRemoteDataSource
    private let localDataSource: CountryLocalDataSource
    private let mapper: CountryMapper
    private let internetConnection: ReachabilityObserverDelegate

    public init(remoteDataSource: CountryRemoteDataSource, localDataSource: CountryLocalDataSource, mapper: CountryMapper, internetConnection: ReachabilityObserverDelegate) {
        self.remoteDataSource = remoteDataSource
        self.localDataSource = localDataSource
        self.mapper = mapper
        self.internetConnection = internetConnection
    }

    public func fetch(forceRefresh: Bool, completion: @escaping (Result<[Country], Error>) -> Void) {
        if internetConnection.connectionStatus {
            if forceRefresh {
                remoteDataSource.fetch { result in
                    switch result {
                    case .success(let features):
                        self.mapper.mapToCountry(features: features) { result in
                            switch result {
                            case .success(let countries):
                                self.savingCountries(countries: countries)
                                completion(.success(countries))
                            case .failure(let error):
                                completion(.failure(error))
                            }
                        }
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            } /*else {
                localDataSource.fetchFromLocal { result in
                    switch result {
                    case .success(let features):
                        self.mapper.mapToCountry(features: features) { result in
                            switch result {
                            case .success(let countries):
                                completion(.success(countries))
                            case .failure(let error):
                                completion(.failure(error))
                            }
                        }
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            }*/
        } else {
            localDataSource.fetchFromLocal { result in
                switch result {
                case .success(let features):
                    self.mapper.mapToCountry(features: features) { result in
                        switch result {
                        case .success(let countries):
                            completion(.success(countries))
                        case .failure(let error):
                            completion(.failure(error))
                        }
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }

    public func savingCountries(countries: [Country]) {
        do {
            try localDataSource.storeCountries(countries: countries)
        } catch let error {
            print(error.localizedDescription)
        }

    }
}
