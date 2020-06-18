//
//  DataRetrieval.swift
//  DevExercise1
//
//  Created by Tahminur Rahman on 6/18/20.
//  Copyright © 2020 Tahminur Rahman. All rights reserved.
//

import Foundation
import ArcGIS

let dataRetriever = API()

class API{
    let CasesFeatureTable: AGSServiceFeatureTable = {
        let featureServiceURL = URL(string: featureURL)!
            return AGSServiceFeatureTable(url: featureServiceURL)
        }()

    
    
    //below returns all features in the table must edit it in order to make it so that I can get all of the data from it.
    func queryFeatureLayer() {

        CasesFeatureTable.load { [weak self] (error) in
            
            guard let self = self else { return }

            if let error = error {
                print("Error loading Corona Cases feature layer: \(error.localizedDescription)")
                return
            }

            let queryParameters = AGSQueryParameters()
            queryParameters.whereClause = "\(String.CountryNameKey) like '%%'"
            queryParameters.returnGeometry = true

            let outFields: AGSQueryFeatureFields = .loadAll
            self.CasesFeatureTable.queryFeatures(with: queryParameters, queryFeatureFields: outFields) { (result, error) in

                if let error = error {
                    print("Error querying the Corona Cases feature layer: \(error.localizedDescription)")
                    return
                }

                guard let result = result, let features = result.featureEnumerator().allObjects as? [AGSArcGISFeature] else {
                    print("Something went wrong casting the results.")
                    return
                }
                
                //the features returned is a set of AGSArcGISFeatures that each consist of an attribute field that contains the data for each country. Now you have to format this so that it can be used to show the data in the cases field.
                print("DEBUG: \(features.count)")
                print(features[0].attributes["Country_Region"])
                print(features[0].attributes["Lat"])
                print(features[0].attributes["Long_"])
                print(features[0].attributes["Recovered"])
                print(features[0].attributes["Deaths"])
                print(features[0].attributes["Confirmed"])

            }
        }
    }

}

