//
//  AppDIContainer.swift
//  DevExercise1
//
//  Created by Tahminur Rahman on 7/28/20.
//  Copyright © 2020 Tahminur Rahman. All rights reserved.
//

import Foundation

public typealias Reachable = () -> Bool

final class AppDIContainer {

    lazy var countryDataSource: CountryCasesRemoteDataSource = {
        return CountryCasesRemoteDataSource()
    }()

    lazy var mapDataSource: MapRemoteDataSource = {
        return MapRemoteDataSource()
    }()

    lazy var internetCheck: Reachable = {
        guard let r = Reachability() else {return false}
        return r.isReachable
    }

    lazy var calloutMapper: CalloutMapper = {
        return CalloutMapperImplementation()
    }()

    lazy var countryMapper: CountryMapper = {
        return CountryMapperImplemetation()
    }()

    lazy var countryRepository: CountryRepository = {
        return CountryRepositoryImplementation(remoteDataSource: countryDataSource, mapper: countryMapper, reachable: internetCheck)
    }()
    lazy var mapRepository: MapRepository = {
        return MapRepositoryImplementation(remoteDataSource: mapDataSource)
    }()

    lazy var countryContainer: CountryDIContainer = {
        let dependencies = CountryDIContainer.Dependencies(countryRepo: countryRepository)
        return CountryDIContainer(dependencies: dependencies)
    }()

    lazy var mapContainer: MapDIContainer = {
        let dependencies = MapDIContainer.Dependencies(mapRepo: mapRepository, calloutMapper: calloutMapper)
        return MapDIContainer(dependencies: dependencies)
    }()

}
