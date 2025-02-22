//
//  Word.swift
//  AppModels
//
//  Created by Ashli Rankin on 2/22/25.
//


import Foundation

public struct Word: Codable {
    public let value: String
    
    enum CodingKeys: CodingKey {
        case value
    }
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let valueContainer = try container.nestedContainer(keyedBy: FirebaseDataTypes.self, forKey: .value)
        self.value = try valueContainer.decode(String.self, forKey: .stringValue)
    }
    
    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        var valueContainer = container.nestedContainer(keyedBy: FirebaseDataTypes.self, forKey: .value)
        try valueContainer.encode(value, forKey: .stringValue)
    }
}
