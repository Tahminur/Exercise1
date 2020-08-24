//
//  CustomErrors.swift
//  DevExercise1
//
//  Created by Tahminur Rahman on 7/27/20.
//  Copyright © 2020 Tahminur Rahman. All rights reserved.
//

import Foundation

public enum fetchError: Error {
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
            return NSLocalizedString("There was a problem connecting to the internet", comment: "No Internet")
        }
    }
}

public enum loginError: Error {
    case missingUsername
    case missingPassword
    case incorrectLogin
    case rememberMeMalfunction
    case noInternet
}

extension loginError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .missingPassword:
            return NSLocalizedString("Missing password", comment: "No password")
        case .missingUsername:
            return NSLocalizedString("Missing username", comment: "No username")
        case .incorrectLogin:
            return NSLocalizedString("Your username or password is incorrect", comment: "Incorrect Login")
        case .noInternet:
            return NSLocalizedString("No Internet Connection Found", comment: "No Internet")
        case .rememberMeMalfunction:
            return NSLocalizedString("There was an issue retrieving your remembered credentials from memory", comment: "Remember Me issue")
        }
    }
}
