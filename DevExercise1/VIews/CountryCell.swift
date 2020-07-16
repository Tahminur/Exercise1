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
        self.textLabel!.textColor = Util().decideColor(caseNumber: country.cases)
        self.textLabel!.textAlignment = .center
        self.textLabel!.font = .systemFont(ofSize: 20)
        self.textLabel!.layer.shadowColor = UIColor.black.cgColor
        self.textLabel!.layer.shadowRadius = 2
        self.textLabel!.layer.shadowOpacity = 0.25
        self.textLabel!.layer.shadowOffset = CGSize(width: 4, height: 4)
        self.textLabel!.layer.masksToBounds = false
        
        
        self.backgroundColor = #colorLiteral(red: 0.8159592152, green: 0.9822254777, blue: 0.9723348022, alpha: 1)
        point = country.point
    }
    
    
}
