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

protocol CountryStorage {
    func save(name: String)
    func returnCountries()
    var countries: [NSManagedObject] { get set }
}

public class CountryStorageImpl: CountryStorage {

    var countries: [NSManagedObject] = []

    func save(name: String) {

      guard let appDelegate =
        UIApplication.shared.delegate as? AppDelegate else {
        return
      }

      // 1
      let managedContext =
        appDelegate.persistentContainer.viewContext

      // 2
      let entity =
        NSEntityDescription.entity(forEntityName: "Country",
                                   in: managedContext)!

      let country = NSManagedObject(entity: entity,
                                   insertInto: managedContext)

      // 3
      country.setValue(name, forKeyPath: "name")

      // 4
      do {
        try managedContext.save()
        countries.append(country)
      } catch let error as NSError {
        print("Could not save. \(error), \(error.userInfo)")
      }
    }

    func returnCountries() {
        let fetchRequest =
          NSFetchRequest<NSManagedObject>(entityName: "Country")
        guard let appDelegate =
          UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext =
        appDelegate.persistentContainer.viewContext
        //3
        do {
          countries = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
          print("Could not fetch. \(error), \(error.userInfo)")
        }
    }

}
