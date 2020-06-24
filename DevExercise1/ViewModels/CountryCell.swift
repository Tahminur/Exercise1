//
//  CountryCell.swift
//  DevExercise1
//
//  Created by Tahminur Rahman on 6/22/20.
//  Copyright © 2020 Tahminur Rahman. All rights reserved.
//

import UIKit

class CountryCell: UITableViewCell {
    
    var latitude:NSNumber = 0
    var longitude:NSNumber = 0
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    
    func set(country: Country){
        self.textLabel!.text = "\(country.name) : \(country.cases)"
        latitude = country.latitude
        longitude = country.longitude
    }
    
    
}
