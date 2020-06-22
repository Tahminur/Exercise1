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
    func customButton(forCountry: Country) -> UIButton {
        
        let button = UIButton(type: .system)
        let Title = NSMutableAttributedString(string: forCountry.name, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24), NSAttributedString.Key.foregroundColor:UIColor.red])
        button.setAttributedTitle(Title, for: .normal)
        button.backgroundColor = UIColor.red
        
        
        return button
    }
    
    func convertFeatureToCountry(feature: AGSArcGISFeature)->Country{
        let name = feature.attributes["Country_Region"] as! String
        //let lat = feature.attributes["Lat"] as! NSNull
        //let long = feature.attributes["Long_"] as! NSNull
        let cases = feature.attributes["Confirmed"] as! Int
        
        let country = Country.init(name: name, cases: cases)
        return country
    }
    
}
