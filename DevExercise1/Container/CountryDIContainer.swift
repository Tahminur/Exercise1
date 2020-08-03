//
//  CountryDIContainer.swift
//  DevExercise1
//
//  Created by Tahminur Rahman on 7/28/20.
//  Copyright © 2020 Tahminur Rahman. All rights reserved.
//

import Foundation

protocol CountryControllerFactory{
    
}

final class CountryDIContainer:CountryControllerFactory{
    
    struct Dependencies {
        let countryRepo:CountryRepository
    }
    
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies){
        self.dependencies = dependencies
    }
    
    func makeCountryViewModel() -> CountryCasesViewModel{
        return CountryCasesViewModel(repository: dependencies.countryRepo)
    }
    
    func makeCountryController() -> CountryController {
        return CountryController.create(with: makeCountryViewModel(), countryController: self)
    }
    
}
