//
//  CountryCasesViewModel.swift
//  DevExercise1
//
//  Created by Tahminur Rahman on 7/8/20.
//  Copyright © 2020 Tahminur Rahman. All rights reserved.
//

import Foundation
import ArcGIS

protocol CountryCasesViewModelInput {
    //this fetch is from the variable that will be populated by the api
    func fetchFromDataSource(forceRefresh:Bool, completion:@escaping () -> Void)
}

protocol CountryCasesViewModelOutput{
    var Countries: [CountryItemViewModel] {get}
}

public final class CountryCasesViewModel:CountryCasesViewModelOutput, CountryCasesViewModelInput{
    var Countries: [CountryItemViewModel] = []
    
    private let repository: CountryDataRepository
    
    public init(repository: CountryDataRepository){
        self.repository = repository
    }
    //TODO:add error handling alerts and tests
    func fetchFromDataSource(forceRefresh:Bool, completion:@escaping () -> Void) {
        if (forceRefresh){
            Countries.removeAll()
            repository.fetch(forceRefresh: forceRefresh){
                //change from append to updata values in country models when positive
                for country in self.repository.returnCountries(){
                    self.Countries.append(CountryItemViewModel(country: country))
                }
                print("Count of fetch from datasource \(self.Countries.count)")
                completion()
            }
        } else{
            completion()
        }
    }
    
    
    
    
    
    
}
