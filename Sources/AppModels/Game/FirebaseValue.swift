//
//  StringValue.swift
//  AppModels
//
//  Created by Ashli Rankin on 2/22/25.
//


import Foundation

public struct FirebaseValue<T: FirebaseCodable>: Sendable, Codable, Equatable {
    
    enum CodingKeys: CodingKey {
        case value
    }

    public let value: T
    
    init(value: T) {
        self.value = value
    }
    
    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: FirebaseDataTypes.self)
        try container.encode(value, forKey: T.dataType)
    }
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: FirebaseDataTypes.self)
        self.value = try container.decode(T.value, forKey: T.dataType)
    }
}

public protocol FirebaseCodable: Sendable, Codable, Equatable  {
    static var dataType: FirebaseDataTypes { get }
    static var value: Self.Type { get }
}
