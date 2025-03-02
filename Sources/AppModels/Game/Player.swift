//
//  Player.swift
//  AppModels
//
//  Created by Ashli Rankin on 2/21/25.
//

import Foundation

/// Represents a player in a multiplayer game session.
/// Contains information about the player's user profile, when they joined, and their host status.
public struct Player: Codable, Identifiable, Equatable, Sendable {
   
    /// Keys used for encoding and decoding player data to/from Firebase.
    enum CodingKeys: CodingKey {
        /// The user profile of the player
        case user
        /// When the player joined the game
        case joinedAt
        /// Whether this player is the host
        case isHost
    }
    
    /// The user profile associated with this player.
    public let user: User
    
    /// The timestamp when this player joined the game.
    public let joinedAt: Date
    
    /// Indicates whether this player is the host of the game.
    public let isHost: Bool
    
    /// The unique identifier for this player, derived from their user ID.
    public var id: String {
        return user.id
    }
    
    /// Creates a new player instance.
    /// - Parameters:
    ///   - user: The user profile for this player
    ///   - joinedAt: When the player joined the game
    ///   - isHost: Whether this player is the host
    public init(user: User, joinedAt: Date, isHost: Bool) {
        self.user = user
        self.joinedAt = joinedAt
        self.isHost = isHost
    }
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.user = try container.decode(User.self, forKey: .user)
        self.joinedAt = try container.decode(FirebaseValue<Date>.self, forKey: .joinedAt).value
        self.isHost = try container.decode(FirebaseValue<Bool>.self, forKey: .isHost).value
    }
    
    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(FirebaseValue(value: joinedAt), forKey: .joinedAt)
        try container.encode(FirebaseValue(value: isHost), forKey: .isHost)
        try container.encode(self.user, forKey: .user)
    }
}
