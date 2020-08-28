//
//  MapRemote.swift
//  DevExercise1
//
//  Created by Tahminur Rahman on 8/5/20.
//  Copyright © 2020 Tahminur Rahman. All rights reserved.
//

import Foundation
import ArcGIS

//stores the service feature tables
public class MapRemoteDataSource {
    public let features: [AGSServiceFeatureTable] = [AGSServiceFeatureTable(url: URL(string: "https://services1.arcgis.com/0MSEUqKaxRlEPj5g/arcgis/rest/services/Coronavirus_2019_nCoV_Cases/FeatureServer/2")!),
    AGSServiceFeatureTable(url: URL(string: "https://services1.arcgis.com/0MSEUqKaxRlEPj5g/arcgis/rest/services/Coronavirus_2019_nCoV_Cases/FeatureServer/1")!),
    AGSServiceFeatureTable(url: URL(string: "https://services1.arcgis.com/0MSEUqKaxRlEPj5g/arcgis/rest/services/Coronavirus_2019_nCoV_Cases/FeatureServer/0")!)]
}
