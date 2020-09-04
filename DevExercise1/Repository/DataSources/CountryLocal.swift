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
    func retrieveFromLocal() -> [NSManagedObject]
    func fetchFromLocal(completion: @escaping (Result<[NSManagedObject], Error>) -> Void)
    var countries: [NSManagedObject] { get set }
}

//need to move app delegate somewhere else like the container class
public class CountryLocalDataSourceImpl: CountryLocalDataSource {

    private let countryStorage: CountryStorage
    public var countries: [NSManagedObject] = []

    public init(countryStorage: CountryStorage) {
        self.countryStorage = countryStorage
    }
    //below is code to be used to grab sata from object when putting into table rows
    //cell.textLabel?.text =
    //person.value(forKeyPath: "name") as? String
    public func storeCountries(countries: [Country]) throws {
        for country in countries {
            do {
                try countryStorage.save(name: country.name, cases: Int32(country.cases))
            } catch {
                throw error
            }
        }
    }
    //with completion
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
//withoutcompletion
    public func retrieveFromLocal() -> [NSManagedObject] {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CountryData")
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return []
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        do {
            countries = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return countries
    }

}
