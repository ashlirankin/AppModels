//
//  User.swift
//  AppModels
//
//  Created by Ashli Rankin on 2/21/25.
//

import Foundation

public struct User: Codable, Identifiable, Equatable, Sendable {
    enum CodingKeys: CaseIterable, CodingKey {
        case id
        case name
    }
    
    public let id: String
    public let name: String
    
    public init (id: String, name: String) {
        self.id = id
        self.name = name
    }
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.id = try container.decode(FirebaseValue<String>.self, forKey: .id).value
        self.name = try container.decode(FirebaseValue<String>.self, forKey: .name).value
    }
    
    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(FirebaseValue<String>(value: id), forKey: .id)
        try container.encode(FirebaseValue<String>(value: name), forKey: .name)
    }
}
