//
//  CalloutMapper.swift
//  DevExercise1
//
//  Created by Tahminur Rahman on 8/3/20.
//  Copyright © 2020 Tahminur Rahman. All rights reserved.
//

import Foundation
import ArcGIS

enum MappingErrors: Error {
    case badFeature
    case noFeatures
}
//for some reason some of the features that have a
public protocol CalloutMapper {
    func mapToCallout(feature: [AGSArcGISFeature]) throws -> Callout
}

public class CalloutMapperImplementation: CalloutMapper {

    public func mapToCallout(feature: [AGSArcGISFeature]) throws -> Callout {

        var title: String = ""
        var details: Int = 0

        if feature.count == 0 {
            throw MappingErrors.noFeatures
        }
        if feature[0].attributes["Province_State"] != nil {
            title = feature[0].attributes["Province_State"] as! String
            details = feature[0].attributes["Confirmed"] as! Int
            return Callout(title: title, detail: "\(details) confirmed cases so far!")
        } else if feature[0].attributes["Country_Region"] != nil {
            title = feature[0].attributes["Country_Region"] as! String
            details = feature[1].attributes["Confirmed"] as! Int
            return Callout(title: title, detail: "\(details) confirmed cases so far!")
        }
        throw MappingErrors.badFeature
    }
}
