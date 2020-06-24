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
    
    
    let CasesFeatureTable: AGSServiceFeatureTable = {
        let featureServiceURL = URL(string: featureURL)!
            return AGSServiceFeatureTable(url: featureServiceURL)
        }()

    
    func queryFeatureLayer(){
        
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
                DataRetrieved = features
            }
        }
    }
    
    
    func retrieveFeatureLayer() -> AGSFeatureLayer {
        //effectively nil at first so have to assign after loading table only do this because of completion block invoked by load
        var newLayer:AGSFeatureLayer = AGSFeatureLayer(featureTable: CasesFeatureTable)
        CasesFeatureTable.load { [weak self] (error) in
        
        guard let self = self else { return }

        if let error = error {
            print("Error loading Corona Cases feature layer: \(error.localizedDescription)")
            return
        }
            newLayer.clearSelection()
            newLayer = AGSFeatureLayer(featureTable:self.CasesFeatureTable)
        }
        return newLayer
    }

}
