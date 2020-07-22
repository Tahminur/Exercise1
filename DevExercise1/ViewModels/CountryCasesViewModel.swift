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
    func fetchFromDataSource(forceRefresh:Bool, completion:@escaping (String?) -> Void)
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
    
    
    func fetchFromDataSource(forceRefresh:Bool, completion:@escaping (String?) -> Void) {
        if (forceRefresh){
            Countries.removeAll()
            repository.fetch(forceRefresh: forceRefresh){
                for country in self.repository.retrieveCountries(){
                    self.Countries.append(CountryItemViewModel(country: country))
                }
                if self.Countries.count == 0{
                    completion("Error fetching Countries")
                    return
                }
                completion(nil)
                return
            }
        } else{
            completion(nil)
        }
    }
}

