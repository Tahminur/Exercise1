//
//  CountryStorage.swift
//  DevExercise1
//
//  Created by Tahminur Rahman on 9/2/20.
//  Copyright © 2020 Tahminur Rahman. All rights reserved.
//

import Foundation
import CoreData
import UIKit

public protocol CountryStorage {
    func save(name: String, cases: Int32) throws
    func retrieveFromStorage(completion: @escaping (Result<[NSManagedObject], Error>) -> Void)
    func deleteEntities() throws
}

public class CountryStorageImpl: CountryStorage {

    var countries: [NSManagedObject] = []

    public func save(name: String, cases: Int32) throws {

        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "CountryData", in: managedContext)!
        let country = NSManagedObject(entity: entity, insertInto: managedContext)

        country.setValue(name, forKeyPath: "name")
        country.setValue(cases, forKey: "cases")

        do {
            try managedContext.save()
            print("saving \(name)")
            countries.append(country)
        } catch let error as NSError {
            throw error
        }
    }

    public func retrieveFromStorage(completion: @escaping (Result<[NSManagedObject], Error>) -> Void) {

        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CountryData")
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        do {
            countries = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            completion(.failure(error))
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        completion(.success(countries))
    }

    public func deleteEntities() throws {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "CountryData")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }

        let managedContext = appDelegate.persistentContainer.viewContext

        do {
            try managedContext.execute(deleteRequest)
        } catch let error as NSError {
            throw error
        }
    }

}
