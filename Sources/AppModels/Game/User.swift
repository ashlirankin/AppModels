//
//  User.swift
//  AppModels
//
//  Created by Ashli Rankin on 2/21/25.
//

import Foundation

/// Represents a user in the word search game.
/// This struct contains basic user information and implements Firebase-compatible encoding/decoding.
public struct User: Codable, Identifiable, Equatable, Sendable {
    
    /// Keys used for encoding and decoding user data to/from Firebase.
    enum CodingKeys: CaseIterable, CodingKey {
        /// The unique identifier for the user
        case id
        /// The display name of the user
        case name
    }
    
    /// The unique identifier for this user.
    public let id: String
    
    /// The display name of the user.
    public let name: String
    
    /// Creates a new user instance.
    /// - Parameters:
    ///   - id: The unique identifier for the user
    ///   - name: The display name of the user
    public init(id: String, name: String) {
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
