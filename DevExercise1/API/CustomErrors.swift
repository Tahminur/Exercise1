//
//  CustomErrors.swift
//  DevExercise1
//
//  Created by Tahminur Rahman on 7/27/20.
//  Copyright © 2020 Tahminur Rahman. All rights reserved.
//

import Foundation

public enum fetchError: Error{
    case errorLoad
    case errorQuery
    case errorCasting
    case noInternet
}

extension fetchError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .errorLoad:
            return NSLocalizedString("There was a problem loading the countries", comment: "Error Load")
        case .errorQuery:
            return NSLocalizedString("There was a problem querying the countries", comment: "Error Query")
        case .errorCasting:
            return NSLocalizedString("There was a problem casting the countries", comment: "Error Casting")
        case .noInternet:
            return NSLocalizedString("THere was a problem connecting to the internet",comment: "No Internet")
        }
    }        
}
