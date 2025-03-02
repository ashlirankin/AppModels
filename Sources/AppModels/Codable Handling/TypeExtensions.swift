//
//  TypeExtensions.swift
//  AppModels
//
//  Created by Ashli Rankin on 3/2/25.
//

import Foundation

// MARK: - String Firebase Support
extension String: FirebaseCodable {
    
    public static var codingKey: FirebaseDataTypes {
        return .stringValue
    }
    
    public static var type: String.Type {
        return String.self
    }
}

// MARK: - Boolean Firebase Support
extension Bool: FirebaseCodable {
    
    public static var codingKey: FirebaseDataTypes {
        return .booleanValue
    }
    
    public static var type: Bool.Type {
        return Bool.self
    }
}

// MARK: - Numeric Firebase Support
extension Int: FirebaseCodable {
    
    public static var codingKey: FirebaseDataTypes {
        return .integerValue
    }
    
    public static var type: Int.Type {
        return Int.self
    }
}

extension Double: FirebaseCodable {
    public static var codingKey: FirebaseDataTypes {
        return .doubleValue
    }
    
    public static var type: Double.Type {
        return Double.self
    }
}

// MARK: - Date Firebase Support
extension Date: FirebaseCodable {
    public static var codingKey: FirebaseDataTypes {
        return .timestampValue
    }
    
    public static var type: Date.Type {
        return Date.self
    }
}

// MARK: - Collection Firebase Support
extension Array where Element: FirebaseCodable {
    public static var dataType: FirebaseDataTypes {
        return .arrayValue
    }
    
    public static var type: Array<Element>.Type {
        return Array<Element>.self
    }
}

// MARK: - Identifier Firebase Support
extension UUID: FirebaseCodable {
    public static var codingKey: FirebaseDataTypes {
        .stringValue
    }
    
    public static var type: UUID.Type {
        UUID.self
    }
}
