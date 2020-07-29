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
    var countries: [CountryItemViewModel] {get}
}

public final class CountryCasesViewModel:CountryCasesViewModelOutput, CountryCasesViewModelInput{
    var countries: [CountryItemViewModel] = []
    
    
    private let repository: CountryDataRepository
    
    public init(repository: CountryDataRepository){
        self.repository = repository
    }
    
    
    func fetchFromDataSource(forceRefresh:Bool, completion:@escaping (String?) -> Void) {
        if (forceRefresh){
            countries.removeAll()
            repository.fetch(forceRefresh: forceRefresh){ result in
                switch result{
                case .success(let fetched):
                    for country in fetched{
                        self.countries.append(CountryItemViewModel(country: country))
                        completion(nil)
                    }
                case .failure(let error):
                    completion(error.localizedDescription)
                }
            }
        }
    }
}
