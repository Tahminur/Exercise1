//
//  CountryItemViewModel.swift
//  DevExercise1
//
//  Created by Tahminur Rahman on 7/7/20.
//  Copyright © 2020 Tahminur Rahman. All rights reserved.
//

import Foundation
import ArcGIS
/*protocol CountryItemViewModelInput {
    //this fetch is from the variable that will be populated by the api
    func fetch()
}*/

protocol CountryItemViewModelOutput{
    var countryName: String {get}
    var countryCases: Int {get}
    var countryPoint: AGSPoint {get}
}

public struct CountryItemViewModel:CountryItemViewModelOutput{
    let country:Country
    let countryName: String
    var countryCases: Int
    var countryPoint: AGSPoint
    
    init(country:Country){
        self.country = country
        self.countryName = country.name
        self.countryCases = country.cases
        self.countryPoint = country.point
    }
}
