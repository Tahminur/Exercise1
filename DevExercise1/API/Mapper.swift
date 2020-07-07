//
//  Mapper.swift
//  DevExercise1
//
//  Created by Tahminur Rahman on 7/7/20.
//  Copyright © 2020 Tahminur Rahman. All rights reserved.
//

import Foundation
import ArcGIS


protocol Mapper {
    func mapToCountry(features:[AGSArcGISFeature])->[Country]
}

public final class CountryMapper:Mapper {
    func mapToCountry(features:[AGSArcGISFeature]) -> [Country] {
        var countriesToReturn:[Country] = []
        for feature in features{
            let name = feature.attributes["Country_Region"] as! String
            
            var point: AGSPoint = AGSPoint(x: 133, y: -25, spatialReference: .wgs84())
            
            if feature.geometry != nil{
                point = feature.geometry as! AGSPoint
            }
            
            let cases = feature.attributes["Confirmed"] as! Int
            
            let country = Country.init(name: name, cases: cases, point: point)
            countriesToReturn.append(country)
        }
        return countriesToReturn
    }
}
