//
//  CountryCasesViewModel.swift
//  DevExercise1
//
//  Created by Tahminur Rahman on 7/8/20.
//  Copyright © 2020 Tahminur Rahman. All rights reserved.
//

import Foundation

protocol CountryCasesViewModelInput {
    func fetchFromDataSource(forceRefresh: Bool, completion:@escaping (Result<(), Error>) -> Void)
}

protocol CountryCasesViewModelOutput {
    var countries: [CountryItemModel] {get}
}

public final class CountryCasesViewModel: CountryCasesViewModelOutput, CountryCasesViewModelInput {
    var countries: [CountryItemModel] = []

    private let repository: CountryRepository

    public init(repository: CountryRepository) {
        self.repository = repository
    }
    //move reachable internet check here and pass error on failure to after this in the countrycontroller
    func fetchFromDataSource(forceRefresh: Bool, completion:@escaping (Result<(), Error>) -> Void) {
        if forceRefresh {
            countries.removeAll()
            repository.fetch(forceRefresh: forceRefresh) { result in
                switch result {
                case .success(let fetched):
                    for country in fetched {
                        self.countries.append(CountryItemModel(country: country))
                        completion(.success(()))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}
