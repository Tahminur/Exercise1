//
//  LoginProvider.swift
//  DevExercise1
//
//  Created by Tahminur Rahman on 8/29/20.
//  Copyright © 2020 Tahminur Rahman. All rights reserved.
//

import Foundation
import Moya

public enum LoginProvider {
    //case loginUser
    case login(username: String, password: String)
}

extension LoginProvider: TargetType {
    public var path: String {
        switch self {
        //case .loginUser: return "0MSEUqKaxRlEPj5g/arcgis/rest/services/Coronavirus_2019_nCoV_Cases/FeatureServer/2"
        case .login: return "login"
        }
    }

    public var method: Moya.Method {
        return .post
    }

    public var sampleData: Data {
        let response =
        """
            {
                "token": "The User has been Authenticated Successfully",
                "expires": "12345675643",
                "ssl": true
            }
        """
        return response.data(using: String.Encoding.utf8)!
    }
    public var task: Task {
        switch self {
        case .login(let username, let password):
            //let ub64 = username.utf8

            return .requestCompositeParameters(bodyParameters: ["username": username, "password": password], bodyEncoding: JSONEncoding.default, urlParameters: [:])
        }
    }

    public var headers: [String: String]? {
        switch self {
        case .login:
            return [
                "Content-Type": "application/json"
            ]
        }
    }

    public var baseURL: URL {
        return URL(string: "https://www.arcgis.com")!
    }
}
