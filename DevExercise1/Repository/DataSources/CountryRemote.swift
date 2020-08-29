//
//  CountryRemote.swift
//  DevExercise1
//
//  Created by Tahminur Rahman on 8/5/20.
//  Copyright © 2020 Tahminur Rahman. All rights reserved.
//

import Foundation
import ArcGIS

public protocol CountryRemoteDataSource {
    func fetch(completion:@escaping (Result<[AGSArcGISFeature], fetchError>) -> Void)
    var featureTable: AGSServiceFeatureTable {get}
    func retrieveCountries() -> [AGSArcGISFeature]
}

public class CountryRemoteDataSourceImpl: CountryRemoteDataSource {

    var dataRetrieved: [AGSArcGISFeature] = []
    //The feature table that will be queried for data
    public var featureTable: AGSServiceFeatureTable = {
    let countryServiceURL = URL(string: "https://services1.arcgis.com/0MSEUqKaxRlEPj5g/arcgis/rest/services/Coronavirus_2019_nCoV_Cases/FeatureServer/2")!
        return AGSServiceFeatureTable(url: countryServiceURL)
    }()

    //fetches the data from the feature table and then runs a query on the fetched data to return agsarcgisfeatures on success and a fetcherror type on failure
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
                completion(.success(features))
            }
        }
    }
//just used to pass queried and fetched features
    public func retrieveCountries() -> [AGSArcGISFeature] {
        return self.dataRetrieved
    }
}