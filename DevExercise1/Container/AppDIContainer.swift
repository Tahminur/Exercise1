//
//  AppDIContainer.swift
//  DevExercise1
//
//  Created by Tahminur Rahman on 7/28/20.
//  Copyright © 2020 Tahminur Rahman. All rights reserved.
//

import Foundation
import ArcGIS

public typealias Reachable = () -> Bool

final class AppDIContainer {
    //data storage
    lazy var countryStorage: CountryStorage = {
        return CountryStorageImpl()
    }()
    //datasources
    lazy var countryRemoteDataSource: CountryRemoteDataSource = {
        return CountryRemoteDataSourceImpl()
    }()
    lazy var countryLocalDataSource: CountryLocalDataSource = {
       return CountryLocalDataSourceImpl(countryStorage: countryStorage)
    }()
    lazy var mapDataSource: MapRemoteDataSource = {
        return MapRemoteDataSource()
    }()
    lazy var userRemote: UserRemoteDataSource = {
        return UserRemoteDataSourceImpl()
    }()
    lazy var secureStorage: SecureStorage = {
        return SecureDataStorage()
    }()
    lazy var userLocal: UserLocalDataSource = {
        return UserLocalDataSourceImpl(secure: secureStorage)
    }()
    //Internet checker
    let internetConnectivity: ReachabilityObserverDelegate = {
        return InternetConnectivity()
    }()
    //mappers
    lazy var calloutMapper: CalloutMapper = {
        return CalloutMapperImpl()
    }()
    lazy var countryMapper: CountryMapper = {
        return CountryMapperImpl()
    }()
    //repositories
    lazy var countryRepository: CountryRepository = {
        return CountryRepositoryImpl(remoteDataSource: countryRemoteDataSource, localDataSource: countryLocalDataSource, mapper: countryMapper, internetConnection: internetConnectivity)
    }()
    lazy var mapRepository: MapRepository = {
        return MapRepositoryImpl(remoteDataSource: mapDataSource)
    }()
    lazy var userRepository: UserRepositoryImpl = {
        return UserRepositoryImpl(userRemote: userRemote, userLocal: userLocal, internetConnection: internetConnectivity)
    }()
    //containers
    lazy var countryContainer: CountryDIContainer = {
        let dependencies = CountryDIContainer.Dependencies(countryRepo: countryRepository, countryMapper: countryMapper)
        return CountryDIContainer(dependencies: dependencies)
    }()

    lazy var mapContainer: MapDIContainer = {
        let dependencies = MapDIContainer.Dependencies(mapRepo: mapRepository, calloutMapper: calloutMapper)
        return MapDIContainer(dependencies: dependencies)
    }()

    lazy var userContainer: UserDIContainer = {
        let dependencies = UserDIContainer.Dependencies(userRepo: userRepository)
        return UserDIContainer(dependencies: dependencies)
    }()

}
