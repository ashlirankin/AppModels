//
//  StringValue.swift
//  AppModels
//
//  Created by Ashli Rankin on 2/22/25.
//


import Foundation

public struct StringValue: Codable, Sendable {
    
    enum CodingKeys: CodingKey {
        case value
    }
    
    public let value: String
    
    public init (value: String) {
        self.value = value
    }
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        var stringValueContainer = try container.nestedContainer(keyedBy: FirebaseDataTypes.self, forKey: .value)
        self.value = try stringValueContainer.decode(String.self, forKey: .stringValue)
    }
    
    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: FirebaseDataTypes.self)
        try container.encode(value, forKey: .stringValue)
    }
}
