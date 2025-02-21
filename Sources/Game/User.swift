//
//  User.swift
//  AppModels
//
//  Created by Ashli Rankin on 2/21/25.
//

import Foundation

public struct User: Codable, Identifiable, Equatable {
    enum CodingKeys: CodingKey {
        case id
        case name
    }
    
    let id: String
    let name: String
    
    init (id: String, name: String) {
        self.id = id
        self.name = name
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        var idContainer = container.nestedContainer(keyedBy: FirebaseDataTypes.self, forKey: .id)
        try idContainer.encode(id, forKey: .stringValue)
        
        var nameContainer = container.nestedContainer(keyedBy: FirebaseDataTypes.self, forKey: .name)
        try nameContainer.encode(self.name, forKey: .stringValue)
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        var idContainer = try container.nestedContainer(keyedBy: FirebaseDataTypes.self, forKey: .id)
        self.id = try idContainer.decode(String.self, forKey: .stringValue)
        
        var nameContainer = try container.nestedContainer(keyedBy: FirebaseDataTypes.self, forKey: .name)
        self.name = try nameContainer.decode(String.self, forKey: .stringValue)
    }
}
