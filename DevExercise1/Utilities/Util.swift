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
    //change this function to remove lat and long since the center at viewpoint actually uses the ags poing coordinate and not the lat or long

    func convertFeatureToCountry(feature: AGSArcGISFeature)->Country{
        let name = feature.attributes["Country_Region"] as! String
        
        var point: AGSPoint = AGSPoint(x: 133, y: -25, spatialReference: .wgs84())
        
        if feature.geometry != nil{
            point = feature.geometry as! AGSPoint
        }
        
        let cases = feature.attributes["Confirmed"] as! Int
        
        let country = Country.init(name: name, cases: cases, point: point)
        return country
    }
    
    
    func decideColor(caseNumber: Int) -> UIColor{
        switch caseNumber {
        case 0..<2000:
            return #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        case 2001..<8000:
            return #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
            
        default:
            return #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        }
    }
    
}
