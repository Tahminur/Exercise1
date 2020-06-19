//
//  CountryViewModel.swift
//  DevExercise1
//
//  Created by Tahminur Rahman on 6/18/20.
//  Copyright © 2020 Tahminur Rahman. All rights reserved.
//

import Foundation


struct CountryViewModel {
    let myCountry: Country
    private(set) var name = ""
    private(set) var cases = ""
    
    
    init(myCountry: Country) {
        self.myCountry = myCountry
        updateProperties()
    }
    
    private mutating func updateProperties() {
        name = setName(myCountry: myCountry)
        cases = setCases(myCountry: myCountry)
    }
}

//seperated all my functions for setting into an extension here
extension CountryViewModel{
    private func setName(myCountry: Country) -> String {
        return "\(myCountry.name)"
    }
    
    private func setCases(myCountry: Country) -> String {
        return "Confirmed Cases: \(myCountry.cases)"
    }
    
}

