//
//  DataRetrieval.swift
//  DevExercise1
//
//  Created by Tahminur Rahman on 6/18/20.
//  Copyright © 2020 Tahminur Rahman. All rights reserved.
//

import Foundation
import ArcGIS

let apiManager = API()
var DataRetrieved:[AGSArcGISFeature] = []

class API{
    
    
    
    let CountryFeatureTable: AGSServiceFeatureTable = {
        let countryServiceURL = URL(string: countryURL)!
            return AGSServiceFeatureTable(url: countryServiceURL)
        }()
    
    let DeathsFeatureTable: AGSServiceFeatureTable = {
        let deathsServiceURL = URL(string: deathsURL)!
        return AGSServiceFeatureTable(url: deathsServiceURL)
    }()
    
    let CasesFeatureTable: AGSServiceFeatureTable = {
        let casesServiceURL = URL(string: casesURL)!
        return AGSServiceFeatureTable(url: casesServiceURL)
    }()
    
    func queryFeatureLayer(){
        
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
                DataRetrieved = features
                print("Retrieved \(DataRetrieved.count) layers")
            }
        }
    }

}
