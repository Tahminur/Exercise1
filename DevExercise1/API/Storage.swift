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
    
    func retrieveCountries() -> [Country]
    //func storeQueries(country:Country)
    var features:[Country] {get set}
}


public final class CountryStorage: Storing{
    public static var shared = CountryStorage()
    
    var point:AGSPoint = AGSPoint(x: 133, y: -25, spatialReference: .wgs84())

    func retrieveCountries() -> [Country]{
        return features
    }
    //variable to store features in for now storage does not do anything other than just hold the variables
    var features: [Country] = []
    
}
