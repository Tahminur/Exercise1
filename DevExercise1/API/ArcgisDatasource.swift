//
//  ArcgisDatasource.swift
//  DevExercise1
//
//  Created by Tahminur Rahman on 7/6/20.
//  Copyright © 2020 Tahminur Rahman. All rights reserved.
//

import Foundation
import ArcGIS
import UIKit

//be it local or remote will have to implement this protocol
public protocol RemoteDataSource {
    
    func fetch(completion:@escaping () -> Void)
    var FeatureTable:AGSServiceFeatureTable {get}
}


public class CountryCasesRemoteDataSource:RemoteDataSource {
    
    let mapper = CountryMapper()
    //add error handling here as well
    var DataRetrieved:[Country] = []
    //
    
    public let FeatureTable: AGSServiceFeatureTable = {
    let countryServiceURL = URL(string: countryURL)!
        return AGSServiceFeatureTable(url: countryServiceURL)
    }()
    
    public func fetch(completion:@escaping () -> Void ) {
        FeatureTable.load { [weak self] (error) in
            
            guard let self = self else { return }

            if let error = error {
                
                print("Error loading Corona Cases feature layer: \(error.localizedDescription)")
                UIAlertController().presentAlert(message: "Error loading Corona Cases feature layer: \(error.localizedDescription)")
                return
            }

            let queryParameters = AGSQueryParameters()
            queryParameters.whereClause = "\(countryNameKey) like '%%'"
            queryParameters.returnGeometry = true

            let outFields: AGSQueryFeatureFields = .loadAll
            self.FeatureTable.queryFeatures(with: queryParameters, queryFeatureFields: outFields) { (result, error) in

                if let error = error {
                    print("Error querying the Corona Cases feature layer: \(error.localizedDescription)")
                    UIAlertController().presentAlert(message: "Error querying the Corona Cases feature layer: \(error.localizedDescription)")
                    return
                }

                guard let result = result, let features = result.featureEnumerator().allObjects as? [AGSArcGISFeature] else {
                    print("Something went wrong casting the results.")
                    UIAlertController().presentAlert(message: "Something went wrong casting the results.")
                    return
                }
                self.DataRetrieved = self.mapper.mapToCountry(features: features)
                completion()

            }
            
        }
    }
}
