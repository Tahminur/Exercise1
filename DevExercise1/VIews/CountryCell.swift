//
//  CountryCell.swift
//  DevExercise1
//
//  Created by Tahminur Rahman on 6/22/20.
//  Copyright © 2020 Tahminur Rahman. All rights reserved.
//

import UIKit
import ArcGIS

class CountryCell: UITableViewCell {
    
    var point:AGSPoint = AGSPoint(x: 0, y: 0, spatialReference: .wgs84())
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    
    func set(country: Country){
        self.textLabel!.text = "\(country.name) : \(country.cases)"
        point = country.point
    }
    
    
}
