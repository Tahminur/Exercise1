//
//  CountryCell.swift
//  DevExercise1
//
//  Created by Tahminur Rahman on 6/22/20.
//  Copyright © 2020 Tahminur Rahman. All rights reserved.
//

import UIKit

class CountryCell: UITableViewCell {

    var countryData = UILabel()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        
        addSubview(countryData)
        
        configureLabel()
        
        setLabelConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    
    func set(country: Country){
        countryData.text = "\(country.name) : \(country.cases)"
    }

    func configureLabel() {
        countryData.clipsToBounds = true
        countryData.adjustsFontSizeToFitWidth = true
        
    }
    
    func setLabelConstraints() {
        countryData.translatesAutoresizingMaskIntoConstraints = false
        countryData.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        countryData.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        countryData.heightAnchor.constraint(equalToConstant: 40).isActive = true
        countryData.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
    }
    
    
}
