//
//  CountryProvider.swift
//  DevExercise1
//
//  Created by Tahminur Rahman on 8/6/20.
//  Copyright © 2020 Tahminur Rahman. All rights reserved.
//

import Foundation
import Moya

public enum CountryProvider {
    case getCountries
}

extension CountryProvider: TargetType {
    public var path: String {
        switch self {
        case .getCountries: return ""
        }
    }

    public var method: Moya.Method {
        return .get
    }

    public var sampleData: Data {
        let country =
        """
        {"featureSet":{"features":[{"geometry":{"x":133.000000,"y":-25.000000,"spatialReference":{"wkid":4326,"latestWkid":4326}},"attributes":{"Active":"8462","Confirmed":"19863","Contry_Region":"Australia","Deaths":"255","Last_Update":"2020-08-06 18:35:07 +0000","Lat":"-25","Long_":"133","OBJECTID":"1","Recovered":"11146"}}]}}
        """
        return country.data(using: String.Encoding.utf8)!
    }
    public var task: Task {
        switch self {
        case .getCountries:
            return .requestPlain
        }
    }

    public var headers: [String: String]? {
        return [
            "Content-Type": "application/json"
        ]
    }

    public var baseURL: URL {
        return URL(string: "https://services1.arcgis.com/0MSEUqKaxRlEPj5g/arcgis/rest/services/Coronavirus_2019_nCoV_Cases/FeatureServer/2")!
    }
}
