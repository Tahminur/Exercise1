//
//  CountryDIContainer.swift
//  DevExercise1
//
//  Created by Tahminur Rahman on 7/28/20.
//  Copyright © 2020 Tahminur Rahman. All rights reserved.
//

import Foundation

final class CountryDIContainer {

    struct Dependencies {
        let countryRepo: CountryRepository
        let countryMapper: CountryMapper
    }

    private let dependencies: Dependencies

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }

    func makeCountryViewModel() -> CountryCasesViewModel {
        return CountryCasesViewModelImpl(repository: dependencies.countryRepo, mapper: dependencies.countryMapper)
    }

    func makeCountryController() -> CountryController {
        return CountryController.create(with: makeCountryViewModel())
    }

}
