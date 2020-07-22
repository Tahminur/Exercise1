//
//  Repositories.swift
//  DevExercise1
//
//  Created by Tahminur Rahman on 7/8/20.
//  Copyright © 2020 Tahminur Rahman. All rights reserved.
//

import Foundation
import ArcGIS


//have feature layers also be loaded in here so 


public protocol Repositories{
    func fetch(forceRefresh:Bool, completion: @escaping () -> Void)
}

public class CountryDataRepository : Repositories {
    
    private let remoteDataSource: CountryCasesRemoteDataSource
    
    
    public init(remoteDataSource: CountryCasesRemoteDataSource){
        self.remoteDataSource = remoteDataSource
    }
    
    
    public func fetch(forceRefresh:Bool, completion: @escaping () -> Void) {
        if (forceRefresh){
            remoteDataSource.fetch(){
                completion()
            }
        } else{
            completion()
        }
    }
    
    public func retrieveCountries()->[Country]{
        return remoteDataSource.retrieveCountries()
    }
    
    
    
    fileprivate func pullCountryDataFromRemote(){
        remoteDataSource.fetch(){
            
        }
    }
    
}
