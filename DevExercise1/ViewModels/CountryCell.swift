//
//  CountryCell.swift
//  DevExercise1
//
//  Created by Tahminur Rahman on 6/22/20.
//  Copyright © 2020 Tahminur Rahman. All rights reserved.
//

import UIKit

class CountryCell: UITableViewCell {

    
    var countryButton = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        
        //addSubview(countryData)
        
        addSubview(countryButton)
        
        configureButton()
        
        setLabelConstraints()
        
    }
    //for handling click action look at centerAtPoint function in arcGIS

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    
    func set(country: Country){
        countryButton.text = "\(country.name) : \(country.cases)"
        countryButton.textColor = .black
        //countryButton.Title()
        //countryButton.setTitleColor(.black, for: .normal)
    }

    func configureButton() {
        countryButton.clipsToBounds = true
    }
    
    func setLabelConstraints() {
        countryButton.translatesAutoresizingMaskIntoConstraints = false
        countryButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        countryButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        countryButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        countryButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        
    }
    
    
}
