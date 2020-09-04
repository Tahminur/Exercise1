//
//  CountryCasesViewModel.swift
//  DevExercise1
//
//  Created by Tahminur Rahman on 7/8/20.
//  Copyright © 2020 Tahminur Rahman. All rights reserved.
//

import Foundation
import ArcGIS

protocol CountryCasesViewModel {
    func fetchFromDataSource(forceRefresh: Bool, completion:@escaping (Result<(), Error>) -> Void)
    func fetchFromDataSource2(forceRefresh: Bool, completion:@escaping (Result<(), Error>) -> Void)
    var countries: [CountryItemModel] {get}
}

public final class CountryCasesViewModelImpl: CountryCasesViewModel {
    var countries: [CountryItemModel] = []

    private var point: AGSPoint = AGSPoint(x: 133, y: -25, spatialReference: .wgs84())

    private let repository: CountryRepository
    private let mapper: CountryMapper

    public init(repository: CountryRepository, mapper: CountryMapper) {
        self.repository = repository
        self.mapper = mapper
    }

    func fetchFromDataSource(forceRefresh: Bool, completion:@escaping (Result<(), Error>) -> Void) {
        if forceRefresh {
            countries.removeAll()
            repository.fetch(forceRefresh: forceRefresh) { result in
                switch result {
                case .success(let fetched):
                    switch self.mapper.mapToCountry(features: fetched) {
                    case .success(let countries):
                        for country in countries {
                            self.countries.append(CountryItemModel(country: country))
                                completion(.success(()))
                        }
                    case .failure(let error):
                        completion(.failure(error))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }

    func fetchFromDataSource2(forceRefresh: Bool, completion:@escaping (Result<(), Error>) -> Void) {
        if forceRefresh {
            countries.removeAll()
            repository.newFetch(forceRefresh: forceRefresh) { result in
                switch result {
                case .success(let fetched):
                    //save countries
                    self.repository.savingCountries(countries: fetched)
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

    func setPoint(newPoint: AGSPoint) {
        self.point = newPoint
    }

}
