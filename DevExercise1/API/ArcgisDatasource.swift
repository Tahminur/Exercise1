//
//  ArcgisDatasource.swift
//  DevExercise1
//
//  Created by Tahminur Rahman on 7/6/20.
//  Copyright © 2020 Tahminur Rahman. All rights reserved.
//

import Foundation
import ArcGIS

//be it local or remote will have to implement this protocol
public protocol WritableDataSource {
    
    func fetch(completion: @escaping () -> Void)
}

public protocol ReadableDataSource {
    
    func read(completion: @escaping () -> Void)
}


public class CountryCasesRemoteDataSource: WritableDataSource,ReadableDataSource{
    
    let mapper = CountryMapper()

    public func read(completion: @escaping () -> Void) {
        //
        completion()
    }
    
    //
    private let CountryFeatureTable: AGSServiceFeatureTable = {
    let countryServiceURL = URL(string: countryURL)!
        return AGSServiceFeatureTable(url: countryServiceURL)
    }()
    
    public func fetch(completion: @escaping () -> Void) {
        CountryFeatureTable.load { [weak self] (error) in
            
            guard let self = self else { return }

            if let error = error {
                print("Error loading Corona Cases feature layer: \(error.localizedDescription)")
                return
            }

            let queryParameters = AGSQueryParameters()
            queryParameters.whereClause = "\(countryNameKey) like '%%'"
            queryParameters.returnGeometry = true

            let outFields: AGSQueryFeatureFields = .loadAll
            self.CountryFeatureTable.queryFeatures(with: queryParameters, queryFeatureFields: outFields) { (result, error) in

                if let error = error {
                    print("Error querying the Corona Cases feature layer: \(error.localizedDescription)")
                    return
                }

                guard let result = result, let features = result.featureEnumerator().allObjects as? [AGSArcGISFeature] else {
                    print("Something went wrong casting the results.")
                    return
                }
                //TODO: Figure out where to store
                completion()
            }
            
        }
    }
}
