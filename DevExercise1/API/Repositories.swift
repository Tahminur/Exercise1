//
//  Repositories.swift
//  DevExercise1
//
//  Created by Tahminur Rahman on 7/8/20.
//  Copyright © 2020 Tahminur Rahman. All rights reserved.
//

import Foundation

public protocol Repositories{
    func fetch(forceRefresh:Bool, completion: @escaping () -> Void)
}

public class CountryDataRepository : Repositories {
    
    private let remoteDataSource: CountryCasesRemoteDataSource
    private let storage: CountryStorage
    
    public init(remoteDataSource: CountryCasesRemoteDataSource, storage: CountryStorage){
        self.remoteDataSource = remoteDataSource
        self.storage = storage
    }
    
    public func fetch(forceRefresh:Bool, completion: @escaping () -> Void) {
        if (forceRefresh){
            pullCountryDataFromRemote()
        } else if (!forceRefresh){
            print("Not forced")
        }
        completion()
    }
    
    public func returnCountries()->[Country]{
        return storage.retrieveCountries()
    }
    
    fileprivate func pullCountryDataFromRemote(){
        remoteDataSource.fetch(){
            self.storage.features = self.remoteDataSource.DataRetrieved
            print("pulled from remote source")
        }
    }
    
}
