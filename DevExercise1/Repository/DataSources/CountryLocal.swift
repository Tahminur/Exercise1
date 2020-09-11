//
//  CountryLocal.swift
//  DevExercise1
//
//  Created by Tahminur Rahman on 9/2/20.
//  Copyright © 2020 Tahminur Rahman. All rights reserved.
//

import Foundation
import CoreData
import UIKit

public protocol CountryLocalDataSource {
    func storeCountries(countries: [Country]) throws
    func fetchFromLocal(completion: @escaping (Result<[NSManagedObject], Error>) -> Void)
    var countries: [NSManagedObject] { get set }
}

public class CountryLocalDataSourceImpl: CountryLocalDataSource {

    private let countryStorage: CountryStorage
    public var countries: [NSManagedObject] = []

    public init(countryStorage: CountryStorage) {
        self.countryStorage = countryStorage
    }

    public func storeCountries(countries: [Country]) throws {
        //delete all entities within table originally to make room for new data
        do {
            try countryStorage.deleteEntities()
        } catch {
            throw error
        }

        for country in countries {
            do {
                try countryStorage.save(name: country.name, cases: Int32(country.cases))
            } catch {
                throw error
            }
        }
    }

    public func fetchFromLocal(completion: @escaping (Result<[NSManagedObject], Error>) -> Void) {
        countryStorage.retrieveFromStorage { result in
            switch result {
            case .success(let retrieved):
                completion(.success(retrieved))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
