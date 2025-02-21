//
//  User.swift
//  AppModels
//
//  Created by Ashli Rankin on 2/21/25.
//

import Foundation

public struct User: Codable, Identifiable, Equatable, Sendable {
    enum CodingKeys: CodingKey {
        case id
        case name
    }
    
    public let id: String
    public let name: String
    
    public init (id: String, name: String) {
        self.id = id
        self.name = name
    }
    
    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        var idContainer = container.nestedContainer(keyedBy: FirebaseDataTypes.self, forKey: .id)
        try idContainer.encode(id, forKey: .stringValue)
        
        var nameContainer = container.nestedContainer(keyedBy: FirebaseDataTypes.self, forKey: .name)
        try nameContainer.encode(self.name, forKey: .stringValue)
    }
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let idContainer = try container.nestedContainer(keyedBy: FirebaseDataTypes.self, forKey: .id)
        self.id = try idContainer.decode(String.self, forKey: .stringValue)
        
        let nameContainer = try container.nestedContainer(keyedBy: FirebaseDataTypes.self, forKey: .name)
        self.name = try nameContainer.decode(String.self, forKey: .stringValue)
    }
}
