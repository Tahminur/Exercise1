//
//  SecureDataStorage.swift
//  DevExercise1
//
//  Created by Tahminur Rahman on 8/20/20.
//  Copyright © 2020 Tahminur Rahman. All rights reserved.
//

import Foundation

public enum SecureDataItem{
    case user, password, token
    var key: String {
        switch self {
        case .user:
            return "user"
        case .password:
            return "password"
        case .token:
            return "token"
        }
    }
}

public protocol SecureStorage {
    func removeAllData() throws
    func retrieve(item: SecureDataItem) throws -> String
    func delete(_ items: SecureDataItem...) throws
    func store(value:String, item: SecureDataItem) throws
    func contains(item: SecureDataItem) -> Bool
}

public enum SecureDataSourceError: Error {
    case nilItem
    case invalidValue
}
extension SecureDataSourceError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .nilItem:
            return "Issue with finding the secure item"
        case .invalidValue:
            return "Issue with a stored secure item"
        }
    }
}


public class SecureDataStorage: SecureStorage {
    
    private let store: SecureStore
    
    init(service: String = "Service"){
        self.store = SecureStore(secureStoreQueryable: GenericSecureStoreQueryable(service: service))
    }
    
    public func removeAllData() throws {
        try store.removeAllValues()
    }
    
    public func retrieve(item: SecureDataItem) throws -> String {
        guard let value = try store.getValue(for: item.key) else {
            throw SecureDataSourceError.nilItem
        }
        return value
    }
    
    public func delete(_ items: SecureDataItem...) throws {
        try items.forEach{
            try store.removeValue(for: $0.key)
        }
    }
    
    public func store(value: String, item: SecureDataItem) throws {
        try store.setValue(value, for: item.key)
    }
    
    public func contains(item: SecureDataItem) -> Bool {
        guard let _ = try? retrieve(item: item) else {
            return false
        }
        return true
    }
}
