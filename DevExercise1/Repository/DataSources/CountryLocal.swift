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
    func storeCountries()
    func retrieveFromLocal()
    var countries: [NSManagedObject] { get set }
}

//need to move app delegate somewhere else like the container class
public class CountryLocalDataSourceImpl: CountryLocalDataSource {
    public var countries: [NSManagedObject] = []

    //below is code to be used to grab sata from object when putting into table rows
    //cell.textLabel?.text =
    //person.value(forKeyPath: "name") as? String
    public func storeCountries() {
        <#code#>
    }

    public func retrieveFromLocal() {
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
