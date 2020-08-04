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
}
//for some reason some of the features that have a
public protocol CalloutMapper {
    func mapToCallout(feature: [AGSArcGISFeature]) throws -> Callout
}

public class CalloutMapperImplementation: CalloutMapper {
    /*public func mapToCallout(feature:[AGSArcGISFeature]) throws -> Callout {
        if !(feature[0].attributes["Province_State"] is NSNull){
            let title:String = feature[0].attributes["Province_State"] as! String
            let details:Int = feature[0].attributes["Confirmed"] as! Int
            
            return Callout(title: title, detail: "\(details)")
        }
        if !(feature[0].attributes["Country_Region"] is NSNull){
            let title:String = feature[0].attributes["Country_Region"] as! String
            let details:Int = feature[0].attributes["Confirmed"] as! Int
            return Callout(title: title, detail: "\(details)")
        }
        throw MappingErrors.badFeature
        
    }*/
    public func mapToCallout(feature: [AGSArcGISFeature]) throws -> Callout {
        var detail: String? = feature[0].attributes["Province_State"] as? String
        var cases: Int? = feature[0].attributes["Confirmed"] as? Int
        var country: String? = feature[0].attributes["Country_Region"] as? String
        print("the province state: \(String(describing: detail)). cases: \(String(describing: cases)). country: \(String(describing: country))")
        return Callout(title: "Testing", detail: "the province state: \(String(describing: detail)). cases: \(String(describing: cases)). country: \(String(describing: country))")

    }
}
