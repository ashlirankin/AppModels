//
//  TypeExtensions.swift
//  AppModels
//
//  Created by Ashli Rankin on 3/2/25.
//

import Foundation

extension String: FirebaseCodable {
    
    public static var dataType: FirebaseDataTypes {
        return .stringValue
    }
    
    public static var value: String.Type {
        return String.self
    }
}

extension Bool: FirebaseCodable {
    
    public static var dataType: FirebaseDataTypes {
        return .booleanValue
    }
    
    public static var value: Bool.Type {
        return Bool.self
    }
}

extension Int: FirebaseCodable {
    
    public static var dataType: FirebaseDataTypes {
        return .integerValue
    }
    
    public static var value: Int.Type {
        return Int.self
    }
}

extension Date: FirebaseCodable {
    public static var dataType: FirebaseDataTypes {
        return .timestampValue
    }
    
    public static var value: Date.Type {
        return Date.self
    }
}

extension Double: FirebaseCodable {
    public static var dataType: FirebaseDataTypes {
        return .doubleValue
    }
    
    public static var value: Double.Type {
        return Double.self
    }
}

extension Array where Element: FirebaseCodable {
    public static var dataType: FirebaseDataTypes {
        return .arrayValue
    }
    
    public static var value: Array<Element>.Type {
        return Array<Element>.self
    }
}

extension UUID: FirebaseCodable {
    public static var dataType: FirebaseDataTypes {
        .stringValue
    }
    
    public static var value: UUID.Type {
        UUID.self
    }
}
