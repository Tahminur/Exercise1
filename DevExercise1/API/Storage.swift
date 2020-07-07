//
//  Storage.swift
//  DevExercise1
//
//  Created by Tahminur Rahman on 7/7/20.
//  Copyright © 2020 Tahminur Rahman. All rights reserved.
//

import Foundation
import ArcGIS

protocol Storing{
    var features:[Country] {get}
    
    func storeQueries(country:Country)
}


public final class CountryStorage: Storing{
    public static var shared = CountryStorage()
    
    func storeQueries(country: Country) {
        features.append(country)
    }
    
    //variable to store features in for now storage does not do anything other than just hold the variables
    var features: [Country] = []
    
}
