//
//  AppDIContainer.swift
//  DevExercise1
//
//  Created by Tahminur Rahman on 7/28/20.
//  Copyright © 2020 Tahminur Rahman. All rights reserved.
//

import Foundation


final class AppDIContainer{
    
    struct Dependencies {
        let countryDataSource: CountryCasesRemoteDataSource
        let mapDataSource: MapRemoteDataSource
    }
    
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies){
        self.dependencies = dependencies
    }
    
    lazy var countryRepository: CountryDataRepository = {
        return CountryDataRepository(remoteDataSource: dependencies.countryDataSource)
    }()
    lazy var mapRepository:MapRepository = {
        return MapRepository(remoteDataSource: dependencies.mapDataSource)
    }()
    
    
    //MARK: - View Models
    func makeCountryCaseViewModels() -> CountryCasesViewModel {
        return CountryCasesViewModel(repository: countryRepository)
    }
    
    
    
    
    
}
