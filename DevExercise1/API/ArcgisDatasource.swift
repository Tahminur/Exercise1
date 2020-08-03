//
//  ArcgisDatasource.swift
//  DevExercise1
//
//  Created by Tahminur Rahman on 7/6/20.
//  Copyright © 2020 Tahminur Rahman. All rights reserved.
//

import Foundation
import ArcGIS

public protocol RemoteDataSource {

    func fetch(completion:@escaping (Result<[AGSArcGISFeature], fetchError>) -> Void)
    var featureTable: AGSServiceFeatureTable {get}
}

public class CountryCasesRemoteDataSource: RemoteDataSource {

    var dataRetrieved: [AGSArcGISFeature] = []

    public var featureTable: AGSServiceFeatureTable = {
    let countryServiceURL = URL(string: "https://services1.arcgis.com/0MSEUqKaxRlEPj5g/arcgis/rest/services/Coronavirus_2019_nCoV_Cases/FeatureServer/2")!
        return AGSServiceFeatureTable(url: countryServiceURL)
    }()

    //change to propogate errors pass data retrieved to the completion handler, and get rid of the other fetch call in the view model.
    public func fetch(completion:@escaping (Result<[AGSArcGISFeature], fetchError>) -> Void ) {
        featureTable.load { [weak self] (error) in

            guard let self = self else { return }

            if let error = error {

                print("Error loading Corona Cases feature layer: \(error.localizedDescription)")
                completion(.failure(.errorLoad))
                return
            }

            let queryParameters = AGSQueryParameters()
            queryParameters.whereClause = "\("Country_Region") like '%%'"
            queryParameters.returnGeometry = true

            let outFields: AGSQueryFeatureFields = .loadAll
            self.featureTable.queryFeatures(with: queryParameters, queryFeatureFields: outFields) { (result, error) in

                if let error = error {
                    print("Error querying the Corona Cases feature layer: \(error.localizedDescription)")
                    completion(.failure(.errorQuery))
                    return
                }

                guard let result = result, let features = result.featureEnumerator().allObjects as? [AGSArcGISFeature] else {
                    print("Something went wrong casting the results.")
                    completion(.failure(.errorCasting))
                    return
                }
                self.dataRetrieved = features
                completion(.success(features))
            }
        }
    }

    public func retrieveCountries() -> [AGSArcGISFeature] {
        return self.dataRetrieved
    }
}

//The service feature tables are stored here and since this is remote the feature layers will be created in the map repository
public class MapRemoteDataSource {
    public let features: [AGSServiceFeatureTable] = [AGSServiceFeatureTable(url: URL(string: "https://services1.arcgis.com/0MSEUqKaxRlEPj5g/arcgis/rest/services/Coronavirus_2019_nCoV_Cases/FeatureServer/2")!),
    AGSServiceFeatureTable(url: URL(string: "https://services1.arcgis.com/0MSEUqKaxRlEPj5g/arcgis/rest/services/Coronavirus_2019_nCoV_Cases/FeatureServer/1")!),
    AGSServiceFeatureTable(url: URL(string: "https://services1.arcgis.com/0MSEUqKaxRlEPj5g/arcgis/rest/services/Coronavirus_2019_nCoV_Cases/FeatureServer/0")!)]
}
