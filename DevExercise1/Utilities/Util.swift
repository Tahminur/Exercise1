//
//  Util.swift
//  DevExercise1
//
//  Created by Tahminur Rahman on 6/18/20.
//  Copyright © 2020 Tahminur Rahman. All rights reserved.
//

import Foundation
import ArcGIS
import UIKit

class Util{
    //have to add in cases, but make sure it is easily changeable

    func convertFeatureToCountry(feature: AGSArcGISFeature)->Country{
        let name = feature.attributes["Country_Region"] as! String
        let lat = feature.attributes["Lat"] as! NSNumber
        let long = feature.attributes["Long_"] as! NSNumber
        let cases = feature.attributes["Confirmed"] as! Int
        
        let country = Country.init(name: name, cases: cases, latitude: lat, longitude: long)
        return country
    }
    
}
