//
//  CountryMapper.swift
//  DevExercise1
//
//  Created by Tahminur Rahman on 8/3/20.
//  Copyright © 2020 Tahminur Rahman. All rights reserved.
//

import Foundation
import ArcGIS

public protocol CountryMapper {
    func mapToCountry(features: [AGSArcGISFeature]) -> Result<[Country], Error>
}

public class CountryMapperImpl: CountryMapper {

    public func mapToCountry(features: [AGSArcGISFeature]) -> Result<[Country], Error> {
        var countriesToReturn: [Country] = []
        for feature in features {
            guard let name = feature.attributes["Country_Region"] as? String else {
                return .failure(fetchError.errorCasting)
            }
            var point: AGSPoint?
            if feature.geometry == nil {
                point = nil
            } else {
                point = feature.geometry as! AGSPoint
            }
            guard let cases = feature.attributes["Confirmed"] as? Int else {
                return .failure(fetchError.errorCasting)
            }
            let country = Country.init(name: name, cases: cases, point: point)
            countriesToReturn.append(country)
        }
        return .success(countriesToReturn)
    }

}
