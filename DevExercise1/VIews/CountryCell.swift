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
    
    func set(country: Country){
        self.textLabel!.text = "\(country.name) : \(country.cases)"
        self.textLabel!.textColor = decideColor(caseNumber: country.cases)
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
