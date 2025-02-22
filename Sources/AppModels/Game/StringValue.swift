//
//  StringValue.swift
//  AppModels
//
//  Created by Ashli Rankin on 2/22/25.
//


import Foundation

public struct StringValue: Codable, Sendable {
    public let value: String
    
    enum CodingKeys: CodingKey {
        case value
    }
    
    public init (value: String) {
        self.value = value
    }
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.value = try container.decode(String.self, forKey: .value)
    }
    
    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try valueContainer.encode(value, forKey: .stringValue)
    }
}
