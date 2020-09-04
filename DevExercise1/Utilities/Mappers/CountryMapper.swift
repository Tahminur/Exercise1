//
//  CountryMapper.swift
//  DevExercise1
//
//  Created by Tahminur Rahman on 8/3/20.
//  Copyright © 2020 Tahminur Rahman. All rights reserved.
//

import Foundation
import ArcGIS
import CoreData

public protocol CountryMapper {
    func mapToCountry(features: [AGSArcGISFeature], completion: @escaping ((Result<[Country], Error>) -> Void))
    func mapToCountry(features: [NSManagedObject], completion: @escaping ((Result<[Country], Error>) -> Void))
}

public class CountryMapperImpl: CountryMapper {

    public func mapToCountry(features: [AGSArcGISFeature], completion: @escaping ((Result<[Country], Error>) -> Void)) {
        var countriesToReturn: [Country] = []
        for feature in features {
            guard let name = feature.attributes["Country_Region"] as? String else {
                completion(.failure(fetchError.errorCasting))
                return
            }
            var point: AGSPoint?
            if feature.geometry == nil {
                point = nil
            } else {
                point = feature.geometry as! AGSPoint
            }
            guard let cases = feature.attributes["Confirmed"] as? Int else {
                completion(.failure(fetchError.errorCasting))
                return
            }
            let country = Country.init(name: name, cases: cases, point: point)
            countriesToReturn.append(country)
        }
        completion(.success(countriesToReturn))
    }

    public func mapToCountry(features: [NSManagedObject], completion: @escaping ((Result<[Country], Error>) -> Void)) {
        var countriesToReturn: [Country] = []
        for feature in features {
            guard let name = feature.value(forKeyPath: "name") as? String else {
                //change below to error local fetch
                completion(.failure(fetchError.errorCasting))
                return
            }
            guard let cases = feature.value(forKeyPath: "cases") as? Int else {
                completion(.failure(fetchError.errorCasting))
                return
            }
            //change the below point to
            let country = Country(name: name, cases: cases, point: AGSPoint(x: 133, y: -25, spatialReference: .wgs84()))
            countriesToReturn.append(country)
        }
        completion(.success(countriesToReturn))
    }
}
